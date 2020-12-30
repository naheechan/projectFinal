package com.kh.maison.qnaBoard.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.qnaBoard.model.vo.QnaBoardVo;
import com.kh.maison.qnaBoard.model.vo.QnaCommentVo;

public interface QnaBoardService {
	
	List<QnaBoardVo> selectList(int cPage, int numPerPage);
	List<QnaBoardVo> selectCommentList(int cPage, int numPerPage,String msg);
	List<QnaBoardVo> selectSearchList(int cPage, int numPerPage,String keyword,String select);
	
	int selectCount();
	
	int insertQnaBoard(QnaBoardVo QB);
	
	QnaBoardVo selectQna(int no);
	
	//댓글
	int commentInsertService(QnaCommentVo comment);
	List<QnaCommentVo> commentListService(int bno);

	int updateStatus(int bno);
	int countMyQna(Map param);
}
