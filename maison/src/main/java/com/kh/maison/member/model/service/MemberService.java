package com.kh.maison.member.model.service;

import com.kh.maison.member.model.vo.Member;

public interface MemberService {
	
	int insertMember(Member mem);
	Member selectMemberOne(String id);

}
