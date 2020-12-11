package com.kh.maison.admin.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.dao.ProductAdminDao;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;

@Service
public class ProductAdminServiceImpl implements ProductAdminService {

	@Autowired
	private ProductAdminDao dao;
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
	
	
	@Override
	public int enrollCate(Category c) {
		return dao.enrollCate(session,c);
	}
	
	@Override
	public List<ProductCate> productView() {
		return dao.productView(session);
	}
	
	@Override
	public int updateEnroll(Product pd) {
		return dao.updateEnroll(session,pd);
	}
	
	
	
	
}
