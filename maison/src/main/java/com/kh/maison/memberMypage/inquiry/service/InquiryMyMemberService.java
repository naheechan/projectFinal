package com.kh.maison.memberMypage.inquiry.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;

public interface InquiryMyMemberService {

	List<TotalInquiryList> selectTotalList(int cPage, int numPerPage, Member id);
	
	int selectTotalCount(Member id);
	
	int selectCheckCount(Member id);//답변완료 수
	int selectNoCheckCount(Member id);//미답변 수
	int selectDelCount(Member id);//문의삭제 수
	
	List<TotalInquiryList> searchkeyword(Map<String,Object> param);
}
