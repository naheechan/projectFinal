package com.kh.maison.adminMypage.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.adminMypage.product.model.vo.MyAdminInquiry;

public interface ProductMyAdminService {

	List<ProductCate> selectTotalList(int cPage, int numPerPage);
	
	int selectTotalCount();
	
	int selectShowCount();
	
	int selectStockCount();
	
	int selectTodayCount();
	
//	List<ProductCate> searchNameProduct(Map<String,Object> param);
	
	//카테고리
	List<MyAdminCate> selectCateList(int cPage, int numPerPage);
	
	int selectTotalCateCount();
	
	int largeCateCount();
	
	int mediCateCount();
	
	int todayEnrollCount();
	
	List<Category> selectLargeCateList();
	
	List<Category> selectMediCateList();
	
	List<Category> selectNewOneCate();
	
	List<MyAdminCate> selectListInMedi(Map<String,Object> param);
	
	List<Category> cateView(String val);
	
	Category cateNameCheck(String name);
	
	int updateCate(Map<String,Object> param);
	
	int insertCate(Map<String,Object> param);
	
	int deleteCate(String id);
	
	List<MyAdminCate> searchDate(Map<String,Object> param);
	
	//문의
	List<MyAdminInquiry> selectInquiryList(int cPage, int numPerPage);
	
	int selectInquiryCount();
	
	int selectnoRepCount();
	
	int selectYRepCount();
	
	int selectDelRepCount();
	
	int selectTodayIQCount();
	
	List<MyAdminInquiry> selectReplyList(int cPage,int numPerPage);
	
	int selectReplyCount();
	
	List<MyAdminInquiry> noreply();
	
	List<MyAdminInquiry> yesreply();
	
	List<MyAdminInquiry> delreply();
	
	List<MyAdminInquiry> listAll(String searchType,String searchKeyword,String selectKeyword,int cPage,int numPerPage);
	
	int countArticle(String searchType,String searchKeyword,String selectKeyword);
	
	List<MyAdminInquiry> allList();
	
	List<MyAdminInquiry> todayEnroll();
	
	List<MyAdminInquiry> selectsearch(String searchType,String selectCate,String searchKeyword,String datepicker,String datepicker2,int cPage,int numPerPage);
	
	int searchCountInq(String searchType,String selectCate,String searchKeyword,String datepicker,String datepicker2);
	
	//등록
	List<MyAdminEnroll> allPdList(int cPage, int numPerPage);
	
	int enrollAllCount();
	
	List<MyAdminEnroll> todayPdEnroll(int cPage, int numPerPage);
	
	int enrolltodayCount();
	
	List<MyAdminEnroll> pdStatus(int cPage,int numPerPage);
	
	List<MyAdminEnroll> pdStock(int cPage,int numPerPage);
	
	List<MyAdminEnroll> selectPopularList();
	
	List<MyAdminEnroll> Enrollsearch(String searchType,String searchKeyword,String datepicker,String datepicker2,int cPage,int numPerPage);
	
	int EnrollsearchCount(String searchType,String searchKeyword,String datepicker,String datepicker2);
	
	
}
