package com.kh.maison.firstpage.model.service;

import java.util.List;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

public interface FirstpageService {
	
	List<Product> selectBestWish();
	
	List<Product> selectBestSeller();
	
	Member selectAdmin();

}
