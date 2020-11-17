package com.kh.maison.with.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WithController {
	
	@RequestMapping("/with/withList.do")
	public String selectAllWith() {
		return "with/withList";
	}
	
	@RequestMapping("/with/withEnroll.do")
	public String enrollWith() {
		return "with/withEnroll";
	}

}
