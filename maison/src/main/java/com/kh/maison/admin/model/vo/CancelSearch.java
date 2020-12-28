package com.kh.maison.admin.model.vo;

import lombok.Data;

@Data
public class CancelSearch {
	
	private String type;
	private String keyword;
	private String startDate;
	private String endDate;
	private String orderStatus;
}
