package com.kh.maison.memberMypage.inquiry.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;

public interface InquiryMyMemberDao {

	List<TotalInquiryList> selectTotalList(SqlSession session, int cPage, int numPerPage, Member id);
	
	int selectTotalCount(SqlSession session, Member id);
	
	int selectCheckCount(SqlSession session, Member id);
	int selectNoCheckCount(SqlSession session, Member id);
	int selectDelCount(SqlSession session, Member id);
	
	List<TotalInquiryList> searchkeyword(SqlSession session, Map<String,Object> param);
}
