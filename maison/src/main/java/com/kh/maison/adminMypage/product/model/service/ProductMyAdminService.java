package com.kh.maison.adminMypage.product.model.service;

import java.util.List;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;

public interface ProductMyAdminService {

	List<ProductCate> selectTotalList(int cPage, int numPerPage);
	
	int selectTotalCount();
	
	int selectShowCount();
	
	int selectStockCount();
	
	int selectTodayCount();
	
//	List<ProductCate> searchNameProduct(Map<String,Object> param);
	
}
