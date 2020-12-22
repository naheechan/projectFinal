package com.kh.maison.shopCycle.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class CycleAdmin {

	private String memberId;
	private String memberName;
	private String email;
	private int productNo;
	private String cycleMode;
	private String alertStatus;
	private Date startDate;
	private int onCycle;
	private int offCycle;
	private int odAmount;
	
}
