package com.kh.maison.mileage.model.vo;

import java.util.Date;
import lombok.Data;

@Data
public class Mileage {
	private int mileNo;
	private String memberId;
	private int orderNo;
	private Date mileDate;
	private int mile;
	private String mileType;
}

//insertWelcomeMileage(mil) - memberController에 있음.
//