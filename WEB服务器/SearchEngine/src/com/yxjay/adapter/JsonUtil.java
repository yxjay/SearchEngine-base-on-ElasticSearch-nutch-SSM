package com.yxjay.adapter;

import java.io.IOException;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;

public class JsonUtil {
	public static String WebPage2JsonDataPage(WebPage webpage){
		String jsonData = null;
		try{
			XContentBuilder jsonBuild = XContentFactory.jsonBuilder();
			jsonBuild.startObject()
			.field("id",webpage.getId())
			.field("baseUrl",webpage.getBaseUrl())
			.field("typ",webpage.getTyp())
			.field("text",webpage.getText())
			.field("title",webpage.getTitle())
			.endObject();			
			jsonData = jsonBuild.string();
			//System.out.println("aaaaa"+jsonData);
		}catch(IOException e){
			e.printStackTrace();
		}
		return jsonData;
	}
	public static String WebPage2JsonDataShot(WebPage webpage){
		String jsonData = null;
		if(webpage == null)
			return null;
		String fetchtime = DateFormat.Exchange(webpage.getFetchTime());
		try{
			XContentBuilder jsonBuild = XContentFactory.jsonBuilder();
			jsonBuild.startObject()
			.field("id",webpage.getId())
			.field("fetchTime",fetchtime)
			.field("title",webpage.getTitle())
			.field("content",webpage.getContent())
			.endObject();			
			jsonData = jsonBuild.string();
			//System.out.println("aaaaa"+jsonData);
		}catch(IOException e){
			e.printStackTrace();
		}
		return jsonData;
	}
}
