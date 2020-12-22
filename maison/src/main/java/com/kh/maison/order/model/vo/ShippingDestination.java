package com.kh.maison.order.model.vo;

import lombok.Data;

@Data
public class ShippingDestination {
	private int sdNo;
	private String sdName;
	private String receiver;
	private String memberId;
	private String orZipcode;
	private String orAddress;
	private String orDetailAddress;
	private String orPhone;

}
