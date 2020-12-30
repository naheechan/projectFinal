package com.kh.maison.qnaBoard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.qnaBoard.model.vo.QnaBoardVo;
import com.kh.maison.qnaBoard.model.vo.QnaCommentVo;
@Repository
public class QnaBoardDaoImpl implements QnaBoardDao{

	public int insertQnaBoard(SqlSession session,QnaBoardVo QB) {
		return session.insert("qnaBoard.insertQnaBoard",QB);
	}

	@Override
	public List<QnaBoardVo> selectList(SqlSession session,int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("qnaBoard.selectList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public QnaBoardVo selectQna(SqlSession session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("qnaBoard.selectQna",no);
	}

	@Override
	public int selectCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("qnaBoard.selectCount");
	}

	@Override
	public int commentInsert(SqlSession session, QnaCommentVo comment) {
		
		return session.insert("qnaBoard.insertComment", comment);
	}

	@Override
	public List<QnaCommentVo> commentList(SqlSession session,int bno) {
		
		return session.selectList("qnaBoard.commentList",bno);
	}

	@Override
	public int updateStatus(SqlSession session, int bno) {
		
		return session.update("qnaBoard.updateStatus", bno);
	}

	@Override
	public List<QnaBoardVo> selectCommentList(SqlSession session, int cPage, int numPerPage, String msg) {

		return session.selectList("qnaBoard.selectCommentList",msg,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<QnaBoardVo> selectSearchList(SqlSession session, int cPage, int numPerPage, String keyword,
			String select) {

		// TODO Auto-generated method stub
		if(select.equals("title")) {
			return session.selectList("qnaBoard.selectSearchTitleList",keyword,new RowBounds((cPage-1)*numPerPage,numPerPage));			
		}else if(select.equals("both")) {

			return session.selectList("qnaBoard.selectSearchBothList",keyword,new RowBounds((cPage-1)*numPerPage,numPerPage));	
			
		}else if(select.equals("id")) {

			return session.selectList("qnaBoard.selectSearchIdList",keyword,new RowBounds((cPage-1)*numPerPage,numPerPage));	
		}
		return session.selectList("qnaBoard.selectSearchTitleList",keyword,new RowBounds((cPage-1)*numPerPage,numPerPage));	
	}

	@Override
	public int countMyQna(SqlSession session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("qnaBoard.countMyQna",param);
	}
	
	

}
