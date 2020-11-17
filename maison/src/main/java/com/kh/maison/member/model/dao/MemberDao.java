package com.kh.maison.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;

public interface MemberDao {
	
	public int insertMember(SqlSessionTemplate session, Member mem);

}
