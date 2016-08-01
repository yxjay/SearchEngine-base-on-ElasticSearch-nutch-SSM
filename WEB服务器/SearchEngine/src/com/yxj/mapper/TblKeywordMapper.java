package com.yxj.mapper;

import com.yxj.model.TblKeyword;
import com.yxj.model.TblKeywordExample;
import com.yxj.model.TblWord;


import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TblKeywordMapper {
    int countByExample(TblKeywordExample example);

    int deleteByExample(TblKeywordExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TblKeyword record);

    int insertSelective(TblKeyword record);

    List<TblKeyword> selectByExample(TblKeywordExample example);

    TblKeyword selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TblKeyword record, @Param("example") TblKeywordExample example);

    int updateByExample(@Param("record") TblKeyword record, @Param("example") TblKeywordExample example);

    int updateByPrimaryKeySelective(TblKeyword record);

    int updateByPrimaryKey(TblKeyword record);

	List<TblKeyword> findByLike(String word);	//模糊匹配

	List<TblWord> getRelative(String word);		//获得相关搜索关键字
	
	String getIDByName(String word);				//根据关键字查找ID
}