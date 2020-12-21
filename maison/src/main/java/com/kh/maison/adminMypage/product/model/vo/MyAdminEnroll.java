package com.kh.maison.adminMypage.product.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MyAdminEnroll {

	private int orderNo;
	private int odamount;
	private int productNo;
	private String productImg;
	private String productName;
	private String largeCate;
	private String mcName;
	private String productSummary;
	private String productStatus;
	private int productStock;
	private int price;
	private int defCycle;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date productDate;
	private String mediumCate;
	private String productContent;
}
