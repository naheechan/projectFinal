package com.kh.maison.notice.model.vo;

import java.sql.Date;

import lombok.Data;


public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private int noticeCount;
	private char noticeStatus;
	
	
	
	public Notice() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Date getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}
	public int getNoticeCount() {
		return noticeCount;
	}
	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}
	public char getNoticeStatus() {
		return noticeStatus;
	}
	public void setNoticeStatus(char noticeStatus) {
		this.noticeStatus = noticeStatus;
	}
	public Notice(int noticeNo, String noticeTitle, String noticeContent, Date noticeDate, int noticeCount,
			char noticeStatus) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeDate = noticeDate;
		this.noticeCount = noticeCount;
		this.noticeStatus = noticeStatus;
	}

	
}
