package com.kh.maison.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

public interface ShopDao {

	List<Product> selectProduct(SqlSession session,int cPage, int numPerPage);
	int selectCount(SqlSession session);
	
	List<Category> selectCategory(SqlSession session);
	List<Category> selectMediCate(SqlSession session);
	int insertRequestProduct(SqlSession session, String requestProduct);
	
	List<Product> selectOneMediCate(SqlSession session, String keyword);
}
