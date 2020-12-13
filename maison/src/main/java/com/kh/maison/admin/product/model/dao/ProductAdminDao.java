package com.kh.maison.admin.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;

public interface ProductAdminDao {

	
	List<Category> selectCategory(SqlSession session,String largeCate);
	
	List<Category> selectMediumCategory(SqlSession session,String largeCate);
	
	Category selectOneCategory(SqlSession session,Map<String,Object> param);
	
	int insertEnroll(SqlSession session, Product pd);
	
	int enrollCate(SqlSession session, Category c);
	
	List<ProductCate> productView(SqlSession session,int no);
	
	int updateEnroll(SqlSession session, Product pd);
}
