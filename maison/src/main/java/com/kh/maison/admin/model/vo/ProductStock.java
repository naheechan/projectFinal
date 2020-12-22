package com.kh.maison.admin.model.vo;

import java.util.Date;
import lombok.Data;

@Data
public class ProductStock {
	private int productNo;
	private String productName;
	private String productImg;
	private String productSummary;
	private int productStock;
	private int pcAmount;
	private Date pcDate;
}
