package com.kh.maison.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

public interface ReviewDao {

	int insertReview(SqlSessionTemplate session,Review r);
	List<Review> selectReviewList(SqlSessionTemplate session,int productNo);
	List<Review> selectReviewList(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);
	int insertReviewReply(SqlSessionTemplate session,Map param);
	List<ReviewReply> selectReviewReplyList(SqlSessionTemplate session,int reviewNo);
	int deleteReviewReply(SqlSessionTemplate session,int rrNo);
	int updateReviewReply(SqlSessionTemplate session,ReviewReply rr);
	Review selectReviewOne(SqlSessionTemplate session,int reviewNo);
	int updateReview(SqlSessionTemplate session,Review r);
	int deleteReview(SqlSessionTemplate session,int reviewNo);
	int countReviewId(SqlSessionTemplate session, String memberId);
	Review selectReviewOdNo(SqlSessionTemplate session,int orderDetailNo);
	List<Review> selectPeriodReview(SqlSessionTemplate session,Map param,int cPage,int numPerPage);
	int countPeriodReview(SqlSessionTemplate session, Map param);
	List<Review> selectReviewWithRR(SqlSessionTemplate session,Map param,int cPage, int numPerPage);
	int countReviewWithRR(SqlSessionTemplate session,Map param);
}
