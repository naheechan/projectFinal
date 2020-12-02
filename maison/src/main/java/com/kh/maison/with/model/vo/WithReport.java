package com.kh.maison.with.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WithReport {
	private int wrNo;
	private int wbNo;
	private String memberId;
	private String wrContent;
	private Date wrDate;
	private String wrStatus;
}
