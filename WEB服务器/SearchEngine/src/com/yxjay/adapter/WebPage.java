package com.yxjay.adapter;

public class WebPage {
	private Integer id;
	private String baseUrl;
	private Long fetchTime;
	private String typ;
	private String text;
	private String title;
	private String content;
	
		
	@Override
	public String toString() {
		return "WebPage [id=" + id + ", baseUrl=" + baseUrl + ", fetchTime="
				+ fetchTime + ", typ=" + typ + ", text=" + text + ", title="
				+ title + ", content=" + content + "]";
	}

	public WebPage(){
		super();
	}
	
	public WebPage(Integer id, String baseUrl, Long fetchTime, String typ,
			String text, String title) {
		super(); 
		this.id = id;
		this.baseUrl = baseUrl;
		this.fetchTime = fetchTime;
		this.typ = typ;
		this.text = text;
		this.title = title;
	}
	

	public WebPage(Integer id, String baseUrl, Long fetchTime, String typ,
			String text, String title, String content) {
		super();
		this.id = id;
		this.baseUrl = baseUrl;
		this.fetchTime = fetchTime;
		this.typ = typ;
		this.text = text;
		this.title = title;
		this.content = content;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getBaseUrl() {
		return baseUrl;
	}

	public void setBaseUrl(String baseUrl) {
		this.baseUrl = baseUrl;
	}

	public long getFetchTime() {
		return fetchTime;
	}

	public void setFetchTime(long fetchTime) {
		this.fetchTime = fetchTime;
	}

	public String getTyp() {
		return typ;
	}

	public void setTyp(String typ) {
		this.typ = typ;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
