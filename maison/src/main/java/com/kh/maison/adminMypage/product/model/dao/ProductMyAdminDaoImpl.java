package com.kh.maison.adminMypage.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;

@Repository
public class ProductMyAdminDaoImpl implements ProductMyAdminDao {

	
	@Override
	public List<ProductCate> selectTotalList(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.selectTotalList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectTotalCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTotalCount");
	}

	@Override
	public int selectShowCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectShowCount");
	}

	@Override
	public int selectStockCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectStockCount");
	}

	@Override
	public int selectTodayCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTodayCount");
	}

	
	
	
//	@Override
//	public List<ProductCate> searchNameProduct(SqlSession session, Map<String, Object> param) {
//		return session.selectList("myAdminProduct.searchNameProduct",param);
//	}

	
}
