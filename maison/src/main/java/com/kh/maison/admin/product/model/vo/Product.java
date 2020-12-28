package com.kh.maison.admin.product.model.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class Product {

	private int productNo;
	private String productName;
	private String productSummary;
	private String productContent;
	private String productImg;
	private String productStatus;
	private int productStock;
	private int price;
	private String mediumCate;
	private Date productDate;
	private int defCycle;

}
