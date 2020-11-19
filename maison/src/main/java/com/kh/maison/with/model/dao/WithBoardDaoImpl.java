package com.kh.maison.with.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.with.model.vo.WithBoard;

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

}
