package com.kh.maison.adminMypage.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;

public interface ProductMyAdminDao {

	List<ProductCate> selectTotalList(SqlSession session, int cPage, int numPerPage);
	
	int selectTotalCount(SqlSession session);
	
	int selectShowCount(SqlSession session);
	
	int selectStockCount(SqlSession session);
	
	int selectTodayCount(SqlSession session);
	
//	List<ProductCate> searchNameProduct(SqlSession session, Map<String,Object> param);
	
	//카테고리
	List<MyAdminCate> selectCateList(SqlSession session, int cPage, int numPerPage);
	
	int selectTotalCateCount(SqlSession session);
	
	int largeCateCount(SqlSession session);
	
	int mediCateCount(SqlSession session);
	
	int todayEnrollCount(SqlSession session);
	
	List<Category> selectLargeCateList(SqlSession session);
	
	List<Category> selectMediCateList(SqlSession session);
	
	List<Category> selectNewOneCate(SqlSession session);
	
	List<MyAdminCate> selectListInMedi(SqlSession session, Map<String,Object> param);
	
	List<Category> cateView(SqlSession session, String val);
	
	Category cateNameCheck(SqlSession session,String name);
	
	int updateCate(SqlSession session,Map<String,Object> param);
	
	int insertCate(SqlSession session, Map<String,Object> param);
	
	int deleteCate(SqlSession session, String id);
	
	List<MyAdminCate> searchDate(SqlSession session,Map<String,Object> param);
}
