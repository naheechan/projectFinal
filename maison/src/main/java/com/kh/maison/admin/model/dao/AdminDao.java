package com.kh.maison.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.admin.model.vo.ProductStock;
import com.kh.maison.shop.model.vo.Request;

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
	
	//productStock.jsp 세번째 div데이터 가져오기
	List<ProductStock> bringThirdList(SqlSessionTemplate session,int cPage,int numPerPage);
	int bringThirdCount(SqlSessionTemplate session);
	
	//productRequest.jsp 데이터 가져오기
	List<Request> selectAllRequest(SqlSessionTemplate session,int cPage,int numPerPage,String requestStatus);
	int selectAllRequestCount(SqlSessionTemplate session,String requestStatus);
	
	//productRequest view 보기
	Request selectOneRequest(SqlSessionTemplate session,int no);

}
