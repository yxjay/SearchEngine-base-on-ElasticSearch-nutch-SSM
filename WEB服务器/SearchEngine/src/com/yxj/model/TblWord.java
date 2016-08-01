package com.yxj.model;

public class TblWord {
    private String word;

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word == null ? null : word.trim();
    }
}