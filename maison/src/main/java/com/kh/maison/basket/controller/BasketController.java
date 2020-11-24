package com.kh.maison.basket.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.basket.model.service.BasketService;

@Controller
public class BasketController {

	@Autowired
	private BasketService service;
	
	@RequestMapping("basket/basket.do")
	public ModelAndView basket(ModelAndView mv,HttpSession session) {
		
		//합치면 주석해제~
		//Member m=(Member)session.getAttribute("loginMember");
		//String memberId=m.getMemberId();
		String memberId="user1";
		List<Map> list=service.selectBasketList(memberId);
		Map m=list.get(0);
		mv.addObject("list",list);
		mv.setViewName("basket/basket");
		return mv;
	}
	
	@RequestMapping("basket/deleteBasket.do")
	public String deleteBasket(int basketNo) {
		
		int result=service.deleteBasket(basketNo);
		
		return "redirect:/basket/basket.do";
	}
	
}
