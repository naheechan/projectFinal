package com.kh.maison.admin.order.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.admin.order.model.service.OrderAdminService;
import com.kh.maison.common.PageBarFactory;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.vo.Order;

@Controller
public class OrderAdminController {
	
	@Autowired
	private OrderAdminService service;
	

	@RequestMapping("/admin/order/orderManagement.do")
	public ModelAndView selectOrderList(ModelAndView mv,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		
		
		List<Order> list=service.selectOrderList(cPage,numPerPage);
		int totalData=service.selectTotalCount();
		
		
		mv.addObject("list",list);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "orderManagement.do"));
		
		mv.setViewName("admin/order/orderManagement");
		return mv;
	}
	
}
