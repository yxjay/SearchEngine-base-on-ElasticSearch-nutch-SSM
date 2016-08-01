package com.yxj.service;

import java.util.List;

import com.yxj.model.TblKeyword;
import com.yxj.model.TblWord;

public interface TblKeywordService {
	int insert(TblKeyword record);
	List<TblKeyword> findByLike(String word);
	List<TblWord> getRelative(String word);
	String getIDByName(String word);
}
