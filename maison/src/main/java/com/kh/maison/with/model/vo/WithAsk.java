package com.kh.maison.with.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WithAsk {
	
	private int waNo;
	private int wbNo;
	//잊지말자 댓글을 치고 있는 사람, 
	//설사 그게 wbNo로 불러오는 memberId랑 같을 지라도 무조건.
	private String memberId;
	private String waContent;
	private Date waDate;
	
}
