package com.yxj.service;

import java.util.List;

import com.yxj.model.TblWord;

public interface TblWordService {
	List<TblWord> findByLike(String word);
}
