package com.kh.maison.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;

public interface MemberDao {
	
	int insertMember(SqlSessionTemplate session, Member mem);
	Member selectMemberOne(SqlSessionTemplate session, String id);
	int updateAuthKey(SqlSessionTemplate session, Map<String,String> map);
	int updateAuthStatus(SqlSessionTemplate session, String id);
	
	int updateMember(SqlSessionTemplate session, Member mem);
	
	int updateMemberPw(SqlSessionTemplate session,Map<String,String> map);

}
