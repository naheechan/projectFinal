package com.kh.maison.review.model.vo;

import java.util.Date;

import lombok.Data;
@Data
public class ReviewReply {

	private int rrNo;
	private String rrContent;
	private Date rrDate;
	private int reviewNo;
}
