package com.kh.maison.with.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WithBoard {
	private int wbNo;
	private String memberId;
	private String wbTitle;
	private String wbType;
	private String wbPrice;
	private String wbContent;
	private String wbStatus;
	private int wbCount;
	private String wbUse;
	private String[] wbShip;
	private String wbDel;
	private String wbPhone;
	private Date wbDate;
}
