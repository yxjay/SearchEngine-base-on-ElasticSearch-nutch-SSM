package com.yxjay.adapter;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormat {
	public static String Exchange(long l){
		String time="";
		Date date = new Date(l);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd H:m:s");
		time = format.format(date);
		return time;
	}
	public static void main(String[] args) {
		long l =  1464729702919l;
		System.out.println(Exchange(l));
	}

}
