package com.kh.maison.adminMypage.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;

public interface ProductMyAdminService {

	List<ProductCate> selectTotalList(int cPage, int numPerPage);
	
	int selectTotalCount();
	
	int selectShowCount();
	
	int selectStockCount();
	
	int selectTodayCount();
	
//	List<ProductCate> searchNameProduct(Map<String,Object> param);
	
	//카테고리
	List<MyAdminCate> selectCateList(int cPage, int numPerPage);
	
	int selectTotalCateCount();
	
	int largeCateCount();
	
	int mediCateCount();
	
	int todayEnrollCount();
	
	List<Category> selectLargeCateList();
	
	List<Category> selectMediCateList();
	
	List<Category> selectNewOneCate();
	
	List<MyAdminCate> selectListInMedi(Map<String,Object> param);
	
	List<Category> cateView(String val);
	
	Category cateNameCheck(String name);
	
	int updateCate(Map<String,Object> param);
	
	int insertCate(Map<String,Object> param);
	
	int deleteCate(String id);
	
	List<MyAdminCate> searchDate(Map<String,Object> param);
}
