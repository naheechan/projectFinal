package com.kh.maison.memberMypage.inquiry.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;
import com.kh.maison.shop.model.vo.TotalInquiry;

public interface InquiryMyMemberService {

	List<TotalInquiryList> selectTotalList(int cPage, int numPerPage, Member id);
	
	int selectTotalCount(Member id);
	
	int selectCheckCount(Member id);//답변완료 수
	int selectNoCheckCount(Member id);//미답변 수
	int selectDellCount(Member id);//문의삭제 수
	
	List<TotalInquiryList> searchkeyword(Map<String,Object> param);
	
	List<TotalInquiryList> searchList(String searchType,String keyword,String id, int cPage, int numPerPage);
	
	int selectListCount(String id);
	
	int searchCount(String searchType,String keyword, String id);
	
	List<TotalInquiryList> selectMyList(String id,int cPage,int numPerPage);
	
	List<TotalInquiryList> replySuccess(String id,int cPage,int numPerPage);
	
	int selectSuccessCount(String id);
	
	List<TotalInquiryList> replyYet(String id,int cPage,int numPerPage);
	
	int selectYetCount(String id);
	
	List<TotalInquiryList> replydel(String id,int cPage,int numPerPage);
	
	int selectDelCount(String id);
	
	int deleteIq(String no,String id);//pidel=n update
	
	int deleteRep(String no);//pir delete
	
}
