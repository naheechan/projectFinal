package com.kh.maison.shop.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Request {

	private int requestNo;
	private String memberId;
	private String requestContent;
	private String requestStatus;
	private Date requestDate;
}
