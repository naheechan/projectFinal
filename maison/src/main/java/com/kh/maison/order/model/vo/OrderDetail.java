package com.kh.maison.order.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDetail {
	private int orderDetailNo;
	private int orderNo;
	private int productNo;
	private int odAmount;
	private int odPriceSum;
	
	//조인
	private String productImg;
	private int price;
	private String productName;
	private Date orderDate;
}
