package com.kh.maison.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.shop.vo.Product;
import com.kh.maison.shop.vo.WishList;

public interface ProductDao {

	List<Map> selectProductList(SqlSession session);
	
	Product selectProductOne(SqlSession session, int no);
	
	int insertWishList(SqlSession session,WishList w);
	
	List<Map> selectWishList(SqlSession session, String id);
	
	int deleteWishList(SqlSession session, WishList w);
	
}
