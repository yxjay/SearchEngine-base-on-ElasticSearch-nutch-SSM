package com.yxj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.yxj.mapper.TblKeywordMapper;
import com.yxj.model.TblKeyword;
import com.yxj.model.TblWord;
import com.yxj.service.TblKeywordService;

@Component
public class TblKeywordServiceImpl implements TblKeywordService{
	@Resource 
	private TblKeywordMapper tblKeywordmapper;
	@Override
	public int insert(TblKeyword record){
		return tblKeywordmapper.insert(record);
	}
	@Override
	public List<TblKeyword> findByLike(String word){
		return tblKeywordmapper.findByLike(word);
	}
	@Override
	public List<TblWord> getRelative(String word){
		System.out.println("impl:"+word);
		return tblKeywordmapper.getRelative(word);
	}
	@Override
	public String getIDByName(String word){
		System.out.println("impl:"+word);
		return tblKeywordmapper.getIDByName(word);
	}	
	

}
