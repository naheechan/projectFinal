package com.kh.maison.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;

public interface MemberDao {
	
	int insertMember(SqlSessionTemplate session, Member mem);
	Member selectMemberOne(SqlSessionTemplate session, String id);

}
