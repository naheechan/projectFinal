package com.kh.maison.adminMypage.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.dao.ProductMyAdminDao;

@Service
public class ProductMyAdminServiceImpl implements ProductMyAdminService {

	@Autowired
	private ProductMyAdminDao dao;
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<ProductCate> selectTotalList(int cPage, int numPerPage) {
		return dao.selectTotalList(session,cPage, numPerPage);
	}

	@Override
	public int selectTotalCount() {
		return dao.selectTotalCount(session);
	}

	@Override
	public int selectShowCount() {
		return dao.selectShowCount(session);
	}

	@Override
	public int selectStockCount() {
		return dao.selectStockCount(session);
	}

	@Override
	public int selectTodayCount() {
		return dao.selectTodayCount(session);
	}


	
//	@Override
//	public List<ProductCate> searchNameProduct(Map<String, Object> param) {
//		return dao.searchNameProduct(session,param);
//	}
	
	
}
