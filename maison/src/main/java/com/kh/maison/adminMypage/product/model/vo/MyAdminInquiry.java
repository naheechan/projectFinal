package com.kh.maison.adminMypage.product.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MyAdminInquiry {

	private int piNo;
	private int productNo;
	private String productImg;
	private String productName;
	private String piCate;
	private String piTitle;
	private String piContent;
	private String memberId;
	private String piStatus;
	private String piDel;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date piDate;
	private int pirNo;
	private String pirContent;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date pirDate;
	private String memberStatus;
}
