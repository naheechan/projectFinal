package com.kh.maison.adminMypage.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.adminMypage.product.model.vo.MyAdminInquiry;

public interface ProductMyAdminDao {

	List<ProductCate> selectTotalList(SqlSession session, int cPage, int numPerPage);
	
	int selectTotalCount(SqlSession session);
	
	int selectShowCount(SqlSession session);
	
	int selectStockCount(SqlSession session);
	
	int selectTodayCount(SqlSession session);
	
//	List<ProductCate> searchNameProduct(SqlSession session, Map<String,Object> param);
	
	//카테고리
	List<MyAdminCate> selectCateList(SqlSession session, int cPage, int numPerPage);
	
	int selectTotalCateCount(SqlSession session);
	
	int largeCateCount(SqlSession session);
	
	int mediCateCount(SqlSession session);
	
	int todayEnrollCount(SqlSession session);
	
	List<Category> selectLargeCateList(SqlSession session);
	
	List<Category> selectMediCateList(SqlSession session);
	
	List<Category> selectNewOneCate(SqlSession session);
	
	List<MyAdminCate> selectListInMedi(SqlSession session, Map<String,Object> param);
	
	List<Category> cateView(SqlSession session, String val);
	
	Category cateNameCheck(SqlSession session,String name);
	
	int updateCate(SqlSession session,Map<String,Object> param);
	
	int insertCate(SqlSession session, Map<String,Object> param);
	
	int deleteCate(SqlSession session, String id);
	
	List<MyAdminCate> searchDate(SqlSession session,Map<String,Object> param);
	//문의
	List<MyAdminInquiry> selectInquiryList(SqlSession session,int cPage, int numPerPage);
	
	int selectInquiryCount(SqlSession session);
	
	int selectnoRepCount(SqlSession session);
	
	int selectYRepCount(SqlSession session);
	
	int selectDelRepCount(SqlSession session);
	
	int selectTodayIQCount(SqlSession session);
	
	List<MyAdminInquiry> selectReplyList(SqlSession session, int cPage,int numPerPage);
	
	int selectReplyCount(SqlSession session);
	
	List<MyAdminInquiry> noreply(SqlSession session);
	
	List<MyAdminInquiry> yesreply(SqlSession session);
	
	List<MyAdminInquiry> delreply(SqlSession session);
	
	List<MyAdminInquiry> listAll(SqlSession session, String searchType,String searchKeyword,String selectKeyword,int cPage,int numPerPage);
	
	int countArticle(SqlSession session, String searchType, String searchKeyword,String selectKeyword);
	
	List<MyAdminInquiry> allList(SqlSession session);
	
	List<MyAdminInquiry> todayEnroll(SqlSession session);
	
	List<MyAdminInquiry> selectsearch(SqlSession session, String searchType,String selectCate,String datepicker,String datepicker2,String searchKeyword,int cPage,int numPerPage);
	
	int searchCountInq(SqlSession session, String searchType,String selectCate,String searchKeyword,String datepicker,String datepicker2);
	
	List<MyAdminEnroll> allPdList(SqlSession session,int cPage,int numPerPage);
	
	int enrollAllCount(SqlSession session);
	
	List<MyAdminEnroll> todayPdEnroll(SqlSession session, int cPage, int numPerPage);
	
	int enrolltodayCount(SqlSession session);
	
	List<MyAdminEnroll> pdStatus(SqlSession session,int cPage, int numPerPage);
	
	List<MyAdminEnroll> pdStock(SqlSession session,int cPage, int numPerPage);
	
	List<MyAdminEnroll> selectPopularList(SqlSession session);
	
	List<MyAdminEnroll> Enrollsearch(SqlSession session, String searchType,String searchKeyword,String datepicker,String datepicker2,int cPage,int numPerPage);
	
	int EnrollsearchCount(SqlSession session, String searchType,String searchKeyword,String datepicker,String datepicker2);
	
	int selectPdCateCount(SqlSession session);
	
	int deleteInq(SqlSession session,int no);
	
	int deleteRep(SqlSession session, int no);
	
	int updateRep(SqlSession session, int no);
	
	List<MyAdminEnroll> searchTop(SqlSession session,String searchType,String val,int cPage,int numPerPage);
	
	List<MyAdminEnroll> searchTopAll(SqlSession session,String name,int cPage,int numPerPage);
}
