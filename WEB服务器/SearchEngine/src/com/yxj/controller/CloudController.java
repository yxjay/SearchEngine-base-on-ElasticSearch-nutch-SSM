 package com.yxj.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import static org.elasticsearch.node.NodeBuilder.nodeBuilder;

import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
//import org.elasticsearch.common.settings.ImmutableSettings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.node.Node;

import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.action.fieldstats.FieldStats.Text;
import org.elasticsearch.action.index.IndexRequestBuilder;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.index.query.MultiMatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.highlight.HighlightField;
import org.elasticsearch.common.text.*;

import com.mysql.jdbc.Blob;
import com.yxj.model.TblHot;
import com.yxj.model.TblKeyword;
import com.yxj.model.TblWord;
import com.yxj.service.TblHotService;
import com.yxj.service.TblKeywordService;

import com.yxj.model.ViewHot;
import com.yxj.service.ViewHotService;

import com.yxjay.adapter.*;

@Controller
@RequestMapping(value = "/handlers", produces = "text/html;charset=UTF-8")
public class CloudController {
	@Resource 
	private TblKeywordService tblKeywordService;
	@Resource 
	private ViewHotService viewHotService;
	@Resource
	private TblHotService tblHotService;
	
	public static int MAXTEXTLENGTH = 200;
	public static String SERVERIP = "192.168.252.4";
	public static int PORT = 8888;
	public static String URL="";
	public static int PageCounts = 10;
	List<String> listsession = new ArrayList<String>();				//记录当前会话的关键字
	Map<Integer,WebPage> mapcache = new HashMap<Integer,WebPage>();	//记录当前页面的数据缓存
	//关键字管理模块
	public void KeyWordManage(String strInput)
	{
		System.out.println("input length is :"+strInput.length());
		if(strInput.length()>1 && strInput.length()<10)
		{
			if(!listsession.contains(strInput))
			{
				System.out.println(strInput+"为本次会话的首次查询！");
				listsession.add(strInput);
				
				int id;
				String strid;
				TblKeyword tblkeyword = new TblKeyword();
				//查询tbl_keyword表
				strid = tblKeywordService.getIDByName(strInput);
				
				//若不存在于tbl_keyword表，则创建
				if(null == strid)
				{
					tblkeyword.setId(0);
					tblkeyword.setWord(strInput);
					tblKeywordService.insert(tblkeyword);
					strid = tblKeywordService.getIDByName(strInput);
					System.out.println(strInput+"不存在于关键表，现已添加入关键表tbl_keyword！");
				}
				id = Integer.parseInt(strid);
				//为tbl_hot添加一条记录				
				tblHotService.insert(id);
				System.out.println(strInput+"已增加一条查询记录！");
			}
			else
			{
				System.out.println(strInput+"非本次会话的首次查询！");
			}
		}		
	}
	//搜素联想模块
	@RequestMapping("/searchReminder")
	public @ResponseBody String SearchReminder(String strInput) throws UnsupportedEncodingException{
		strInput = new String(strInput.getBytes("iso-8859-1"),"utf-8");
		
		System.out.println("-------------------------"+strInput);
		if(null==strInput||"".equals(strInput)){
			return null;
		}else{
			List<TblKeyword> tblKeyword = tblKeywordService.findByLike(strInput);
			System.out.println("==========TblKeyword:"+tblKeyword+"==========size:"+tblKeyword.size());
			String json = "[";
			if(tblKeyword.size()==0){			 
				return null;
	        }else{
	    	   for(TblKeyword a:tblKeyword){				 				 
				     System.out.println("    "+a.getWord());
				     json = json+"{'name':'"+a.getWord()+"'},";
				 }
				 String json1 = json.substring(0,json.length()-1)+"]";
				 System.out.println("==========json:"+json1);	
				 return json1;	    	   
	       }
		}				
	}
	//热门搜索模块
	@RequestMapping("/HotSearch")
	public @ResponseBody String HotSearch() throws NullPointerException{
		List<ViewHot> viewHot = viewHotService.TopHot();
		System.out.println("==========HotSearch:"+viewHot+"==========size:"+viewHot.size());
		String json = "[";
		if(viewHot.size()==0){			 
			return null;
	    }else{
	    	for(ViewHot a:viewHot){				 				 
	    	System.out.println("    "+a.getHotword());
			json = json+"{'name':'"+a.getHotword()+"'},";
			}
			String json1 = json.substring(0,json.length()-1)+"]";
			System.out.println("====HotSearch======json:"+json1);	
			return json1;	    	   
	   }
	}
	//相关搜索模块
	@RequestMapping("/relativeSearch")
	public @ResponseBody String RelativeSearch(String strInput) throws UnsupportedEncodingException{
		strInput = new String(strInput.getBytes("iso-8859-1"),"utf-8");
		System.out.println("----relativeSearch:input-----"+strInput);
		if(null==strInput||"".equals(strInput)){
			return null;}
			
		List<TblWord> relativeword = tblKeywordService.getRelative(strInput);
		System.out.println("==========relativeword:"+relativeword+"==========size:"+relativeword.size());
		String json = "[";
		if(relativeword.size()==0){			 
			return null;
	    }else{
	    	for(TblWord a:relativeword){				 				 
	    	System.out.println("    "+a.getWord());
			json = json+"{'name':'"+a.getWord()+"'},";
			}
			String json1 = json.substring(0,json.length()-1)+"]";
			System.out.println("====relativeword======json:"+json1);	
			return json1;	    	   
	   }
	
	}
	
	
	//搜索模块
	@RequestMapping("/searchCore")
	public @ResponseBody String SearchCore(String strInput,int pagecount,int page) throws IOException, SQLException, InterruptedException{
		String strInput2 = new String(strInput.getBytes("iso-8859-1"),"utf-8");
		strInput = strInput2;
		if(null == strInput || strInput == "")
			return null;
		//关键字管理模块
		PageCounts = pagecount;
		KeyWordManage(strInput);
		List <String> list = new ArrayList<String>();
		String jsonData = "[";
		//Node node = nodeBuilder().clusterName("elasticsearch").client(true).build();
		long begintime = System.currentTimeMillis();  
		Settings settings = Settings.settingsBuilder()
				.put("path.home", "/")
				.put("cluster.name","elasticsearch").build();	
		
		TransportClient client = TransportClient.builder().settings(settings).build();
		client.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(SERVERIP),
				9300));
		
		 MultiMatchQueryBuilder query = QueryBuilders.multiMatchQuery(strInput, "text","title"); 
		SearchResponse response = client.prepareSearch("nutch")
				.setTypes("webpage")
				.setSearchType(SearchType.DFS_QUERY_THEN_FETCH)
				.setQuery(query/*QueryBuilders.termQuery("_all","集美大学")*/)
				.setFrom((page-1)*pagecount).setSize(pagecount).setExplain(true)
				.execute()
				.actionGet();
		
		SearchHits hits = response.getHits();
		System.out.println("检索到的总记录数为："+hits.getTotalHits());
		SearchHit[] searchHits = hits.getHits();
		
		String data="";		
		int i=0;
		StringDigest.setDigestCountLimit(MAXTEXTLENGTH);		//设置摘要显示的字数
		if(searchHits.length>0){
			mapcache.clear();
			for(SearchHit hit:searchHits){
				Integer id = i++;
				String baseUrl = (String)hit.getSource().get("baseUrl");
				Long fetchTime = (Long)hit.getSource().get("fetchTime");
				String typ = (String)hit.getSource().get("typ");
				String text = (String)hit.getSource().get("text");
				text = StringDigest.Digest(text, strInput);	//对文本内容采取摘要算法
				String title = (String)hit.getSource().get("title");
				String content = (String)hit.getSource().get("content");
				//content = Base64.getFromBASE64(content);

				//设置高亮
				text = HighLighterCode.Change(text, strInput);
				title = HighLighterCode.Change(title, strInput);
				WebPage webpage = new WebPage(id,baseUrl,fetchTime,typ,text,title,content);
				mapcache.put(id, webpage);
				data = JsonUtil.WebPage2JsonDataPage(webpage);

				list.add(data);	
				jsonData= jsonData+data+",";
				System.out.println("WebPage [分数 = "+hit.getScore()+ ", baseUrl=" + baseUrl +  ", typ=" + typ + ", text=" + text + ", title="
				+ title + "]");
			}
		}
			
		long usetime = System.currentTimeMillis()-begintime;  
		System.out.println("search use time:" + usetime + " ms");  
		//下标0用来存储特殊信息
		int getresult = (int) hits.getTotalHits();
		String sres = String.format("%d", getresult);
		String susetime = String.format("%d", usetime);
		data = JsonUtil.WebPage2JsonDataPage(new WebPage(getresult,sres,(long) 0,susetime,"",""));
		System.out.println("=========="+data+"==========");
		jsonData= jsonData+data+",";
		
		jsonData = jsonData.substring(0,jsonData.length()-1)+"]";
		System.out.println("=========="+jsonData);
//		return json;

		System.out.println("------------------------");
		
		client.close();			//关闭客户端
		return jsonData;
		
	}
	
	//网页设置模块
	@RequestMapping("/webSetting")
	public @ResponseBody String WebSetting(String rightcode,String url) throws UnknownHostException, IOException{
		url = new String(url.getBytes("iso-8859-1"),"utf-8");
		System.out.println("----websetting:rightcode-----"+rightcode);
		System.out.println("----websetting:url-----"+url);
		if(null==url||"".equals(url)){
			return null;}
		Pattern pattern = Pattern.compile("([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}");	
		Matcher matcher = pattern.matcher(url);
		boolean flag= matcher.matches();
		String json=null;
		if(rightcode.equals("YXJA-YXJA") && flag){
			if(URL.equals(url))
				json = "[{result:'repeatcommit'}]";	
			else
			{	
				//绑定服务器
				Socket client = new Socket(SERVERIP,PORT);
				//得到socket读写流
				OutputStream os = client.getOutputStream();
				PrintWriter pw = new PrintWriter(os);
				//输入流
				InputStream is = client.getInputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(is));
				//对socket进行读写操作
				pw.write(url);
				pw.flush();
				client.shutdownOutput();
				//关闭资源
				br.close();
				is.close();
				pw.close();
				os.close();
				client.close();
				URL = url;
				json = "[{result:'ok'}]";	
				
			}
	    }else{	
	    	if(!rightcode.equals("YXJA-YXJA"))
	    		json = "[{result:'noright'}]";
	    	else if(!flag)
	    		json = "[{result:'wrongurl'}]";
	    	else
	    		json = "[{result:'error'}]";
    	   
	   }
		System.out.println("====websetting======json:"+json);	
		return json;
	
	}
	//快照模块
	@RequestMapping("/pageShot")
	public @ResponseBody String GetPageShot(int id) throws UnknownHostException, IOException{
		System.out.println("----pageShot:id-----"+id);
		String json="";
		WebPage webpage = mapcache.get(id);
		System.out.println(JsonUtil.WebPage2JsonDataShot(webpage));
		json = "["+JsonUtil.WebPage2JsonDataShot(webpage)+"]";
		System.out.println(json);
		return json;
	
	
	}
}
