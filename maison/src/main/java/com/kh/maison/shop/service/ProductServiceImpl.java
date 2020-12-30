package com.kh.maison.shop.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.shop.dao.ProductDao;
import com.kh.maison.shop.model.vo.PdInquiry;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shop.vo.WishList;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private SqlSession session;
	
	@Autowired
	private ProductDao dao;

	@Override
	public List<Map> selectProductList() {
		// TODO Auto-generated method stub
		return dao.selectProductList(session);
	}

	@Override
	public Product selectProductOne(int no) {
		// TODO Auto-generated method stub
		return dao.selectProductOne(session,no);
	}

	@Override
	public int insertWishList(WishList w) {
		// TODO Auto-generated method stub
		
		return dao.insertWishList(session,w);
	}

	@Override
	public List<Map> selectWishList(String id) {
		// TODO Auto-generated method stub
		return dao.selectWishList(session, id);
	}

	@Override
	public int deleteWishList(WishList w) {
		// TODO Auto-generated method stub
		return dao.deleteWishList(session,w);
	}

	@Override
	public int countMyWish(Map param) {
		// TODO Auto-generated method stub
		return dao.countMyWish(session,param);
	}

	
	

	
	
	

}
