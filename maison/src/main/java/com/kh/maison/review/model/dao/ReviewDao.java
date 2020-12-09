package com.kh.maison.review.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

public interface ReviewDao {

	int insertReview(SqlSessionTemplate session,Review r);
	List<Review> selectReviewList(SqlSessionTemplate session,int productNo);
	int insertReviewReply(SqlSessionTemplate session,Map param);
	List<ReviewReply> selectReviewReplyList(SqlSessionTemplate session,int reviewNo);
}
