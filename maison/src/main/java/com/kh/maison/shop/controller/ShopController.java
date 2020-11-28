package com.kh.maison.shop.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
		@RequestParam(value="numPerPage", required=false, defaultValue="9") int numPerPage) {
		List<Product> list = service.selectProduct(cPage,numPerPage);
		int totalData = service.selectCount();
		//대분류
		List<Category> catelist = service.selectCategory();
		//중분류
		List<Category> medicate=service.selectMediCate();
		
		//각 카테고리별 
		
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "shopView.do"));
		m.addAttribute("count",totalData);
		m.addAttribute("medicate",medicate);
		m.addAttribute("category",catelist);
		m.addAttribute("product",list);
		System.out.println("categorylist in controlloer"+catelist);
		System.out.println("productlist in controller"+list);
		System.out.println("medicate in controller "+medicate);
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
	
	@ResponseBody
	@RequestMapping("/search.do")
	public String searchName(@RequestParam(value="keyword", required=true)String keyword,
										HttpServletResponse response) throws Exception{
		List<Product> p = null;
		ObjectMapper mapper = new ObjectMapper();
		String str = null;
		try {
				p=service.selectOneMediCate(keyword);
				str=mapper.writeValueAsString(p);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	

}
