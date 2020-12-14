package com.kh.maison.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.vo.CateProduct;
import com.kh.maison.shop.model.vo.InquiryReply;
import com.kh.maison.shop.model.vo.PdInquiry;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.shop.model.vo.TotalInquiry;

public interface ShopDao {

	List<Product> selectProductList(SqlSession session,int cPage, int numPerPage);
	int selectCount(SqlSession session);
	
	List<Category> selectCategory(SqlSession session);
	List<Category> selectMediCate(SqlSession session);
	int insertRequestProduct(SqlSession session, Request rq);
	
	List<Product> selectOneMediCate(SqlSession session, String keyword);
	List<Product> searchCate(SqlSession session, String category);
	
	List<TotalInquiry> selectInquiryList(SqlSession session, int cPage, int numPerPage);
	int selectCountInquiry(SqlSession session);
	
	Product selectPdOne(SqlSession session, int no);
	
	int writeInquiry(SqlSession session, PdInquiry pi);
	
	int insertReply(SqlSession session, InquiryReply ir);
	
	PdInquiry selectInquiryOne(SqlSession session, int piNo);
	
	int updateInquiry(SqlSession session, Map<String,Object> m);
	
	List<InquiryReply> selectReplyOne(SqlSession session, int piNo);
	
	int updateStatus(SqlSession session, int no);
	
	List<TotalInquiry> selectAddReply(SqlSession session, int no);
	
	int modiReply(SqlSession session, Map<String,Object> param);
	
	int deleteInquiry(SqlSession session, int no);
}
