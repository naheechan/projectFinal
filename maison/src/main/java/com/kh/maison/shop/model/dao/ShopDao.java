package com.kh.maison.shop.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.vo.CateProduct;
import com.kh.maison.shop.model.vo.Request;

public interface ShopDao {

	List<Product> selectProductList(SqlSession session,int cPage, int numPerPage);
	int selectCount(SqlSession session);
	
	List<Category> selectCategory(SqlSession session);
	List<Category> selectMediCate(SqlSession session);
	int insertRequestProduct(SqlSession session, Request rq);
	
	List<Product> selectOneMediCate(SqlSession session, String keyword);
	List<CateProduct> searchCate(SqlSession session, String category);
	List<Category> searchMediCate(SqlSession session, String category);
	
}
