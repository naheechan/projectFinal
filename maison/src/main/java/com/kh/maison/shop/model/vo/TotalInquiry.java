package com.kh.maison.shop.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class TotalInquiry {
	private int piNo;
	private String piTitle;
	private String piCate;
	private String piContent;
	private String memberId;
	private int productNo;
	private String piStatus;
	private String piDel;
	private int piReadCount;
	
	private int pirNo;
	private String pirContent;
	private int ipiNo;
	private String memberStatus;
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date piDate;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date pirDate;
}

