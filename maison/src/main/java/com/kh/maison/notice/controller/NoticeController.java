package com.kh.maison.notice.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.common.PageBarFactory;
import com.kh.maison.notice.model.service.NoticeService;
import com.kh.maison.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("/notice/noticeList.do")
	public ModelAndView noticeList(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		List<Notice> list=service.selectNoticeList(cPage,numPerPage);
		int totalData=service.selectCount();
		
		
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "noticeList.do"));
		mv.addObject("totalData",totalData);
		mv.addObject("list",list);
		mv.setViewName("notice/noticeList");
		return mv;
	}
	
	@RequestMapping("/notice/noticeAdd.do")
	public String noticeAdd() {
		return "notice/noticeAdd";
	}
	
	@RequestMapping("/notice/noticeAddEnd.do")
	public String noticaAddEnd(@RequestParam Map<String,String> param) {
		
		int result=service.insertNotice(param);
		return "redirect:notice/noticeList.do";
	}

	@RequestMapping("/notice/noticeOne.do")
	public ModelAndView noticeOne(int noticeNo,ModelAndView mv) {
		
		Notice n=service.selectNoticeOne(noticeNo);
		
		mv.addObject("n",n);
		
		mv.setViewName("/notice/noticeDetail");
		return mv;
	}

	
	
	
}
