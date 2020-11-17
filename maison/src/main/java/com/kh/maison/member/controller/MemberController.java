package com.kh.maison.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.member.model.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	
	@RequestMapping(value="/member/login")
	public ModelAndView login(ModelAndView mv) {
		
		mv.setViewName("member/login");
		
		return mv;
	}
	
	@RequestMapping(value="/member/enroll")
	public ModelAndView enroll(ModelAndView mv) {
		mv.setViewName("member/enroll");
		return mv;
	}
	
	
}
