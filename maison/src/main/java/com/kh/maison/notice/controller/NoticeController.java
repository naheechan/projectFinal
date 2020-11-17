package com.kh.maison.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.notice.model.service.NoticeService;
import com.kh.maison.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("/notice/noticeList.do")
	public String noticeList(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		List<Notice> list=service.selectNoticeList(cPage,numPerPage);
		
		return "notice/noticeList";
	}
	
	@RequestMapping("/notice/noticeAdd.do")
	public String noticeAdd() {
		return "notice/noticeAdd";
	}
	
}
