package com.yxj.mapper;

import com.yxj.model.ViewHot;
import com.yxj.model.ViewHotExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ViewHotMapper {
    int countByExample(ViewHotExample example);

    int deleteByExample(ViewHotExample example);

    int insert(ViewHot record);

    int insertSelective(ViewHot record);

    List<ViewHot> selectByExample(ViewHotExample example);

    int updateByExampleSelective(@Param("record") ViewHot record, @Param("example") ViewHotExample example);

    int updateByExample(@Param("record") ViewHot record, @Param("example") ViewHotExample example);

    //自定义
    List<ViewHot> TopHot();
    
}