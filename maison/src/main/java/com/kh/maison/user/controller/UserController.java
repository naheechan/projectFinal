package com.kh.maison.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.user.model.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	
	@RequestMapping(value="/user/login")
	public ModelAndView login(ModelAndView mv) {
		
		mv.setViewName("user/login");
		
		return mv;
	}
	
	@RequestMapping(value="/user/enroll")
	public ModelAndView enroll(ModelAndView mv) {
		mv.setViewName("user/enroll");
		return mv;
	}
	
	
}
