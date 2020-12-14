package com.kh.maison.admin.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;

public interface ProductAdminService {
	
	List<Category> selectCategory(String largeCate);
	
	List<Category> selectMediumCategory(String largeCate);
	
	Category selectOneCategory(Map<String,Object> param);
	
	int insertEnroll(Product pd);
	
	int enrollCate(Category c);
	
	List<ProductCate> productView(int no);
	
	int updateEnroll(Product pd);
}
