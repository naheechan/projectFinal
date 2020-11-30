package com.kh.maison.shop.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
	
	private int productNo;
	private String productName;
	private String productSummary;
	private String productContent;
	private String productimg;
	private String productStatus;
	private int productStock;
	private int price;
	private int mediumCate;
	private Date productDate;
	private int defCycle;

}
