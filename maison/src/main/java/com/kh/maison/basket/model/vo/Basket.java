package com.kh.maison.basket.model.vo;

import lombok.Data;

@Data
public class Basket {

	private int basketNo;
	private int productno;
	private int amount;
	private String memberId;
	
	//조인해서 필요한 변수들
	private String productName;
	private String productImg;
	private int price;
}
