package com.kh.maison.adminMypage.product.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.adminMypage.product.model.vo.MyAdminInquiry;

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
	public List<MyAdminCate> searchDate(SqlSession session,Map<String, Object> param, int cPage, int numPerPage) {
		
		return session.selectList("myAdminProduct.searchDate",param,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<MyAdminInquiry> selectInquiryList(SqlSession session,int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.selectInquiryList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectInquiryCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectInquiryCount");
	}

	@Override
	public int selectnoRepCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectnoRepCount");
	}

	@Override
	public int selectYRepCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectYRepCount");
	}

	@Override
	public int selectDelRepCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectDelRepCount");
	}

	@Override
	public int selectTodayIQCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTodayIQCount");
	}

	@Override
	public List<MyAdminInquiry> selectReplyList(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.selectReplyList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectReplyCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectReplyCount");
	}

	@Override
	public List<MyAdminInquiry> noreply(SqlSession session) {
		return session.selectList("myAdminProduct.noreply");
	}

	@Override
	public List<MyAdminInquiry> yesreply(SqlSession session) {
		return session.selectList("myAdminProduct.yesreply");
	}

	@Override
	public List<MyAdminInquiry> delreply(SqlSession session) {
		return session.selectList("myAdminProduct.delreply");
	}

	@Override
	public List<MyAdminInquiry> listAll(SqlSession session, String searchType,String searchKeyword, String selectKeyword,int cPage,int numPerPage) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchType",searchType);
		map.put("keyword",searchKeyword);
		map.put("selectKey",selectKeyword);
		return session.selectList("myAdminProduct.listAll",map,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countArticle(SqlSession session, String searchType, String searchKeyword,String selectKeyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchType",searchType);
		map.put("keyword",searchKeyword);
		map.put("selectKey",selectKeyword);
		return session.selectOne("myAdminProduct.countArticle",map);
	}

	@Override
	public List<MyAdminInquiry> allList(SqlSession session) {
		return session.selectList("myAdminProduct.allList");
	}

	@Override
	public List<MyAdminInquiry> todayEnroll(SqlSession session) {
		return session.selectList("myAdminProduct.todayEnroll");
	}

	@Override
	public List<MyAdminInquiry> selectsearch(SqlSession session, String searchType, String selectCate,
			String searchKeyword,String datepicker, String datepicker2,int cPage,int numPerPage) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("selectCate",selectCate);
		map.put("keyword",searchKeyword);
		map.put("datepicker",datepicker);
		map.put("datepicker2",datepicker2);
		return session.selectList("myAdminProduct.selectsearch",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int searchCountInq(SqlSession session, String searchType, String selectCate,
			String searchKeyword,String datepicker,String datepicker2) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("selectCate",selectCate);
		map.put("keyword",searchKeyword);
		map.put("datepicker",datepicker);
		map.put("datepicker2",datepicker2);
		
		return session.selectOne("myAdminProduct.searchCountInq",map);
	}

	@Override
	public List<MyAdminEnroll> allPdList(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.selectTotalList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int enrollAllCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTotalCount");
	}

	@Override
	public List<MyAdminEnroll> todayPdEnroll(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.todayPdEnroll",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int enrolltodayCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectTodayCount");
	}

	@Override
	public List<MyAdminEnroll> pdStatus(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.pdStatus",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<MyAdminEnroll> pdStock(SqlSession session, int cPage, int numPerPage) {
		return session.selectList("myAdminProduct.pdStock",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<MyAdminEnroll> selectPopularList(SqlSession session) {
		return session.selectList("myAdminProduct.selectPopularList");
	}

	@Override
	public List<MyAdminEnroll> Enrollsearch(SqlSession session, String searchType,String searchKeyword, String datepicker,
			String datepicker2, int cPage, int numPerPage) {
		Map<String,Object> map = new HashMap<>();
			map.put("searchType",searchType);
			map.put("keyword",searchKeyword);
			map.put("datepicker",datepicker);
			map.put("datepicker2",datepicker2);
			
		return session.selectList("myAdminProduct.Enrollsearch",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int EnrollsearchCount(SqlSession session, String searchType, String searchKeyword, String datepicker,
			String datepicker2) {
		Map<String,Object> map = new HashMap<>();
			map.put("searchType",searchType);
			map.put("keyword",searchKeyword);
			map.put("datepicker",datepicker);
			map.put("datepicker2",datepicker2);
			
		return session.selectOne("myAdminProduct.EnrollsearchCount",map);
	}

	@Override
	public int selectPdCateCount(SqlSession session) {
		return session.selectOne("myAdminProduct.selectPdCateCount");
	}

	@Override
	public int deleteInq(SqlSession session, int no) {
		return session.update("myAdminProduct.deleteInq",no);
	}

	@Override
	public int deleteRep(SqlSession session, int no) {
		return session.delete("myAdminProduct.deleteRep",no);
	}

	@Override
	public int updateRep(SqlSession session, int no) {
		return session.update("myAdminProduct.updateRep",no);
	}

	@Override
	public List<MyAdminEnroll> searchTop(SqlSession session, String searchType, String val, int cPage, int numPerPage) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("val",val);
		
		return session.selectList("myAdminProduct.searchTop",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<MyAdminEnroll> searchTopAll(SqlSession session, String name, int cPage, int numPerPage) {
		
		Map<String,Object> map = new HashMap<>();
		map.put("name1",name.split(",")[0]);
		map.put("name2",name.split(",")[1]);
		map.put("name3",name.split(",")[2]);
		return session.selectList("myAdminProduct.searchTopAll",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	

	
	
	
	
}
