package com.kh.maison.review.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.review.model.dao.ReviewDao;
import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao dao;
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public int insertReview(Review r) {
		// TODO Auto-generated method stub
		return dao.insertReview(session,r);
	}

	@Override
	public List<Review> selectReviewList(int productNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewList(session,productNo);
	}

	@Override
	public int insertReviewReply(Map param) {
		// TODO Auto-generated method stub
		return dao.insertReviewReply(session,param);
	}

	@Override
	public List<ReviewReply> selectReviewReplyList(int reviewNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewReplyList(session,reviewNo);
	}

	@Override
	public int deleteReviewReply(int rrNo) {
		// TODO Auto-generated method stub
		return dao.deleteReviewReply(session,rrNo);
	}

	@Override
	public int updateReviewReply(ReviewReply rr) {
		// TODO Auto-generated method stub
		return dao.updateReviewReply(session,rr);
	}

	@Override
	public Review selectReviewOne(int reviewNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewOne(session,reviewNo);
	}

	@Override
	public int updateReview(Review r) {
		// TODO Auto-generated method stub
		return dao.updateReview(session, r);
	}

	@Override
	public int deleteReview(int reviewNo) {
		// TODO Auto-generated method stub
		return dao.deleteReview(session,reviewNo);
	}

	@Override
	public List<Review> selectReviewList(String memberId,int cPage,int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectReviewList(session, memberId,cPage,numPerPage);
	}

	@Override
	public int countReviewId(String memberId) {
		// TODO Auto-generated method stub
		return dao.countReviewId(session,memberId);
	}

	@Override
	public Review selectReviewOdNo(int orderDetailNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewOdNo(session,orderDetailNo);
	}

	@Override
	public List<Review> selectPeriodReview(Map param,int cPage,int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectPeriodReview(session,param,cPage,numPerPage);
	}

	@Override
	public int countPeriodReview(Map param) {
		// TODO Auto-generated method stub
		return dao.countPeriodReview(session,param);
	}

	@Override
	public List<Review> selectReviewWithRR(Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectReviewWithRR(session,param,cPage,numPerPage);
	}

	@Override
	public int countReviewWithRR(Map param) {
		// TODO Auto-generated method stub
		return dao.countReviewWithRR(session, param);
	}

	@Override
	public List<Review> selectPeriodReviewAdmin(Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectPeriodReviewAdmin(session, param, cPage, numPerPage);
	}

	@Override
	public int countPeriodReviewAdmin(Map param) {
		// TODO Auto-generated method stub
		return dao.countPeriodReviewAdmin(session, param);
	}

	@Override
	public List<Review> selectReviewAdminWithRR(Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectReviewAdminWithRR(session,param,cPage,numPerPage);
	}

	@Override
	public int countReviewAdminWithRR(Map param) {
		// TODO Auto-generated method stub
		return dao.countReviewAdminWithRR(session, param);
	}

	
	
}
