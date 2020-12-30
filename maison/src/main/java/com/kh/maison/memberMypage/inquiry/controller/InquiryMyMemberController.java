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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.common.PageBarFactory2;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.service.InquiryMyMemberService;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;
import com.kh.maison.shop.model.vo.InquiryReply;
import com.kh.spring.common.PageBarFactory;

@Controller
@RequestMapping("/member/mypage/inquiry")
public class InquiryMyMemberController {

	@Autowired
	private InquiryMyMemberService service;
	
	
	@RequestMapping("/viewList.do")
	public ModelAndView moveViewList(Model m, @SessionAttribute("loginMember") Member id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7")int numPerPage,ModelAndView mv) {
		List<TotalInquiryList> list = service.selectTotalList(cPage, numPerPage,id);
		
		int totalData = service.selectTotalCount(id);
		
		int checkData = service.selectCheckCount(id);
		int noCheckData = service.selectNoCheckCount(id);
		int delData = service.selectDellCount(id);
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("mycount",totalData);
		map.put("success",checkData);
		map.put("yet",noCheckData);
		map.put("del",delData);
		map.put("map",map);
		mv.addObject("map",map);
		mv.setViewName("member/mypage/inquiry/viewList");
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "viewList.do"));
		
		
		return mv;
	}
	//멤버마이페이지검색
	@RequestMapping("search.do")
	public ModelAndView searchList(@RequestParam(value="searchType")String searchType,
			@RequestParam(value="keyword")String keyword,@RequestParam(value="memberId")String id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="10")int numPerPage)throws Exception{
		
		List<TotalInquiryList> list = service.searchList(searchType,keyword,id,cPage,numPerPage);
		int count  = service.selectListCount(id);
		int searchCount = service.searchCount(searchType,keyword,id);
		
		ModelAndView mv = new ModelAndView();
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("mycount",count);
		map.put("searchCount",searchCount);
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		map.put("map",map);
		mv.addObject("map",map);
		mv.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage, "search.do"));
		mv.setViewName("member/mypage/inquiry/viewList");
		return mv;
	}
	
	@RequestMapping("/myWrite.do")
	public ModelAndView myWrite(Model m,String id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7")int numPerPage,ModelAndView mv) {
		List<TotalInquiryList> list = service.selectMyList(id,cPage,numPerPage);
		int count = service.selectListCount(id);
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("mycount",count);
		map.put("map",map);
		mv.addObject("map",map);
		mv.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage, "myWrite.do"));
		mv.setViewName("member/mypage/inquiry/viewList");
		return mv;
	}
	
//	@ResponseBody
//	@RequestMapping("/myWrite.do")
//	public String myWrite(Model m,String id,
//			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
//			@RequestParam(value="numPerPage", required=false, defaultValue="10")int numPerPage,ModelAndView mv) {
//		
//		List<TotalInquiryList> list = null;
//		int count=0;
//		String str="";
//		ObjectMapper mapper = new ObjectMapper();
//		try {
//			list = service.selectMyList(id,cPage,numPerPage);
//			count = service.selectListCount(id);
//			str=mapper.writeValueAsString(list);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		Map<String,Object> map = new HashMap<>();
//		map.put("list",list);
//		map.put("mycount",count);
//		map.put("map",map);
//		mv.addObject("map",map);
//		mv.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage, "myWrite.do"));
//		return str;
//	}
	
	@RequestMapping("replySuccess.do")
	public ModelAndView replySuccess(ModelAndView mv,String id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7")int numPerPage) {
			List<TotalInquiryList> list = service.replySuccess(id,cPage,numPerPage);
			int count = service.selectSuccessCount(id);
			Map<String,Object> map = new HashMap<>();
			map.put("list",list);
			map.put("success",count);
			map.put("map",map);
			mv.addObject("map",map);
			mv.addObject("pageBar",PageBarFactory2.getPageBar2(count, cPage, numPerPage, "replySuccess.do?id="+id));
			mv.setViewName("member/mypage/inquiry/viewList");
			return mv;
	}
	
	@RequestMapping("replyYet.do")
	public ModelAndView replyYet(ModelAndView mv,String id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7")int numPerPage) {
			List<TotalInquiryList> list = service.replyYet(id,cPage,numPerPage);
			int count = service.selectYetCount(id);
			Map<String,Object> map = new HashMap<>();
			map.put("list",list);
			map.put("yet",count);
			map.put("map",map);
			mv.addObject("map",map);
			mv.addObject("pageBar",PageBarFactory2.getPageBar2(count, cPage, numPerPage, "replyYet.do?id="+id));
			mv.setViewName("member/mypage/inquiry/viewList");
			return mv;
	}
	@RequestMapping("replydel.do")
	public ModelAndView replydel(ModelAndView mv,String id,
			@RequestParam(value="cPage", required=false, defaultValue="1")int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7")int numPerPage) {
			List<TotalInquiryList> list = service.replydel(id,cPage,numPerPage);
			int count = service.selectDelCount(id);
			Map<String,Object> map = new HashMap<>();
			map.put("list",list);
			map.put("del",count);
			map.put("map",map);
			mv.addObject("map",map);
			mv.addObject("pageBar",PageBarFactory2.getPageBar2(count, cPage, numPerPage, "replydel.do?id="+id));
			mv.setViewName("member/mypage/inquiry/viewList");
			return mv;
	}
	
	@RequestMapping("/deleteIq.do")
	public ModelAndView deleteIq(@RequestParam(value="no")String no,ModelAndView mv,@RequestParam(value="id")String id) {
		//piDel N으로 업뎃 + reply까지 같이 삭제+memberstatus?
		int repResult =0;
		int iqResult = service.deleteIq(no,id);
		if(iqResult>0) {
			repResult = service.deleteRep(no);
		}
			mv.addObject("msg",iqResult>0?"삭제완료":"삭제실패");
			mv.addObject("loc","/member/mypage/inquiry/viewList.do");
			mv.setViewName("common/msg");
			return mv;
	}
	
	@RequestMapping("/update.do")
	public ModelAndView update(ModelAndView mv,
			@RequestParam(value="piNo") int no,
			@RequestParam(value="piContent") String piContent,
			@RequestParam(value="piCate") String piCate) {
		Map<String,Object> map = new HashMap<>();
		map.put("piNo",no);
		map.put("piContent",piContent);
		map.put("piCate",piCate);
		
		int result = service.updateInq(map);
		
		
			mv.addObject("msg",result>0?"문의수정이 성공적으로 완료되었습니다.":"문의수정을 실패하였습니다.");
			mv.addObject("loc","/member/mypage/inquiry/viewList.do");
			mv.setViewName("common/msg");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/reply.do")
	public String selectreply(ModelAndView mv,@RequestParam(value="no")String no) {
		List<InquiryReply> reply=null;
		String str=null;
		ObjectMapper mapper= new ObjectMapper();
		try {
			reply = service.selectReplyOne(no);
			
			str=mapper.writeValueAsString(reply);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
