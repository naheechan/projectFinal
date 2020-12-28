package com.kh.maison.shopCycle.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class CycleProduct {
	
	private String memberId;
	private int productNo;
	private int price;
	private String cycleMode;
	private String alertStatus;
	private Date startDate;
	private Date lastStartDate;
	private int onCycle;
	private int offCycle;
	
	private String productName;
	private String productSummary;
	private String productContent;
	private String productImg;
	private String productStatus;
	private int mediumCate;
	private String mcName;
	private String largeCate;
	private int odAmount;
	
	private long nextDate; //다음 예상구매날짜 ms로 들어가는곳 (정렬용)
	private int day; //현재 설정된 주기모드(on/off)의 주기일수가 들어가는곳 (정렬용)
	

}
