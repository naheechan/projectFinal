package com.kh.maison.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.shop.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	@RequestMapping("/shop/shopList.do")
	public ModelAndView selectProductList(ModelAndView mv) {
		
		mv.addObject("list",service.selectProductList());
		mv.setViewName("shop/shopList");
		return mv;
	}
	
	@RequestMapping("/shop/shopView.do")
	public ModelAndView selectProductOne(ModelAndView mv, int no) {
		
		mv.addObject("product",service.selectProduct(no));
		mv.setViewName("shop/shopView");
		
		return mv;
	}
	
	@RequestMapping("/shop/wishList.do")
	public ModelAndView insertWishList(ModelAndView mv, int no) {
		
		int result=service.insertWishList(no);
		
		if(result>0) {
			mv.addObject("msg","위시리스트에 추가되었습니다.");
			mv.addObject("loc","/shop/shopView.do?no="+no);
			
		}else {
			mv.addObject("msg","이미 추가된 상품입니다.");
			mv.addObject("loc","/shop/shopView.do?no="+no);
		}
		
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/wishList.do")
	public ModelAndView wishList(ModelAndView mv) {
		
		mv.addObject("list",service.selectWishList());
		mv.setViewName("shop/wishList");
		
		return mv;
	}
	
	@RequestMapping("/deleteWishList.do")
	public ModelAndView deleteWishList(ModelAndView mv, int no) {
		
		int result=service.deleteWishList(no);
		if(result>0) {
			mv.addObject("msg","성공적으로 삭제되었습니다");
			mv.addObject("loc","/wishList.do");
		}
		mv.setViewName("common/msg");
		return mv;
	}

}













