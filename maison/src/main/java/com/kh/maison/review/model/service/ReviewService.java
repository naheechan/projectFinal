package com.kh.maison.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

public interface ReviewService {
	int insertReview(Review r);
	List<Review> selectReviewList(int productNo);
	int insertReviewReply(Map param);
	List<ReviewReply> selectReviewReplyList(int reviewNo);
	int deleteReviewReply(int rrNo);
	int updateReviewReply(ReviewReply rr);
	Review selectReviewOne(int reviewNo);
	int updateReview(Review r);
}
