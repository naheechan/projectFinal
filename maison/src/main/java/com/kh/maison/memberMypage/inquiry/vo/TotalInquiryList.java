package com.kh.maison.memberMypage.inquiry.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class TotalInquiryList {

	private int productNo;
	private String productName;
	private String productImg;
	private int mediumCate;
	private String mcName;
	private String largeCate;
	private int piNo;
	private String piCate;
	private String piContent;
	private String memberId;
	private String piStatus;
	private String piDel;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date piDate;
	
}
