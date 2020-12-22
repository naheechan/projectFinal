package com.kh.maison.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Override
	public int insertReview(SqlSessionTemplate session, Review r) {
		// TODO Auto-generated method stub
		return session.insert("review.insertReview", r);
	}

	@Override
	public List<Review> selectReviewList(SqlSessionTemplate session, int productNo) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewList",productNo);
	}

	@Override
	public int insertReviewReply(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.insert("review.insertReviewReply",param);
	}

	@Override
	public List<ReviewReply> selectReviewReplyList(SqlSessionTemplate session, int reviewNo) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewReplyList",reviewNo);
	}

	@Override
	public int deleteReviewReply(SqlSessionTemplate session, int rrNo) {
		// TODO Auto-generated method stub
		
		return session.delete("review.deleteReviewReply", rrNo);
	}

	@Override
	public int updateReviewReply(SqlSessionTemplate session, ReviewReply rr) {
		// TODO Auto-generated method stub
		return session.update("review.updateReviewReply",rr);
	}

	@Override
	public Review selectReviewOne(SqlSessionTemplate session, int reviewNo) {
		// TODO Auto-generated method stub
		return session.selectOne("review.selectReviewOne",reviewNo);
	}

	@Override
	public int updateReview(SqlSessionTemplate session, Review r) {
		// TODO Auto-generated method stub
		return session.update("review.updateReview",r);
	}

	@Override
	public int deleteReview(SqlSessionTemplate session, int reviewNo) {
		// TODO Auto-generated method stub
		return session.delete("review.deleteReview",reviewNo);
	}

	@Override
	public List<Review> selectReviewList(SqlSessionTemplate session, String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewListId",memberId,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countReviewId(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("review.countReviewId",memberId);
	}

	@Override
	public Review selectReviewOdNo(SqlSessionTemplate session, int orderDetailNo) {
		// TODO Auto-generated method stub
		return session.selectOne("review.selectReviewOdNo",orderDetailNo);
	}

	@Override
	public List<Review> selectPeriodReview(SqlSessionTemplate session, Map param,int cPage,int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectPeriodReview",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countPeriodReview(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("review.countPeriodReview",param);
	}

	@Override
	public List<Review> selectReviewWithRR(SqlSessionTemplate session, Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewWithRR",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countReviewWithRR(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("review.countReviewWithRR",param);
	}

	@Override
	public List<Review> selectPeriodReviewAdmin(SqlSessionTemplate session, Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectPeriodReviewAdmin",param,new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

	@Override
	public int countPeriodReviewAdmin(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("review.countPeriodReviewAdmin",param);
	}

	@Override
	public List<Review> selectReviewAdminWithRR(SqlSessionTemplate session, Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewAdminWithRR",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countReviewAdminWithRR(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("review.countReviewAdminWithRR",param);
	}

	

	
	
	
}
