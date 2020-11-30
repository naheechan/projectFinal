package com.kh.maison.shop.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.shop.dao.ProductDao;
import com.kh.maison.shop.vo.Product;

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
	public Product selectProduct(int no) {
		// TODO Auto-generated method stub
		return dao.selectProduct(session,no);
	}

	@Override
	public int insertWishList(int no) {
		// TODO Auto-generated method stub
		
		return dao.insertWishList(session,no);
	}

	@Override
	public List<Map> selectWishList() {
		// TODO Auto-generated method stub
		return dao.selectWishList(session);
	}

	@Override
	public int deleteWishList(int no) {
		// TODO Auto-generated method stub
		return dao.deleteWishList(session,no);
	}
	
	
	
	

	
	
	

}
