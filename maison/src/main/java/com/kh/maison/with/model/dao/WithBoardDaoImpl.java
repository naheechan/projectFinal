package com.kh.maison.with.model.dao;

import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.with.model.vo.WithAsk;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

@Repository
public class WithBoardDaoImpl implements WithBoardDao {

	@Override
	public int insertWith(SqlSessionTemplate session, WithBoard wb) {
		// TODO Auto-generated method stub
		return session.insert("with.insertWith",wb);
	}

	@Override
	public List<WithBoard> selectAllWith(SqlSessionTemplate session, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("with.selectAllWith",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectWithCount(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("with.selectWithCount");
	}

	@Override
	public WithBoard selectOneWith(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("with.selectOneWith",no);
	}

	@Override
	public int insertWithReply(SqlSessionTemplate session, WithComment comment) {
		// TODO Auto-generated method stub
		return session.insert("with.insertWithReply",comment);
	}

	@Override
	public List<WithComment> selectAllWithReply(SqlSessionTemplate session, int bno) {
		// TODO Auto-generated method stub
		return session.selectList("with.selectAllWithReply",bno);
	}

	@Override
	public int insertWithReplySecond(SqlSessionTemplate session, WithComment comment) {
		// TODO Auto-generated method stub
		return session.insert("with.insertWithReplySecond",comment);
	}

	@Override
	public int deleteWithReply(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.update("with.deleteWithReply",no);
	}

	@Override
	public WithComment selectOneWithReply(SqlSessionTemplate session, int wcNo) {
		// TODO Auto-generated method stub
		return session.selectOne("with.selectOneWithReply",wcNo);
	}

	@Override
	public int withBoardCount(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.update("with.withBoardCount",no);	
	}

	@Override
	public int updateWithReply(SqlSessionTemplate session, WithComment wc) {
		// TODO Auto-generated method stub
		return session.update("with.updateWithReply",wc);
	}

	@Override
	public int withStatusUpdate(SqlSessionTemplate session, WithBoard wb) {
		// TODO Auto-generated method stub
		return session.update("with.withStatusUpdate",wb);
	}

	@Override
	public int removeWith(SqlSessionTemplate session, int wbNo) {
		// TODO Auto-generated method stub
		return session.update("with.removeWith",wbNo);
	}

	@Override
	public int insertWithReport(SqlSessionTemplate session, WithReport wr) {
		// TODO Auto-generated method stub
		return session.insert("with.withReportInsert",wr);
	}

	@Override
	public int updateWith(SqlSessionTemplate session, WithBoard wb) {
		// TODO Auto-generated method stub
		return session.update("with.withUpdate",wb);
	}

	@Override
	public int inserWithAsk(SqlSessionTemplate session, WithAsk wa) {
		// TODO Auto-generated method stub
		return session.insert("with.withAskInsert",wa);
	}

	@Override
	public Member selectEmailAndPhone(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("with.withEmailAndPhone",no);
	}

	@Override
	public List<WithBoard> bringAllWithBoard(SqlSessionTemplate session, String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("with.bringAllWithBoard",memberId,
				new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

	@Override
	public int bringAllWithBoardCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("with.bringAllWithBoardCount",memberId);
	}

	@Override
	public List<WithComment> bringAllWithComment(SqlSessionTemplate session, String memberId, int cPage,
			int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("with.bringAllWithComment",memberId,
				new RowBounds((cPage-1)*numPerPage, numPerPage));
	}

	@Override
	public int bringAllWithCommentCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("with.bringAllWithCommentCount",memberId);
	}

	@Override
	public List<WithBoard> bringCommentedWith(SqlSessionTemplate session, String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("with.bringCommentedWith",memberId,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int bringCommentedWithCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("with.bringCommentedWithCount",memberId);
	}

	@Override
	public int deleteBringAllWith(SqlSessionTemplate session, int checkfordelete) {
		// TODO Auto-generated method stub
		return session.update("with.deleteBringAllWith",checkfordelete);
	}

	@Override
	public int deleteBringAllWithComment(SqlSessionTemplate session, int checkStatus) {
		// TODO Auto-generated method stub
		return session.update("with.deleteBringAllWithComment",checkStatus);
	}

	@Override
	public WithReport selectOneWithReport(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("with.selectOneWithReport",no);
	}

	@Override
	public int updateWithReport(SqlSessionTemplate session, WithReport wr) {
		// TODO Auto-generated method stub
		return session.update("with.updateWithReport",wr);
	}
	


}
