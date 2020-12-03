package com.kh.maison.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.review.model.service.ReviewService;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.vo.Product;
@Controller
public class ReviewController {

	@Autowired
	ReviewService service;
	
	@Autowired
	ProductService pservice;
	
	@RequestMapping("/shop/insertReview.do")
	public ModelAndView insertReview(ModelAndView mv,int productNo) {
		
		System.out.println("컨트롤러는 오니 ??");
		Product p=pservice.selectProductOne(productNo);
		//나중에 오더디테일도 불러와야함
		//OrderDetail od=;
		
		mv.addObject("p",p);
		//mv.addObject("od",od);
		mv.setViewName("/shop/productReviewAdd");
		return mv ;
	}
	
	
}
