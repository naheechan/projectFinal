package com.kh.maison.memberMypage.inquiry.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.dao.InquiryMyMemberDao;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;
import com.kh.maison.shop.model.vo.InquiryReply;

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
	public int selectDellCount(Member id) {
		return dao.selectDellCount(session,id);
	}

	@Override
	public List<TotalInquiryList> searchkeyword(Map<String,Object> param) {
		return dao.searchkeyword(session,param);
	}

	@Override
	public List<TotalInquiryList> searchList(String searchType, String keyword, String id, int cPage, int numPerPage) {
		return dao.searchList(session,searchType,keyword,id,cPage,numPerPage);
	}

	@Override
	public int selectListCount(String id) {
		return dao.selectListCount(session,id);
	}

	@Override
	public int searchCount(String searchType, String keyword, String id) {
		return dao.searchCount(session,searchType,keyword,id);
	}

	@Override
	public List<TotalInquiryList> selectMyList(String id, int cPage, int numPerPage) {
		return dao.selectMyList(session,id,cPage,numPerPage);
	}

	@Override
	public List<TotalInquiryList> replySuccess(String id, int cPage, int numPerPage) {
		return dao.replySuccess(session,id,cPage,numPerPage);
	}

	@Override
	public int selectSuccessCount(String id) {
		return dao.selectSuccessCount(session,id);
	}

	@Override
	public List<TotalInquiryList> replyYet(String id, int cPage, int numPerPage) {
		return dao.replyYet(session,id,cPage,numPerPage);
	}

	@Override
	public int selectYetCount(String id) {
		return dao.selectYetCount(session,id);
	}

	@Override
	public List<TotalInquiryList> replydel(String id, int cPage, int numPerPage) {
		return dao.replydel(session,id,cPage,numPerPage);
	}

	@Override
	public int selectDelCount(String id) {
		return dao.selectDelCount(session,id);
	}

	@Override
	public int deleteIq(String no,String id) {
		return dao.deleteIq(session,no,id);
	}

	@Override
	public int deleteRep(String no) {
		return dao.deleteRep(session,no);
	}

	@Override
	public int updateInq(Map<String, Object> map) {
		return dao.updateInq(session,map);
	}

	@Override
	public List<InquiryReply> selectReplyOne(String no) {
		return dao.selectReplyOne(session,no);
	}

	
	
	
}
