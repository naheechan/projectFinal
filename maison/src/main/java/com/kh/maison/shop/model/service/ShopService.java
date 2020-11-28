package com.kh.maison.shop.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

public interface ShopService {

	List<Product> selectProduct(int cPage, int numPerPage);
	int selectCount();
	
	List<Category> selectCategory();
	List<Category> selectMediCate();
	int insertRequestProduct(String requestContent);
	
	List<Product> selectOneMediCate(String keyword);
}
