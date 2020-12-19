package com.kh.maison.adminMypage.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;

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

	//카테고리
	@Override
	public List<MyAdminCate> selectCateList(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.selectCateList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectTotalCateCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTotalCateCount");
	}

	@Override
	public int largeCateCount(SqlSession session) {
		return session.selectOne("myAdminProduct.largeCateCount");
	}

	@Override
	public int mediCateCount(SqlSession session) {
		return session.selectOne("myAdminProduct.mediCateCount");
	}

	@Override
	public int todayEnrollCount(SqlSession session) {
		return session.selectOne("myAdminProduct.todayEnrollCount");
	}

	@Override
	public List<Category> selectLargeCateList(SqlSession session) {
		return session.selectList("myAdminProduct.selectLargeCateList");
	}

	@Override
	public List<Category> selectMediCateList(SqlSession session) {
		return session.selectList("myAdminProduct.selectMediCateList");
	}

	@Override
	public List<Category> selectNewOneCate(SqlSession session) {
		return session.selectList("myAdminProduct.selectNewOneCate");
	}

	@Override
	public List<MyAdminCate> selectListInMedi(SqlSession session,Map<String,Object> param) {
		return session.selectList("myAdminProduct.selectListInMedi",param);
	}

	@Override
	public List<Category> cateView(SqlSession session, String val) {
		return session.selectList("myAdminProduct.cateView",val);
	}

	@Override
	public Category cateNameCheck(SqlSession session,String name) {
		return session.selectOne("myAdminProduct.cateNameCheck",name);
	}

	@Override
	public int updateCate(SqlSession session, Map<String, Object> param) {
		return session.update("myAdminProduct.updateCate",param);
	}

	@Override
	public int insertCate(SqlSession session, Map<String, Object> param) {
		return session.insert("myAdminProduct.insertCate",param);
	}

	@Override
	public int deleteCate(SqlSession session, String id) {
		return session.delete("myAdminProduct.deleteCate",id);
	}

	@Override
	public List<MyAdminCate> searchDate(SqlSession session,Map<String, Object> param) {
		return session.selectList("myAdminProduct.searchDate",param);
	}
	
	

	
	
	
//	@Override
//	public List<ProductCate> searchNameProduct(SqlSession session, Map<String, Object> param) {
//		return session.selectList("myAdminProduct.searchNameProduct",param);
//	}

	
}
