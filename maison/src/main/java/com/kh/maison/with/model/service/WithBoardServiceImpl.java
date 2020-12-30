package com.kh.maison.with.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.with.model.dao.WithBoardDao;
import com.kh.maison.with.model.vo.WithAsk;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

@Service
public class WithBoardServiceImpl implements WithBoardService {

	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	private WithBoardDao dao;

	@Override
	public int insertWith(WithBoard wb) {
		// TODO Auto-generated method stub
		int result = dao.insertWith(session,wb);
		return result;
	}

	@Override
	public List<WithBoard> selectAllWith(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<WithBoard> list = dao.selectAllWith(session,cPage,numPerPage);
		return list;
	}

	@Override
	public int selectWithCount() {
		// TODO Auto-generated method stub
		int result = dao.selectWithCount(session);
		return result;
	}

	@Override
	public WithBoard selectOneWith(int no) {
		// TODO Auto-generated method stub
		WithBoard wb = dao.selectOneWith(session,no);
		return wb;
	}

	@Override
	public int insertWithReply(WithComment comment) {
		// TODO Auto-generated method stub
		int result = dao.insertWithReply(session,comment);
		return result;
	}

	@Override
	public List<WithComment> selectAllWithReply(int bno) {
		// TODO Auto-generated method stub
		List<WithComment> list = dao.selectAllWithReply(session,bno);
		return list;
	}

	@Override
	public int insertWithReplySecond(WithComment comment) {
		// TODO Auto-generated method stub
		int result = dao.insertWithReplySecond(session,comment);
		return result;
	}

	@Override
	public int deleteWithReply(int no) {
		// TODO Auto-generated method stub
		int result = dao.deleteWithReply(session,no);
		return result;
	}

	@Override
	public WithComment selectOneWithReply(int wcNo) {
		// TODO Auto-generated method stub
		WithComment wc = dao.selectOneWithReply(session,wcNo);
		return wc;
	}

	@Override
	public int withBoardCount(int no) {
		// TODO Auto-generated method stub
		int result = dao.withBoardCount(session,no);
		return result;
	}

	@Override
	public int updateWithReply(WithComment wc) {
		// TODO Auto-generated method stub
		int result = dao.updateWithReply(session,wc);
		return result;
	}

	@Override
	public int withStatusUpdate(WithBoard wb) {
		// TODO Auto-generated method stub
		int result = dao.withStatusUpdate(session,wb);
		return result;
	}

	@Override
	public int removeWith(int wbNo) {
		// TODO Auto-generated method stub
		int result = dao.removeWith(session,wbNo);
		return result;
	}

	@Override
	public int insertWithReport(WithReport wr) {
		// TODO Auto-generated method stub
		int result = dao.insertWithReport(session,wr);
		return result;
	}

	@Override
	public int updateWith(WithBoard wb) {
		// TODO Auto-generated method stub
		int result = dao.updateWith(session, wb);
		return result;
	}

	@Override
	public int insertWithask(WithAsk wa) {
		// TODO Auto-generated method stub
		int result = dao.inserWithAsk(session,wa);
		return result;
	}

	@Override
	public Member selectEmailAndPhone(int no) {
		// TODO Auto-generated method stub
		Member m = dao.selectEmailAndPhone(session,no);
		return m;
	}
	
	//여기부터 마이페이지 함께해요 관련.
	@Override
	public List<WithBoard> bringAllWithBoard(String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<WithBoard> list = dao.bringAllWithBoard(session,memberId,cPage,numPerPage);
		return list;
	}

	@Override
	public int bringAllWithBoardCount(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.bringAllWithBoardCount(session,memberId);
		return result;
	}

	@Override
	public List<WithComment> bringAllWithComment(String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<WithComment> list = dao.bringAllWithComment(session,memberId,cPage,numPerPage);
		return list;
	}

	@Override
	public int bringAllWithCommentCount(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.bringAllWithCommentCount(session,memberId);
		return result;
	}

	@Override
	public List<WithBoard> bringCommentedWith(String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<WithBoard> list = dao.bringCommentedWith(session,memberId,cPage,numPerPage);
		return list;
	}

	@Override
	public int bringCommentedWithCount(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.bringCommentedWithCount(session,memberId);
		return result;
	}

	@Override
	public int deleteBringAllWith(int checkfordelete) {
		// TODO Auto-generated method stub
		int result = dao.deleteBringAllWith(session,checkfordelete);
		return result;
	}

	@Override
	public int deleteBringAllWithComment(int checkStatus) {
		// TODO Auto-generated method stub
		int result = dao.deleteBringAllWithComment(session,checkStatus);
		return result;
	}

	@Override
	public WithReport selectOneWithReport(int no) {
		// TODO Auto-generated method stub
		return dao.selectOneWithReport(session,no);
	}

	@Override
	public int updateWithReport(WithReport wr) {
		// TODO Auto-generated method stub
		return dao.updateWithReport(session,wr);
	}
}
