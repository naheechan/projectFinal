package com.kh.maison.order.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
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
	private Date orderDate;
	private Date cancelDate;
	
	private List<OrderDetail> ods;
	private int odCount;
	

}
