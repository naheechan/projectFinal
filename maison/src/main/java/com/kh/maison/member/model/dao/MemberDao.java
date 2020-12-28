package com.kh.maison.member.model.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;

public interface MemberDao {
	
	int insertMember(SqlSessionTemplate session, Member mem);
	Member selectMemberOne(SqlSessionTemplate session, String id);
	int updateAuthKey(SqlSessionTemplate session, Map<String,String> map);
	int updateAuthStatus(SqlSessionTemplate session, String id);

	List<Member> findId(SqlSessionTemplate session,Member mem);
	List<Member> findPw(SqlSessionTemplate session,Member mem);
	
	int updatePw(SqlSessionTemplate session,Member mem);

	
	int updateMember(SqlSessionTemplate session, Member mem);
	
	int updateMemberPw(SqlSessionTemplate session,Map<String,String> map);

	int updateEmailStatus(SqlSessionTemplate session,Map<String,Object> target);

	int updateMemberStatus(SqlSessionTemplate session, Map<String,Object> target);

	int updateMemberWithdraw(SqlSessionTemplate session,Map<String,Object> target);
	
	int updateMileage(SqlSessionTemplate session,Member m);

}
