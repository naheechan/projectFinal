package com.kh.maison.with.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.with.model.vo.WithBoard;

public interface WithBoardDao {
	
	int insertWith(SqlSessionTemplate session, WithBoard wb);
	
	List<WithBoard> selectAllWith(SqlSessionTemplate session, int cPage, int numPerPage);
	
	int selectWithCount(SqlSessionTemplate session);
}
