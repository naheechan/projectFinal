package com.kh.maison.admin.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;

@Repository
public class ProductAdminDaoImpl implements ProductAdminDao {

	@Override
	public List<Category> selectCategory(SqlSession session,String data) {
		return session.selectList("product.selectCategory");
	}

	@Override
	public List<Category> selectMediumCategory(SqlSession session,String largeCate) {
//	System.out.println("in daoi,mple"+largeCate);
		return session.selectList("product.selectMediumCategory",largeCate);
	}
	
	@Override
	public Category selectOneCategory(SqlSession session, Map<String,Object> param) {
		
		
//		Category c = session.selectOne("product.selectOneCategory",param);
//		System.out.println("daoImple"+c);
		return session.selectOne("product.selectOneCategory",param);
	}

	@Override
	public int insertEnroll(SqlSession session, Product pd) {
//		System.out.println("Product in daoI,mpl"+pd.toString());
		return session.insert("product.insertEnroll",pd);
	}

	@Override
	public int enrollCate(SqlSession session, Category c) {
//		System.out.println(c);
		return session.insert("product.enrollCate",c);
	}

	@Override
	public List<ProductCate> productView(SqlSession session,int no) {
		return session.selectList("product.productView",no);
	}

	@Override
	public int updateEnroll(SqlSession session, Product pd) {
		return session.update("product.updateEnroll",pd);
	}
	
	
	
}
