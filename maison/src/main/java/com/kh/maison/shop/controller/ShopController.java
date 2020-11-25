package com.kh.maison.shop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.common.PageBarFactory;
import com.kh.maison.shop.model.service.ShopService;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	private ShopService service;
	
	@RequestMapping("/shopView.do")
	public String moveShopView(Model m,
		@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
		@RequestParam(value="numPerPage", required=false, defaultValue="10") int numPerPage) {
		List<Product> list = service.selectProduct(cPage,numPerPage);
		int totalData = service.selectCount();
		
		List<Category> catelist = service.selectCategory();
		List<Category> medicate=service.selectMediCate();
		
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "shopView.do"));
		m.addAttribute("count",totalData);
		m.addAttribute("medicate",medicate);
		m.addAttribute("category",catelist);
		m.addAttribute("product",list);
		System.out.println("categorylist in controlloer"+catelist);
		System.out.println("productlist in controller"+list);
		return "shop/shopView";
	}
	
	
	@RequestMapping("/product/requestP.do")
	public ModelAndView insertRequestProduct(String requestContent, ModelAndView mv) {
		
		
		int result = service.insertRequestProduct(requestContent);
		System.out.println(requestContent);
		mv.addObject("msg",result>0?"요청성공":"요청실패");
		mv.addObject("loc","/shop/shopView.do");
		mv.setViewName("common/msg");
		return mv;
	}
}
