package com.kh.maison.admin.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberWithdraw {
	
	private String memberId;
	private String mvReason;
	private Date mvDate;
}
