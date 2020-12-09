package com.kh.maison.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.order.model.vo.Order;

@Controller
public class OrderController {
	
	@RequestMapping("/order/insertOrder.do")
	public ModelAndView insertOrder(ModelAndView mv,Order o) {
		
		System.out.println(o);
		//마일리지 계산
		o.setMileage(o.getMileage()+o.getStackMile()-o.getUseMile());
		
		
		return mv;
	}
	
}
