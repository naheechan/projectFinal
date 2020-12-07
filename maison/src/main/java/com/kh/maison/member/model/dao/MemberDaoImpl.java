package com.kh.maison.member.model.dao;

import java.sql.Date;
import java.util.List;
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
	public List<Member> findId(SqlSessionTemplate session, Member mem) {
		
		return session.selectList("member.findId",mem);
	


	}
}
