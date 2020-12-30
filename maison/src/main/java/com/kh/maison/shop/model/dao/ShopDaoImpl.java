package com.kh.maison.shop.model.dao;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.shop.model.vo.InquiryReply;
import com.kh.maison.shop.model.vo.PdInquiry;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.shop.model.vo.TotalInquiry;
@Repository
public class ShopDaoImpl implements ShopDao {

	@Override
	public List<Product> selectProductList(SqlSession session,int cPage, int numPerPage) {
		return session.selectList("shop.selectProductList",null,
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
		System.out.println("요청해요 "+rq);
		return session.insert("shop.insertRequestProduct",rq);
	}


	@Override
	public List<Product> selectOneMediCate(SqlSession session, String keyword) {
		System.err.println("shopDaoImpl keyword :   : "+keyword);
		return session.selectList("shop.selectOneMediCate",keyword);
	}


	@Override
	public List<ProductCate> searchCate(SqlSession session, String category) {
		System.out.println("shop dao category"+category);
		return session.selectList("shop.searchCate",category);
	}


	@Override
	public List<TotalInquiry> selectInquiryList(SqlSession session, int cPage, int numPerPage,Map<String,Object> map) {
		return session.selectList("shop.selectInquiryList",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}


	@Override
	public int selectCountInquiry(SqlSession session,Map<String,Object> map) {
		return session.selectOne("shop.selectCountInquiry",map);
	}


	@Override
	public Product selectPdOne(SqlSession session, int no) {
		return session.selectOne("shop.selectPdOne",no);
	}


	@Override
	public int writeInquiry(SqlSession session, PdInquiry pi) {
		System.err.println("shopDaiImple:"+pi);
		return session.insert("shop.writeInquiry",pi);
	}


	@Override
	public int insertReply(SqlSession session, InquiryReply ir) {
		return session.insert("shop.insertReply",ir);
	}


	@Override
	public PdInquiry selectInquiryOne(SqlSession session, int piNo) {
		return session.selectOne("shop.selectInquiryOne",piNo);
	}


	@Override
	public int updateInquiry(SqlSession session,Map<String,Object> m) {
		return session.update("shop.updateInquiry",m);
	}


	@Override
	public List<InquiryReply> selectReplyOne(SqlSession session, int piNo) {
		return session.selectList("shop.selectReplyOne",piNo);
	}


	@Override
	public int updateStatus(SqlSession session, int no) {
		return session.update("shop.updateStatus",no);
	}


	@Override
	public List<TotalInquiry> selectAddReply(SqlSession session, int no) {
		return session.selectList("shop.selectAddReply",no);
	}


	@Override
	public int modiReply(SqlSession session, Map<String,Object> param) {
		return session.update("shop.modiReply",param);
	}


	@Override
	public int deleteInquiry(SqlSession session, int no) {
		return session.update("shop.deleteInquiry",no);
	}
	
	@Override
	public List<Category> searchMediCate(SqlSession session, String category) {
	return session.selectList("shop.searchMediCate", category);
	}


	@Override
	public int deleteRep(SqlSession session, int no) {
		return session.delete("shop.deleteRep",no);
	}


}
