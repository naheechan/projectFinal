package com.kh.maison.memberMypage.inquiry.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.dao.InquiryMyMemberDao;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;

@Service
public class InquiryMyMemberServiceImpl implements InquiryMyMemberService {

	@Autowired
	private InquiryMyMemberDao dao;
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<TotalInquiryList> selectTotalList(int cPage, int numPerPage, Member id) {
		return dao.selectTotalList(session,cPage,numPerPage,id);
	}
	
	@Override
	public int selectTotalCount(Member id) {
		return dao.selectTotalCount(session,id);
	}

	@Override
	public int selectCheckCount(Member id) {
		return dao.selectCheckCount(session,id);
	}

	@Override
	public int selectNoCheckCount(Member id) {
		return dao.selectNoCheckCount(session,id);
	}

	@Override
	public int selectDelCount(Member id) {
		return dao.selectDelCount(session,id);
	}

	@Override
	public List<TotalInquiryList> searchkeyword(Map<String,Object> param) {
		return dao.searchkeyword(session,param);
	}

	
	
	
}
