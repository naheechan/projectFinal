package com.kh.maison.adminMypage.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.dao.ProductMyAdminDao;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.adminMypage.product.model.vo.MyAdminInquiry;

@Service
public class ProductMyAdminServiceImpl implements ProductMyAdminService {

	@Autowired
	private ProductMyAdminDao dao;
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<ProductCate> selectTotalList(int cPage, int numPerPage) {
		return dao.selectTotalList(session,cPage, numPerPage);
	}

	@Override
	public int selectTotalCount() {
		return dao.selectTotalCount(session);
	}

	@Override
	public int selectShowCount() {
		return dao.selectShowCount(session);
	}

	@Override
	public int selectStockCount() {
		return dao.selectStockCount(session);
	}

	@Override
	public int selectTodayCount() {
		return dao.selectTodayCount(session);
	}
	
	
	//카테고리
	@Override
	public List<MyAdminCate> selectCateList(int cPage, int numPerPage) {
		return dao.selectCateList(session,cPage,numPerPage);
	}

	@Override
	public int selectTotalCateCount() {
		return dao.selectTotalCateCount(session);
	}

	@Override
	public int largeCateCount() {
		return dao.largeCateCount(session);
	}

	@Override
	public int mediCateCount() {
		return dao.mediCateCount(session);
	}

	@Override
	public int todayEnrollCount() {
		return dao.todayEnrollCount(session);
	}

	@Override
	public List<Category> selectLargeCateList() {
		return dao.selectLargeCateList(session);
	}

	@Override
	public List<Category> selectMediCateList() {
		return dao.selectMediCateList(session);
	}

	@Override
	public List<Category> selectNewOneCate() {
		return dao.selectNewOneCate(session);
	}

	@Override
	public List<MyAdminCate> selectListInMedi(Map<String,Object> param) {
		return dao.selectListInMedi(session,param);
	}

	@Override
	public List<Category> cateView(String val) {
		return dao.cateView(session,val);
	}

	@Override
	public Category cateNameCheck(String name) {
		return dao.cateNameCheck(session,name);
	}

	@Override
	public int updateCate(Map<String, Object> param) {
		return dao.updateCate(session,param);
	}

	@Override
	public int insertCate(Map<String, Object> param) {
		return dao.insertCate(session,param);
	}

	@Override
	public int deleteCate(String id) {
		return dao.deleteCate(session, id);
	}

	@Override
	public List<MyAdminCate> searchDate(Map<String, Object> param, int cPage, int numPerPage) {
		return dao.searchDate(session,param,cPage,numPerPage);
	}

	//문의
	@Override
	public List<MyAdminInquiry> selectInquiryList(int cPage, int numPerPage) {
		return dao.selectInquiryList(session,cPage,numPerPage);
	}

	@Override
	public int selectInquiryCount() {
		return dao.selectInquiryCount(session);
	}

	@Override
	public int selectnoRepCount() {
		return dao.selectnoRepCount(session);
	}

	@Override
	public int selectYRepCount() {
		return dao.selectYRepCount(session);
	}

	@Override
	public int selectDelRepCount() {
		return dao.selectDelRepCount(session);
	}

	@Override
	public int selectTodayIQCount() {
		return dao.selectTodayIQCount(session);
	}

	@Override
	public List<MyAdminInquiry> selectReplyList(int cPage, int numPerPage) {
		return dao.selectReplyList(session, cPage,numPerPage);
	}

	@Override
	public int selectReplyCount() {
		return dao.selectReplyCount(session);
	}

	@Override
	public List<MyAdminInquiry> noreply(int cPage, int numPerPage) {
		return dao.noreply(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminInquiry> yesreply(int cPage,int numPerPage) {
		return dao.yesreply(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminInquiry> delreply(int cPage,int numPerPage) {
		return dao.delreply(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminInquiry> listAll(String searchType, String searchKeyword,String selectKeyword,int cPage,int numPerPage) {
		return dao.listAll(session,searchType,searchKeyword,selectKeyword,cPage,numPerPage);
	}

	@Override
	public int countArticle(String searchType, String searchKeyword, String selectKeyword) {
		return dao.countArticle(session,searchType,searchKeyword,selectKeyword);
	}

	@Override
	public List<MyAdminInquiry> allList() {
		return dao.allList(session);
	}

	@Override
	public List<MyAdminInquiry> todayEnroll(int cPage,int numPerPage) {
		return dao.todayEnroll(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminInquiry> selectsearch(String searchType, String selectCate, String searchKeyword,String datepicker,String datepicker2,int cPage,int numPerPage) {
		return dao.selectsearch(session,searchType,selectCate,searchKeyword,datepicker,datepicker2,cPage,numPerPage);
	}

	@Override
	public int searchCountInq(String searchType, String selectCate, String searchKeyword,String datepicker,String datepicker2) {
		return dao.searchCountInq(session,searchType,selectCate,searchKeyword,datepicker,datepicker2);
	}

	@Override
	public List<MyAdminEnroll> allPdList(int cPage, int numPerPage) {
		return dao.allPdList(session,cPage,numPerPage);
	}

	@Override
	public int enrollAllCount() {
		return dao.enrollAllCount(session);
	}

	@Override
	public List<MyAdminEnroll> todayPdEnroll(int cPage, int numPerPage) {
		return dao.todayPdEnroll(session,cPage,numPerPage);
	}

	@Override
	public int enrolltodayCount() {
		return dao.enrolltodayCount(session);
	}

	@Override
	public List<MyAdminEnroll> pdStatus(int cPage, int numPerPage) {
		return dao.pdStatus(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminEnroll> pdStock(int cPage, int numPerPage) {
		return dao.pdStock(session,cPage,numPerPage);
	}

	@Override
	public List<MyAdminEnroll> selectPopularList() {
		return dao.selectPopularList(session);
	}

	@Override
	public List<MyAdminEnroll> Enrollsearch(String searchType, String searchKeyword, String datepicker,
			String datepicker2, int cPage, int numPerPage) {
		return dao.Enrollsearch(session,searchType,searchKeyword,datepicker,datepicker2,cPage,numPerPage);
	}

	@Override
	public int EnrollsearchCount(String searchType, String searchKeyword, String datepicker, String datepicker2) {
		return dao.EnrollsearchCount(session,searchType,searchKeyword,datepicker,datepicker2);
	}

	@Override
	public int selectPdCateCount() {
		return dao.selectPdCateCount(session);
	}

	@Override
	public int deleteInq(int no) {
		return dao.deleteInq(session,no);
	}

	@Override
	public int deleteRep(int no) {
		return dao.deleteRep(session,no);
	}

	@Override
	public int updateRep(int no) {
		return dao.updateRep(session,no);
	}

	@Override
	public List<MyAdminEnroll> searchTop(String searchType, String val, int cPage, int numPerPage) {
		return dao.searchTop(session,searchType,val,cPage,numPerPage);
	}

	@Override
	public List<MyAdminEnroll> searchTopAll(String name, int cPage, int numPerPage) {
		return dao.searchTopAll(session,name,cPage,numPerPage);
	}

	

	
	
	
	
}
