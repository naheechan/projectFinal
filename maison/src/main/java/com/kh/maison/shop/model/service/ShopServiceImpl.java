package com.kh.maison.shop.model.service;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.dao.ShopDao;
import com.kh.maison.shop.model.vo.CateProduct;
import com.kh.maison.shop.model.vo.InquiryReply;
import com.kh.maison.shop.model.vo.PdInquiry;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.shop.model.vo.TotalInquiry;
@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao dao; 
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<Product> selectProductList(int cPage, int numPerPage) {
		return dao.selectProductList(session,cPage,numPerPage);
	}

	
	@Override
	public int selectCount() {
		return dao.selectCount(session);
	}


	@Override
	public List<Category> selectCategory() {
		return dao.selectCategory(session);
	}

	@Override
	public List<Category> selectMediCate() {
		return dao.selectMediCate(session);
	}

	@Override
	public int insertRequestProduct(Request rq) {
		int result = dao.insertRequestProduct(session,rq);
		return result;
	}


	@Override
	public List<Product> selectOneMediCate(String keyword) {
		return dao.selectOneMediCate(session,keyword);
	}


	@Override
	public List<Product> searchCate(String category) {
		return dao.searchCate(session,category);
	}


	@Override
	public List<TotalInquiry> selectInquiryList(int cPage, int numPerPage) {
		return dao.selectInquiryList(session,cPage, numPerPage);
	}


	@Override
	public int selectCountInquiry() {
		return dao.selectCountInquiry(session);
	}


	@Override
	public Product selectPdOne(int no) {
		return dao.selectPdOne(session,no);
	}


	@Override
	public int writeInquiry(PdInquiry pi) {
		return dao.writeInquiry(session,pi);
	}


	@Override
	public int insertReply(InquiryReply ir) {
		return dao.insertReply(session,ir);
	}


	@Override
	public PdInquiry selectInquiryOne(int piNo) {
		return dao.selectInquiryOne(session,piNo);
	}


	@Override
	public int updateInquiry(Map<String,Object> m) {
		return dao.updateInquiry(session,m);
	}


	@Override
	public List<InquiryReply> selectReplyOne(int piNo) {
		return dao.selectReplyOne(session,piNo);
	}


	@Override
	public int updateStatus(int no) {
		return dao.updateStatus(session,no);
	}


	@Override
	public List<TotalInquiry> selectAddReply(int no) {
		return dao.selectAddReply(session,no);
	}


	@Override
	public int modiReply(Map<String,Object> param) {
		return dao.modiReply(session,param);
	}


	@Override
	public int deleteInquiry(int no) {
		return dao.deleteInquiry(session,no);
	}

	@Override
	public List<Category> searchMediCate(String category) {
		return dao.searchMediCate(session, category);
	}

	
	

}
