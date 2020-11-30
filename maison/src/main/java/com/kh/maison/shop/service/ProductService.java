package com.kh.maison.shop.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.shop.vo.Product;

public interface ProductService {
	
	List<Map> selectProductList();
	
	Product selectProduct(int no);
	
	int insertWishList(int no);
	
	List<Map> selectWishList();
	
	int deleteWishList(int no);

}
