package com.kh.maison.shop.model.vo;


import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PdInquiry {

	private int piNo;
	private String piTitle;
	private String piCate;
	private String piContent;
	private String memberId;
	private int productNo;
	private String piStatus;
	private String piDel;
	private int piReadCount;
	
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date piDate;
}
