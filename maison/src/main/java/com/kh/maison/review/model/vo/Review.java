package com.kh.maison.review.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Review {
	private int reviewNo;
	private String reviewContent;
	private Date reviewDate;
	private int reviewScore;
	private String memberId;
	private int orderDetailNo;
	private int productNo;
}
