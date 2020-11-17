package com.kh.maison.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.maison.notice.model.service.NoticeService;
import com.kh.maison.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	NoticeService service;
	@RequestMapping("/notice/noticeList.do")
	public String noticeList(Model m) {
		
		List<Notice> list=service.selectNoticeList();
		
		
		
		return "notice/noticeList";
	}
	
	@RequestMapping("/notice/noticeAdd.do")
	public String noticeAdd() {
		return "notice/noticeAdd";
	}
	
}
