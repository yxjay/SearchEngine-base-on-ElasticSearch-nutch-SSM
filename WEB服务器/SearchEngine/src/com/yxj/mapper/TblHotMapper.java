package com.yxj.mapper;

import com.yxj.model.TblHot;
import com.yxj.model.TblHotExample;
import com.yxj.model.TblWord;
import com.yxj.model.ViewHot;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TblHotMapper {
    int countByExample(TblHotExample example);

    int deleteByExample(TblHotExample example);

    int insert(int id);

    int insertSelective(TblHot record);

    List<TblHot> selectByExample(TblHotExample example);

    int updateByExampleSelective(@Param("record") TblHot record, @Param("example") TblHotExample example);

    int updateByExample(@Param("record") TblHot record, @Param("example") TblHotExample example);
    
}