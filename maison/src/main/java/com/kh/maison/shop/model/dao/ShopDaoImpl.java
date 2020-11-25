package com.kh.maison.shop.model.dao;



import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
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
	public int insertRequestProduct(SqlSession session, String requestContent) {
		return session.insert("shop.insertRequestProduct",requestContent);
	}

}
