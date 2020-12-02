package com.kh.maison.with.model.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@JsonFormat(shape=JsonFormat.Shape.STRING,pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
public class WithComment {
	private int wcNo;
	private int wbNo;
	private String memberId;
	private int wcParent;
	private String wcContent;
	private int wcLevel;
	private String wcDel;
	private Date wcAddDate;
	private Date wcUpDate;
	private Date wcDelDate;
}
