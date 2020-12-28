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
	@Override
	public int updateMember(SqlSessionTemplate session, Member mem) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember",mem);
	}

	@Override
	public int updateMemberPw(SqlSessionTemplate session, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.update("member.updateMemberPw",map);
	}
	


	@Override
	public List<Member> findPw(SqlSessionTemplate session, Member mem) {
		// TODO Auto-generated method stub
		return session.selectList("member.findPw",mem);
	}

	@Override
	public int updatePw(SqlSessionTemplate session, Member mem) {
		// TODO Auto-generated method stub
		return session.update("member.updatePw", mem);
	}

	@Override
	public int updateEmailStatus(SqlSessionTemplate session, Map<String, Object> target) {
		// TODO Auto-generated method stub
		return session.update("member.updateEmailStatus",target);
	}

	@Override
	public int updateMemberStatus(SqlSessionTemplate session, Map<String, Object> target) {
		// TODO Auto-generated method stub
		return session.update("member.updateMemberStatus",target);
	}

	@Override
	public int updateMemberWithdraw(SqlSessionTemplate session, Map<String, Object> target) {
		// TODO Auto-generated method stub
		return session.insert("member.updateMemberWithdraw",target);
	}

	@Override
	public int updateMileage(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMileageTwo",m);
	}
	
	
}
