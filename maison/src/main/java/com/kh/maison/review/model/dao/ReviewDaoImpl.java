package com.kh.maison.review.model.dao;

import java.util.List;
import java.util.Map;

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

	
	
	
}
