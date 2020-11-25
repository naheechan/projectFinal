package com.kh.maison.admin.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.dao.ProductDao;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao dao;
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<Category> selectCategory(String largeCate) {
		// TODO Auto-generated method stub
		return dao.selectCategory(session,largeCate);
	}
	@Override
	public List<Category> selectMediumCategory(String largeCate) {
		// TODO Auto-generated method stub
		
		return dao.selectMediumCategory(session,largeCate);
	}

	@Override
	public Category selectOneCategory(Map<String,Object> param) {
		return dao.selectOneCategory(session,param);
	}
	
	@Override
	public int insertEnroll(Product pd) {
		
		return dao.insertEnroll(session,pd);
	}
	
	
	
	
	
	
}
