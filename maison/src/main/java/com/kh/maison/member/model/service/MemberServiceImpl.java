package com.kh.maison.member.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.member.model.dao.MemberDao;
import com.kh.maison.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao dao;
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertMember(Member mem) {
		return dao.insertMember(session, mem);
	}

	@Override
	public Member selectMemberOne(String id) {
		return dao.selectMemberOne(session, id);
	}

	@Override
	public int updateAuthKey(Map<String,String> map) {
		return dao.updateAuthKey(session, map);
	}

	@Override
	public int updateAuthStatus(String id) {
		return dao.updateAuthStatus(session, id);
	}

	@Override
	public List<Member> findId(Member mem) {

		return dao.findId(session,mem);
	}

	@Override
	public List<Member> findPw(Member mem) {
		
		return dao.findPw(session,mem);
	}

	@Override
	public int updatePw(Member mem) {
		
		return dao.updatePw(session,mem);
	}
	
	
	
	
	
}
