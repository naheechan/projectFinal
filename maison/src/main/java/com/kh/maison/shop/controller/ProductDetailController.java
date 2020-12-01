package com.kh.maison.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.vo.WishList;

@Controller
public class ProductDetailController {
	
	@Autowired
	private ProductService service;
	
//	@RequestMapping("/shop/shopList.do")
//	public ModelAndView selectProductList(ModelAndView mv) {
//		
//		mv.addObject("list",service.selectProductList());
//		mv.setViewName("shop/shopList");
//		return mv;
//	}
	
	@RequestMapping("/shop/shopDetail.do")
	public ModelAndView selectProductOne(ModelAndView mv, int no) {
		
		mv.addObject("product",service.selectProduct(no));
		mv.setViewName("shop/shopDetail");
		
		return mv;
	}
	
	@RequestMapping("/shop/wishList.do")
	public ModelAndView insertWishList(ModelAndView mv,@RequestParam String id, @RequestParam int no) {
		
		

		WishList w=new WishList();
		w.setMemberId(id);
		w.setProductNo(no);
		int result=service.insertWishList(w);
		
		if(result>0) {
			mv.addObject("msg","위시리스트에 추가되었습니다.");
			mv.addObject("loc","/shop/shopDetail.do?no="+no);
			
		}else {
			mv.addObject("msg","이미 추가된 상품입니다.");
			mv.addObject("loc","/shop/shopDetail.do?no="+no);
		}
		
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/wishList.do")
	public ModelAndView wishList(ModelAndView mv, String id) {
		
		mv.addObject("list",service.selectWishList(id));
		mv.setViewName("shop/wishList");
		
		return mv;
	}
	
	@RequestMapping("/deleteWishList.do")
	public ModelAndView deleteWishList(ModelAndView mv, int no, String id) {
		System.out.println("뭐가넘어오니: "+no+" "+id);
		WishList w=new WishList();
		w.setMemberId(id);
		w.setProductNo(no);
		int result=service.deleteWishList(w);
		if(result>0) {
			mv.addObject("msg","성공적으로 삭제되었습니다");
			mv.addObject("loc","/wishList.do?id="+id);
		}
		mv.setViewName("common/msg");
		return mv;
	}

}













