package com.kh.maison.admin.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Override
	public List<Category> selectCategory(SqlSession session,String data) {
		return session.selectList("product.selectCategory");
	}

	@Override
	public List<Category> selectMediumCategory(SqlSession session,String largeCate) {
	System.out.println("in daoi,mple"+largeCate);
		return session.selectList("product.selectMediumCategory",largeCate);
	}
	
	@Override
	public Category selectOneCategory(SqlSession session, Map<String,Object> param) {
		System.out.println("map in dao"+param.toString());
		
//		Category c = session.selectOne("product.selectOneCategory",param);
//		System.out.println("daoImple"+c);
		return session.selectOne("product.selectOneCategory",param);
	}

	@Override
	public int insertEnroll(SqlSession session, Product pd) {
		System.out.println("Product in daoI,mpl"+pd.toString());
		return session.insert("product.insertEnroll",pd);
	}

	@Override
	public int enrollCate(SqlSession session, Category c) {
		System.out.println(c);
		return session.insert("product.enrollCate",c);
	}

	
	
	
}
