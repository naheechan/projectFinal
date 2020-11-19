package com.kh.maison.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {
	private String memberId;
	private String memberName;
	private String memberPw;
	private String zipcode;
	private String address;
	private String detailAddress;
	private String email;
	private String gender;
	private Date birth;
	private String phone;
	private int meileage;
	private String gradeCode;
	private String emailStatus="N";
	private String memberStatus;
	private int reportCount;
	private String authStatus;
}
