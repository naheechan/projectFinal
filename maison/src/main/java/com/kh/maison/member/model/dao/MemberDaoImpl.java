package com.kh.maison.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public int insertMember(SqlSessionTemplate session, Member mem) {
		return session.insert("member.insertMember", mem);
	}

	@Override
	public Member selectMemberOne(SqlSessionTemplate session, String id) {
		return session.selectOne("member.selectMemberOne", id);
	}

	@Override
	public int updateAuthKey(SqlSessionTemplate session, Map<String,String> map) {
		return session.update("member.updateAuthKey", map);
	}

	@Override
	public int updateAuthStatus(SqlSessionTemplate session, String id) {
		return session.update("member.updateAuthStatus", id);
	}

	@Override
	public int updateMember(SqlSessionTemplate session, Member mem) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember",mem);
	}
	
	
	
	

}
