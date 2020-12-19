package com.kh.maison.adminMypage.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.dao.ProductMyAdminDao;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;

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
	
	
	//카테고리
	@Override
	public List<MyAdminCate> selectCateList(int cPage, int numPerPage) {
		return dao.selectCateList(session,cPage,numPerPage);
	}

	@Override
	public int selectTotalCateCount() {
		return dao.selectTotalCateCount(session);
	}

	@Override
	public int largeCateCount() {
		return dao.largeCateCount(session);
	}

	@Override
	public int mediCateCount() {
		return dao.mediCateCount(session);
	}

	@Override
	public int todayEnrollCount() {
		return dao.todayEnrollCount(session);
	}

	@Override
	public List<Category> selectLargeCateList() {
		return dao.selectLargeCateList(session);
	}

	@Override
	public List<Category> selectMediCateList() {
		return dao.selectMediCateList(session);
	}

	@Override
	public List<Category> selectNewOneCate() {
		return dao.selectNewOneCate(session);
	}

	@Override
	public List<MyAdminCate> selectListInMedi(Map<String,Object> param) {
		return dao.selectListInMedi(session,param);
	}

	@Override
	public List<Category> cateView(String val) {
		return dao.cateView(session,val);
	}

	@Override
	public Category cateNameCheck(String name) {
		return dao.cateNameCheck(session,name);
	}

	@Override
	public int updateCate(Map<String, Object> param) {
		return dao.updateCate(session,param);
	}

	@Override
	public int insertCate(Map<String, Object> param) {
		return dao.insertCate(session,param);
	}

	@Override
	public int deleteCate(String id) {
		return dao.deleteCate(session, id);
	}

	@Override
	public List<MyAdminCate> searchDate(Map<String, Object> param) {
		return dao.searchDate(session,param);
	}

	
	
//	@Override
//	public List<ProductCate> searchNameProduct(Map<String, Object> param) {
//		return dao.searchNameProduct(session,param);
//	}
	
	
	
}
