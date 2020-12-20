package com.kh.maison.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

public interface AdminDao {
	
	//productStock.jsp 첫번째 div데이터 가져오기 
	int selectFirstTotal(SqlSessionTemplate session,int numDate);
	int selectFirstChange(SqlSessionTemplate session,int numDate);
	int selectFirstIn(SqlSessionTemplate session,int numDate);
	int selectFirstOut(SqlSessionTemplate session,int numDate);
	
	//productStock.jsp 두번째 div데이터가져오기
	int selectSecondChange(SqlSessionTemplate session,int sendNum);
	int selectSecondIn(SqlSessionTemplate session,int sendNum);
	int selectSecondOut(SqlSessionTemplate session,int sendNum);
	
}
