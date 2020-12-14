package com.kh.maison.qnaBoard.model.service;

import java.util.List;

import com.kh.maison.qnaBoard.model.vo.QnaBoardVo;
import com.kh.maison.qnaBoard.model.vo.QnaCommentVo;

public interface QnaBoardService {
	
	List<QnaBoardVo> selectList(int cPage, int numPerPage);
	
	int selectCount();
	
	int insertQnaBoard(QnaBoardVo QB);
	
	QnaBoardVo selectQna(int no);
	
	//댓글
	int commentInsertService(QnaCommentVo comment);
	List<QnaCommentVo> commentListService(int bno);

	int updateStatus(int bno);
}
