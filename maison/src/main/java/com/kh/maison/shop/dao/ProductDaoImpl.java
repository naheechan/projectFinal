package com.kh.maison.shop.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.shop.vo.Product;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Override
	public List<Map> selectProductList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("shop.shopList");
	}

	@Override
	public Product selectProduct(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("shop.selectProduct",no);
	}

	@Override
	public int insertWishList(SqlSession session, int no) {
		// TODO Auto-generated method stub
		
		return session.insert("wishList.insertWishList",no);
	}

	@Override
	public List<Map> selectWishList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("wishList.selectWishList");
	}

	@Override
	public int deleteWishList(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.delete("wishList.deleteWishList",no);
	}
	
	
	
	

	
	
	
	
	
	
	

}
