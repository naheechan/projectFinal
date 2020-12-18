package com.kh.maison.adminMypage.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;

public interface ProductMyAdminDao {

	List<ProductCate> selectTotalList(SqlSession session, int cPage, int numPerPage);
	
	int selectTotalCount(SqlSession session);
	
	int selectShowCount(SqlSession session);
	
	int selectStockCount(SqlSession session);
	
	int selectTodayCount(SqlSession session);
	
//	List<ProductCate> searchNameProduct(SqlSession session, Map<String,Object> param);
	
}
