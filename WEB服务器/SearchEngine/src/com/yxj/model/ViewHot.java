package com.yxj.model;

public class ViewHot {
    private String hotword;

    public String getHotword() {
        return hotword;
    }

    public void setHotword(String hotword) {
        this.hotword = hotword == null ? null : hotword.trim();
    }
}