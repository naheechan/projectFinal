package com.kh.maison.order.model.vo;

import lombok.Data;

@Data
public class OrderDetail {
	private int orderDetailNo;
	private int orderNo;
	private int productNo;
	private int odAmount;
	private int odPriceSum;
}
