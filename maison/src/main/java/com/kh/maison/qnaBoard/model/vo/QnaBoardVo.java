package com.kh.maison.qnaBoard.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaBoardVo {
	public int qnaNO;
	public String qnaTitle;
	public String qnaContent;
	public Date qnaDate;
	public String qnaSecret;
	public String qnaPw;
	public String qnaStatus;
	public String memberId;
}
