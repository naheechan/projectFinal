package com.kh.maison.shop.model.service;

import java.util.List;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.vo.CateProduct;
import com.kh.maison.shop.model.vo.Request;

public interface ShopService {

	List<Product> selectProductList(int cPage, int numPerPage);
	int selectCount();
	
	List<Category> selectCategory();
	List<Category> selectMediCate();
	int insertRequestProduct(Request rq);
	
	List<Product> selectOneMediCate(String keyword);
	
	List<CateProduct> searchCate(String category);
	
	List<Category> searchMediCate(String category);
}
