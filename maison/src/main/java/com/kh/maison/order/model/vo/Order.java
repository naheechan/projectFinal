package com.kh.maison.order.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Order {
	
	private int orderNo;
	private String memberId;
	private String payment;
	private int orderPrice;
	private int totalPrice;
	private int useMile;
	private int stackMile;
	private String receiver;
	private String sellRequest;
	private String deliRequest;
	private String orPhone;
	private String orZipcode;
	private String orAddress;
	private String orDetailAddress;
	private String orderStatus;
	private Date cancelDate;
	
	//member vo
	private int mileage;

}
