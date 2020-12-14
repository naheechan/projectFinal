package com.kh.maison.shop.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminReply {

	private int piNo;
	private String piCate;
	private String piStatus;
	private int pirNo;
	private String pirContent;
	private Date pirDate;
	private int repiNo;
}
