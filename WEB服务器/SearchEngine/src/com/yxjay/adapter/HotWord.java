package com.yxjay.adapter;

public class HotWord {
	private int id;
	private String timestamp;
	
	@Override
	public String toString() {
		return "HotWord [id=" + id + ", timestamp=" + timestamp + "]";
	}

	public HotWord(int id, String timestamp) {
		super();
		this.id = id;
		this.timestamp = timestamp;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
}
