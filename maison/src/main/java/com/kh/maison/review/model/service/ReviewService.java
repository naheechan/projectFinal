package com.kh.maison.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;

public interface ReviewService {
	int insertReview(Review r);
	List<Review> selectReviewList(int productNo);
	List<Review> selectReviewList(String memberId,int cPage,int numPerPage);
	int insertReviewReply(Map param);
	List<ReviewReply> selectReviewReplyList(int reviewNo);
	int deleteReviewReply(int rrNo);
	int updateReviewReply(ReviewReply rr);
	Review selectReviewOne(int reviewNo);
	int updateReview(Review r);
	int deleteReview(int reviewNo);
	int countReviewId(String memberId);
	Review selectReviewOdNo(int orderDetailNo);
	List<Review> selectPeriodReview(Map param,int cPage,int numPerPage);
	int countPeriodReview(Map param);
	List<Review> selectReviewWithRR(Map param,int cPage,int numPerPage);
	int countReviewWithRR(Map param);
	List<Review> selectPeriodReviewAdmin(Map param, int cPage, int numPerPage);
	int countPeriodReviewAdmin(Map param);
	List<Review> selectReviewAdminWithRR(Map param,int cPage,int numPerPage);
	int countReviewAdminWithRR(Map param);
}
