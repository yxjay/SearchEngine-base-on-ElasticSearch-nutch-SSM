<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%	String input = request.getParameter("searchIpt");
	 %>
<%	int pagecount = 10; %>
<%  int showpagecount = 7; %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后. -->
    <title>站内全文搜索引擎</title>
    <!-- Bootstrap -->
    <link href="../css/bootstrap.css" rel="stylesheet">
    <!-- External CSS -->
    <link href="../css/common.css" ref="stylesheet">
    <link href="../css/yxjay.css" ref="stylesheet">
    <script src="../js/jquery-1.9.0.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script>
      var g_page = 1;
          
     $(function(){
     	$("ul li").click(function(){
     		$(this).siblings('li').removeClass('active');
     		$(this).addClass('active');
     	})
     })
     //初始化页面           
     function init_frm(){
     	//alert("<%=input%>");
     	if(null!="<%=input%>" && "null"!="<%=input%>")
     	{
     		$("#searchIpt").val("<%=input%>");
     		//document.title="<%=input%>"+"_搜索结果";
     	}
     	//$(".pagetag1").focus();
     	$("#pagebody").hide();
     	
     	searchCore();
     }
     
     //输入联想模块
      function change() {
    	  var searchIpt = $("#searchIpt").val();
      	  $.ajax({       
              type:"post",
  			  url:"../handlers/searchReminder?strInput="+searchIpt,// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(json){
				 var obj = eval(json);
				 $("#tbcontent").html(""); //删除原有数据
				 //alert(obj[0].name);
		         if (obj != "") {
		         	var length = $(obj).length >=5?5:$(obj).length;
		             for (var i = 0; i < length; i++) {
		                 $("#tbcontent").append('<div onclick="mousedown(this)">' + obj[i].name + '</div>');
		             }
		             $("#tbcontent").slideDown();
		         }
			  }	
		  });
      }
      //热门搜索
      function hotsearch(){
    	  var searchIpt = $("#searchIpt").val();
      	  $.ajax({       
              type:"post",
  			  url:"../handlers/HotSearch",// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(json){
				 var obj = eval(json);
				 
				 //alert(obj[0].name);
		         if (obj != "") {
		         	 $("#hotsearch li").remove(); //删除原有数据
		             for (var i = 0; i < $(obj).length; i++) {
		                 $("#hotsearch").append('<li class="list-group-item"><a href="#" onclick="labelsearch(this)">'+obj[i].name +'</a></li>');
		             }
		         }
		      }	
		  });   	
      }
      
      //相关搜索
      function relativesearch(){
    	  var searchIpt = $("#searchIpt").val();
      	  $.ajax({       
              type:"post",
  			  url:"../handlers/relativeSearch?strInput="+searchIpt,// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(json){
				 var obj = eval(json);
				 
				 //alert(obj[0].name);
		         if (obj != "") {
		         	 //删除原有数据
		         	 $("#relativebody").show();
		         	 for(var i = 1;i<=6;++i)
		         	 {
		         	 	$("#rlt"+i).html("");				
		         	 }
		         	 for(var i = 1;i<=$(obj).length;++i)
		         	 {
		         	 	$("#rlt"+i).text(obj[i-1].name);				
		         	 }/*end of for*/
		         }/*if (obj != "") */
		         if($(obj).length==0)
		         {
		         	$("#relativebody").hide();
		         }
		       }
		  });      	
      }
      //热门搜索区和相关搜索区监听事件
      function labelsearch(obj){
      	//获得当前标签的内容
      	var labelvalue = $(obj).html();
      	//alert(labelvalue);
      	//设置输入框内容
      	$("#searchIpt").val(labelvalue);
      	//触发搜索事件
      	searchCore();
      }
      
      //分页区监听
      function pagesearch(obj){
      	//获得当前页码
      	var page = $(obj).html();
      	//备份到全局变量中
      	g_page = page;
      	pageupdown();
      	//触发搜索事件
      	searchCore(page);
      
      }
      //上下页功能
      function pageupdown(flag){
		var i = g_page;
      	if(flag == "left" || flag == 0)
      	{
      		if(g_page > 1)
      		{
      			g_page--;
      			$('#pageinside li').remove();
      		}
      		else
      			return;
      		i=g_page;
      	}
      	else if(flag == "right" || flag == 1)
      	{
      		g_page++;
      	}
      	if(parseInt(g_page) ==  1)
      		$("#pageinside").append('<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
      	else
      		$("#pageinside").append('<li><a href="#" onclick="pageupdown(0)" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');		
      	var ends =  parseInt(<%=showpagecount%>)+ parseInt(i);
		//alert("i="+i+",ends="+ends);
      	for(i;i<ends;i++)
      	{
      		if(i != g_page)
      			$("#pageinside").append('<li><a href="#" onclick="pagesearch(this)">'+i+'</a></li>');
      		else
      			$("#pageinside").append('<li class="active"><a href="#" onclick="pagesearch(this)">'+i+'</a></li>');
		}

      	$("#pageinside").append('<li><a href="#" onclick="pageupdown(1)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	
		searchCore(g_page);
      }
      
      //设置分页
      function setpage(totalpages,page){
      	var totalpage = parseInt(totalpages);
      	var currentpage = parseInt(page);
      	if(totalpage>0 && page >0)
      	{
      		$("#pagebody").show();
      		$('#pageinside li').remove();
      		var nspace = totalpage-currentpage><%=showpagecount%>?<%=showpagecount%>:totalpage-page;
      		var nleft = <%=showpagecount%> -nspace;
      		var i = currentpage-nleft;
      		var ends = currentpage+nspace;
      		//alert("nspace="+nspace+",nleft="+nleft+",i="+i+",ends="+ends);
      		if(parseInt(currentpage) != 1)
      			$("#pageinside").append('<li><a href="#" onclick="pageupdown(0)" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
      		else
      			$("#pageinside").append('<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>');
      		
      		
      		for(i;i<ends;i++)
      		{
      			if(i != currentpage)
      				$("#pageinside").append('<li><a href="#" onclick="pagesearch(this)">'+i+'</a></li>');
      			else
      				$("#pageinside").append('<li class="active"><a href="#" onclick="pagesearch(this)">'+i+'</a></li>');
      				
      		}
      		$("#pageinside").append('<li><a href="#" onclick="pageupdown(1)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
      	}
      	else
      	{ 		
      		$("#pagebody").hide();
      	}
      }
      //搜索按钮
      function searchCore(pageno) {
      	  var page = pageno;
    	  var searchIpt = $("#searchIpt").val().trim();
		  var pagecounts = <%=pagecount%>;					//每页显示个数
    	  if(searchIpt == null || searchIpt=="")
    	  	return;
    	  if(null == page)
    	  	page = 1;
    	  if(searchIpt != null && searchIpt!="")	
    	  {
    	  	document.title=searchIpt+"_搜索结果";
    	  }
      	  $.ajax({       
              type:"post",
  			  url:"../handlers/searchCore?strInput="+searchIpt+"&pagecount="+pagecounts+"&page="+page,// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(jsondata){
			    var json = eval(jsondata);
			    var counts = $(json).length;
			    var totalcounts = json[counts-1].baseUrl;
			    var totalpages = Math.ceil(totalcounts/pagecounts);		//总页数
			  	//alert(jsondata);
			  	
			  	//设置结果区页头的搜索信息
			  	$("#searchInfo").html("");
			  	//alert("为您找到相关的结果"+json[counts-1].baseUrl+"条(用时"+json[counts-1].fetchTime/1000+"秒)");
			  	$("#searchInfo").append("为您找到相关的结果"+json[counts-1].baseUrl+"条(用时"+parseInt(json[counts-1].typ)/1000+"秒)");		//搜索相关信息设置
				//alert(json[counts-1].baseUrl);
				if(json[counts-1].baseUrl==0)
				{	
					$("#webpagebody").html(""); //删除原有数据
					$("#webpagebody").append('<h1><font color="#F00">暂无匹配信息！</font></h1>');
          			$("#webpagebody").append('<h1><font color="#F00">广告位招租，详情请咨询：13625062505</font></h1>');	
				}
				//设置分页信息
				//if(g_page != page)
				setpage(totalpages,page);
				
				//设置热门区
				hotsearch();
				
				//设置相关搜索区
				relativesearch();
				
				//设置结果区的信息
				
		         if (json[counts-1].baseUrl>0) {
		         	$("#webpagebody").html(""); //删除原有数据
		             for (var i = 0; i < counts-1; i++) {
		             	 $("#webpagebody").append('<div class="list-group"><div class="list-group-item">'+
		             	 '<h4 class="list-group-item-heading"><a target="_blank" href="'+json[i].baseUrl+'">'+json[i].title+'</a></h4>'+
		             	 '<p class="list-group-item-text">'+json[i].text+'<br>'+
		             	 '<font color="#339900">'+json[i].baseUrl+'</font>&nbsp;&nbsp;&nbsp;'+
		             	 '<font color="#999999">-</font>&nbsp;'+
		             	 '<a target="_blank" href="pageshot.jsp?id='+json[i].id+'"><u><font color="#999999">快照</font></u></a>'+
		             	 '</p></div></div>');       		                  
		             }	           
		         }
		        // alert("ok");
			  },  
			  error:function(json){
			  	$("#webpagebody").html(""); //删除原有数据
			    $("#webpagebody").append('<h1><font color="#F00">网络连接失败！</font></h1>');
          		$("#webpagebody").append('<h1><font color="#F00">广告位招租，详情请咨询：13625062505</font></h1>');			  
			    $("#pagebody").hide();
			  }	
		  });
      }      
      //选择其中的提示内容
      function mousedown(object) {
          var a = $(object).text();
          $("#searchIpt").val(a);
          $("#tbcontent").fadeOut();
      }
      //文档框失去焦点，隐藏提示内容
      function lost() {
          $("#tbcontent").fadeOut();
      }	
    </script>   
  </head>
  <body class="k-body"  onload="init_frm()">
  	<div class="main-content">
		<div>
	      <nav>
	      <div class="container-fluid">
	        <!-- Brand and toggle get grouped for better mobile display -->
	        <div class="navbar-header">
	          <a class="logo"  href="begin.jsp"><img width="100" height="42" src="../img/logo.png" alt="JASO" /></a>
	        </div>
	
	        <!-- Collect the nav links, forms, and other content for toggling -->
	        <div class="collapse navbar-collapse navbar-responsive-collapse" id="#">
	          <form class="navbar-form navbar-left">
	            <div class="form-group">
	              <input id="searchIpt" onkeyup="change()" onblur="lost()" type="text" class="form-control searchIpt" maxlength="100" size="60">
	            </div>
	            <a  class="btn btn-search" id="search" onclick="searchCore()">搜索</a> <!-- searchCore() -->
	            <div id="tbcontent" class="tbcontent"></div>
	            
	          </form>
	
	          <ul class="nav navbar-nav navbar-right" id="navbarlist">
	            <li><a href="begin.jsp">首页</a></li>
	            <li class="dropdown">
	              <a href="#" data-toggle="dropdown" class="dropdown-toggle uname">设置 <span class="caret"></span></a>
	                <ul class="dropdown-menu">
	                  <li><a href="#">搜索设置</a></li>
	                  <li><a href="#">高级搜索</a></li>
	                  <li><a href="#">搜索历史</a></li>
	                </ul>
	            </li>
	          </ul>
	        </div><!-- /.navbar-collapse -->
	      </div><!-- /.container-fluid -->
	      </nav>
	    </div>

	    <!--搜索类型栏-->
	    <div>
      <nav class="navbar-default">
      <div class="container-fluid">
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="navbar-collapse">
          <ul class="nav navbar-nav left-30" id="navlist">
            <li>&nbsp;&nbsp;&nbsp;&nbsp;</li>
            <li class="active"><a id="bar_page" href="#">网页 <span class="sr-only">(current)</span></a></li>
            <li><a id="bar_image" href="#">图片</a></li>
            <li><a id="bar_video" href="#">视频</a></li>
            <li><a id="bar_doc" href="#">文档</a></li>
            <li><a id="bar_more" href="#">更多</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
      </nav>
    </div>

	    <!--主题框架-->
	 <div>
      <!--网页展示区-->
      <div class="panel-main">    
        <div class="panel panel-default">
          <div class="panel-heading" id ="searchInfo"></div>
          <div class="panel-body" id="webpagebody">
          	<h1><font color="#F00">搜索中！</font></h1>
          	<h1><font color="#F00">广告位招租，详情请咨询：13625062505</font></h1>
             </div>           
          </div>
        </div>
      </div>    
      <!--右侧工具栏区-->
      <!--热门搜索-->
      <div style="margin-left: 80%;margin-right:25px;padding-top:1px;">
      <div class="">
        <div class="panel panel-default">
          <div class="panel-heading">热门搜索<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="">
            <!-- List group -->
            <ul class="list-group" id="hotsearch">
              <li class="list-group-item"><a id="hot1" href="#" onclick="labelsearch(this)">集美大学</a></li>
              <li class="list-group-item"><a id="hot2" href="#" onclick="labelsearch(this)">计算机工程学院</a></li>
            </ul> 
          </div>
        </div>
      </div>
      <!--大家都在搜-->
   <!--   <div class="">
        <div class="panel panel-default">
          <div class="panel-heading">大家都在搜<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="panel-body">
            <ul class="list-group">
              <li class="list-group-item"><a href="#">集美大学</a></li>
              <li class="list-group-item"><a href="#">计算机工程学院</a></li>
            </ul>        
          </div>
        </div>
      </div>-->
      </div>  
      <div class="clearfix"></div>   
    </div>

	 <!--相关搜索-->
	 <div class="panel-main" id="relativebody">    
      <div class="panel panel-default">
        <div class="panel-heading">相关搜索<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>
          <div class="panel-body"> 
              <table class="table" id="relativebody">
                <tr>
                  <td><a id="rlt1" href="#" onclick="labelsearch(this)">集美大学分数线</a></td>
                  <td><a id="rlt2" href="#" onclick="labelsearch(this)">华侨大学</a></td>
                  <td><a id="rlt3" href="#" onclick="labelsearch(this)" >集美大学诚毅学院</a></td>
                </tr>
                <tr>
                  <td><a id="rlt4" href="#" onclick="labelsearch(this)">集美大学教务处</a></td>
                  <td><a id="rlt5" href="#" onclick="labelsearch(this)">厦门大学</a></td>
                  <td><a id="rlt6" href="#" onclick="labelsearch(this)">厦门理工学院</a></td>
                </tr>                                
              </table>             
          </div>
      </div>
    </div> 
 
	    <!--分页-->
	    <div>
      <div class="panel-center" id="pagebody">
        <div class="panel panel-default">
          <nav> 
            <ul class="pagination" id="pageinside">
              <li ><a href="#" onclick="pageupdown('left')" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
	          <li class="active"><a href="#" onclick="pagesearch(this)">1</a></li>
	          <li><a href="#" onclick="pagesearch(this)">2</a></li>  
	          <li><a href="#" onclick="pagesearch(this)">3</a></li>  
	          <li><a href="#" onclick="pagesearch(this)">4</a></li>    
	          <li><a href="#" onclick="pagesearch(this)">5</a></li>    
	          <li><a href="#" onclick="pagesearch(this)">6</a></li>    
	          <li><a href="#" onclick="pagesearch(this)">7</a></li>     
              <li><a href="#" onclick="pageupdown('right')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>          
            </ul>
          </nav>
        </div>
      </div>  
      <div class="clearfix"></div>    
    </div>
   </div>
    <!--页脚-->
    <!--  <div class="footer-class" id="footer"> 
      <p>©2016  版权所有 Email:yxjay@163.com</p>
    </div>
    -->
    <!--<footer id="footer" class="tc">Copyright © 版权所有 Email:yxjay@163.com</footer>-->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>-->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    
  </body>
</html>
