package com.kh.maison.qnaBoard.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.maison.qnaBoard.model.dao.QnaBoardDao;
import com.kh.maison.qnaBoard.model.vo.QnaBoardVo;
import com.kh.maison.qnaBoard.model.vo.QnaCommentVo;

@Service
public class QnaBoardServiceImpl implements QnaBoardService{
	
	@Autowired
	private QnaBoardDao dao;
	@Autowired
	private SqlSession session;
	
	public int insertQnaBoard(QnaBoardVo QB){
		int result=dao.insertQnaBoard(session,QB);
		return result; 
	}

	@Override
	public List<QnaBoardVo> selectList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectList(session,cPage,numPerPage);
	}

	@Override
	public QnaBoardVo selectQna(int no) {
		
		return dao.selectQna(session,no);
	}

	@Override
	public int selectCount() {
		// TODO Auto-generated method stub
		return dao.selectCount(session);
	}

	@Override
	public int commentInsertService(QnaCommentVo comment) {
		
		return dao.commentInsert(session,comment);
	}

	@Override
	public List<QnaCommentVo> commentListService(int bno) {
	
		return dao.commentList(session,bno);
	}

	@Override
	public int updateStatus(int bno) {
		
		return dao.updateStatus(session,bno);
	}

	@Override
	public List<QnaBoardVo> selectCommentList(int cPage, int numPerPage, String msg) {
		
		return dao.selectCommentList(session,cPage,numPerPage,msg);
	}

	@Override
	public List<QnaBoardVo> selectSearchList(int cPage, int numPerPage, String keyword, String select) {
		// TODO Auto-generated method stub
		return dao.selectSearchList(session,cPage,numPerPage,keyword,select);
	}
	
	
	
	
}
