package com.kh.maison.memberMypage.inquiry.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.service.InquiryMyMemberService;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;
import com.kh.spring.common.PageBarFactory;

@Controller
@RequestMapping("/member/mypage/inquiry")
public class InquiryMyMemberController {

	@Autowired
	private InquiryMyMemberService service;
	
	
	@RequestMapping("/viewList.do")
	public String moveViewList(Model m, @SessionAttribute("loginMember") Member id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="10")int numPerPage) {
		List<TotalInquiryList> list = service.selectTotalList(cPage, numPerPage,id);
		
		int totalData = service.selectTotalCount(id);
		
		int checkData = service.selectCheckCount(id);
		int noCheckData = service.selectNoCheckCount(id);
		int delData = service.selectDelCount(id);
		
		m.addAttribute("checkcount",checkData);
		m.addAttribute("nocheckcount",noCheckData);
		m.addAttribute("delcount",delData);
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "viewList.do"));
		m.addAttribute("totalcount",totalData);
		m.addAttribute("totalList",list);
		System.out.println("totalList in controller : "+list);
		
		return "member/mypage/inquiry/viewList";
	}
	
//	@ResponseBody
//	@RequestMapping("/searchkeyword.do")
//	public String searchkeyword(@RequestParam(value="id")String id,@RequestParam(value="keyword") String keyword) {
//		List<TotalInquiryList> list = null;
//		String str = null;
//		Map<String,Object> param = new HashMap<>();
//		param.put("id",id);
//		param.put("keyword",keyword);
//		System.err.println("param"+param);
//		try {
//			
//			list = service.searchkeyword(param);
//			ObjectMapper mapper = new ObjectMapper();
//			str=mapper.writeValueAsString(list);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		System.out.println(keyword);
//		System.out.println("카테고리검색:"+list);
//		return str;
//	}
	
	
}
