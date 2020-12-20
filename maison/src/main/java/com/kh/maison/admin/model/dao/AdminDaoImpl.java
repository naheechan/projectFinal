package com.kh.maison.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public int selectFirstTotal(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectFirstTotal",numDate);
	}

	@Override
	public int selectFirstChange(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectFirstChange",numDate);
	}

	@Override
	public int selectFirstIn(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectFirstIn",numDate);
	}

	@Override
	public int selectFirstOut(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectFirstOut",numDate);
	}

	@Override
	public int selectSecondChange(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondChange",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondChange",sendNum);		
		}
	}

	@Override
	public int selectSecondIn(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondIn",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondIn",sendNum);			
		}
	}

	@Override
	public int selectSecondOut(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondOut",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondOut",sendNum);
		}
	}

}
