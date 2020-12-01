package com.kh.maison.shop.model.dao;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.vo.CateProduct;
import com.kh.maison.shop.model.vo.Request;
@Repository
public class ShopDaoImpl implements ShopDao {

	@Override
	public List<Product> selectProduct(SqlSession session,int cPage, int numPerPage) {
		return session.selectList("shop.selectProduct",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	
	@Override
	public int selectCount(SqlSession session) {
		return session.selectOne("shop.selectCount");
	}


	@Override
	public List<Category> selectCategory(SqlSession session) {
		return session.selectList("shop.selectCategory");
	}

	@Override
	public List<Category> selectMediCate(SqlSession session) {
		return session.selectList("shop.selectMediCate");
	}


	@Override
	public int insertRequestProduct(SqlSession session, Request rq) {
		return session.insert("shop.insertRequestProduct",rq);
	}


	@Override
	public List<Product> selectOneMediCate(SqlSession session, String keyword) {
		System.err.println("shopDaoImpl keyword :   : "+keyword);
		return session.selectList("shop.selectOneMediCate",keyword);
	}


	@Override
	public List<CateProduct> searchCate(SqlSession session, String category) {
		System.out.println("shop dao category"+category);
		return session.selectList("shop.searchCate",category);
	}
	
	

}
