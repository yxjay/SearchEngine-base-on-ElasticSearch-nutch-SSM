package com.yxj.mapper;

import com.yxj.model.TblWord;
import com.yxj.model.TblWordExample;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TblWordMapper {
    int countByExample(TblWordExample example);

    int deleteByExample(TblWordExample example);

    int deleteByPrimaryKey(String word);

    int insert(TblWord record);

    int insertSelective(TblWord record);

    List<TblWord> selectByExample(TblWordExample example);

    int updateByExampleSelective(@Param("record") TblWord record, @Param("example") TblWordExample example);

    int updateByExample(@Param("record") TblWord record, @Param("example") TblWordExample example);
    //自定义
    List<TblWord> findByLike(String word);
}