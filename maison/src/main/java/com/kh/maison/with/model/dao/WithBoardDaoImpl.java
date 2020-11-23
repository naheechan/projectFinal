package com.kh.maison.with.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;

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

}
