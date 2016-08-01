package com.yxj.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.yxj.mapper.ViewHotMapper;
import com.yxj.model.ViewHot;
import com.yxj.service.ViewHotService;

@Component
public class ViewHotServiceImpl implements ViewHotService{
	@Resource 
	private ViewHotMapper viewHotMapper;
	@Override
	public List<ViewHot> TopHot(){
		return viewHotMapper.TopHot();
	}

}
