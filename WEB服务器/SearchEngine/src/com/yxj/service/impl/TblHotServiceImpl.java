package com.yxj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.yxj.mapper.TblHotMapper;
import com.yxj.model.TblHot;
import com.yxj.model.ViewHot;
import com.yxj.service.TblHotService;

@Component
public class TblHotServiceImpl implements TblHotService{
	@Resource 
	private TblHotMapper tblHotmapper;
	@Override
	public int insert(int id){
		return tblHotmapper.insert(id);
	}

}
