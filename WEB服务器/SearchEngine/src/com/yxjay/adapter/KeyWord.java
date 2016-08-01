package com.yxjay.adapter;

public class KeyWord {
	private int id;
	private String keyword;
	
	@Override
	public String toString() {
		return "KeyWord [id=" + id + ", keyword=" + keyword + "]";
	}

	public KeyWord(int id, String keyword) {
		super();
		this.id = id;
		this.keyword = keyword;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	

}
