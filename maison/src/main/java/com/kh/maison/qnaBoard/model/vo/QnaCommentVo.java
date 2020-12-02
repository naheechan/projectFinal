package com.kh.maison.qnaBoard.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaCommentVo {
	public int qcNO;
	public int qnaNo;
	public String qcContent;
	public Date qcDate;

}
