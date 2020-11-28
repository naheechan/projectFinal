package com.kh.maison.basket.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.basket.model.vo.Basket;

@Controller
public class BasketController {

	@Autowired
	private BasketService service;
	
	@RequestMapping("basket/basket.do")
	public ModelAndView basket(ModelAndView mv,HttpSession session) {
		
		//합치면 주석해제~
		//Member m=(Member)session.getAttribute("loginMember");
		//if(m!=null){
		//String memberId=m.getMemberId();
		//List<Map> list=service.selectBasketList(memberId);
		//	mv.addObject("list",list);
		//}else{
		// mv.addObject("list","");
		//}
		String memberId="user1";
		List<Map> list=service.selectBasketList(memberId);
		mv.addObject("list",list);
		mv.setViewName("basket/basket");
		return mv;
	}
	
	@RequestMapping("basket/deleteBasket.do")
	public String deleteBasket(int basketNo) {
		
		int result=service.deleteBasket(basketNo);
		
		return "redirect:/basket/basket.do";
	}
	
	@RequestMapping("basket/upDown.do")
	@ResponseBody
	public ModelAndView upDown(@RequestParam Map param,HttpServletResponse response,ModelAndView mv) 
			throws JsonMappingException,JsonGenerationException,IOException{
		
		//수량 변경
		int result=service.updateAmount(param);
		
		//다시불러오기
		//합치면 주석해제~
				//Member m=(Member)session.getAttribute("loginMember");
				//String memberId=m.getMemberId();
		
		String memberId="user1";
		List<Map> list=service.selectBasketList(memberId);
		mv.addObject("list",list);
		mv.setViewName("/basket/amountChange");
		
		return mv;
	}
	
	@RequestMapping("basket/orderBasket")
	public ModelAndView orderBasket(ModelAndView mv,HttpServletRequest request) {
		
		String msg="";
		String loc="";
		
		String[] basketNos=request.getParameterValues("basketNo");
		
		//장바구니에 상품이 없을때
		if(basketNos==null) {
			msg="장바구니에 담긴 상품이 없습니다 !";
			loc="/basket/basket.do";
			mv.addObject("msg",msg);
			mv.addObject("loc",loc);
			mv.setViewName("common/msg");
			return mv;
			
		}
		//장바구니에 상품이 있음
		
		//상품 수량이 있음
		
		
		//상품 수량이 부족함
		
		
		//리스트 받아오기
		List<Basket> list=new ArrayList<Basket>();
		for(String basketNo : basketNos) {
			list.add(service.selectBasketOne(Integer.parseInt(basketNo)));
			
		}
		mv.addObject("list", list);
		
		return mv;
	}
	
}
