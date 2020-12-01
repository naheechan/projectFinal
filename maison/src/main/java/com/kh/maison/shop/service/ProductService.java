package com.kh.maison.shop.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.shop.vo.Product;
import com.kh.maison.shop.vo.WishList;

public interface ProductService {
	
	List<Map> selectProductList();
	
	Product selectProduct(int no);
	
	int insertWishList(WishList w);
	
	List<Map> selectWishList(String id);
	
	int deleteWishList(WishList w);

}
