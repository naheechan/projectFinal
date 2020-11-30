package com.kh.maison.admin.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

public interface ProductService {
	
	List<Category> selectCategory(String largeCate);
	
	List<Category> selectMediumCategory(String largeCate);
	
	Category selectOneCategory(Map<String,Object> param);
	
	int insertEnroll(Product pd);
	
	int enrollCate(Category c);
	
}
