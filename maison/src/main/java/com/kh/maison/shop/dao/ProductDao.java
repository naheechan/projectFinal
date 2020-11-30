package com.kh.maison.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.shop.vo.Product;

public interface ProductDao {

	List<Map> selectProductList(SqlSession session);
	
	Product selectProduct(SqlSession session, int no);
	
	int insertWishList(SqlSession session,int no);
	
	List<Map> selectWishList(SqlSession session);
	
	int deleteWishList(SqlSession session, int no);
	
}
