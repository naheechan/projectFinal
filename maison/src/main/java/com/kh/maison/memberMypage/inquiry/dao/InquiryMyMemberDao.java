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
	int selectDellCount(SqlSession session, Member id);
	
	List<TotalInquiryList> searchkeyword(SqlSession session, Map<String,Object> param);
	
	List<TotalInquiryList> searchList(SqlSession sesseion, String searchType,String keyword,String id, int cPage, int numPerPage);
	
	int selectListCount(SqlSession session,String id);
	
	int searchCount(SqlSession session, String searchType,String keyword,String id);
	
	List<TotalInquiryList> selectMyList(SqlSession session, String id, int cPage, int numPerPage);
	
	List<TotalInquiryList> replySuccess(SqlSession session,String id,int cPage,int numPerPage);
	
	int selectSuccessCount(SqlSession session,String id);
	
	List<TotalInquiryList> replyYet(SqlSession session,String id,int cPage,int numPerPage);
	
	int selectYetCount(SqlSession session,String id);
	
	List<TotalInquiryList> replydel(SqlSession session,String id,int cPage,int numPerPage);
	
	int selectDelCount(SqlSession session,String id);
	
	int deleteIq(SqlSession session,String no,String id);
	
	int deleteRep(SqlSession session,String no);
}
