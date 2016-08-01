package com.yxj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.yxj.mapper.TblWordMapper;
import com.yxj.model.TblWord;
import com.yxj.service.TblWordService;

@Component
public class TblWordServiceImpl implements TblWordService{
	@Resource 
	private TblWordMapper tblWordMapper;
	@Override
	public List<TblWord> findByLike(String word){
		return tblWordMapper.findByLike(word);
	}

}
