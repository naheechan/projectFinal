package com.kh.maison.member.model.service;

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
	
	//회원정보 변경 관련
	@Override
	public int updateMember(Member mem) {
		// TODO Auto-generated method stub
		return dao.updateMember(session,mem);
	}
	
	
	
	
	
}
