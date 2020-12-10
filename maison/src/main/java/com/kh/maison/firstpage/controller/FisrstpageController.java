package com.kh.maison.firstpage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.firstpage.model.service.FirstpageService;
import com.kh.maison.shop.vo.Product;

@Controller
public class FisrstpageController {

	@Autowired
	private FirstpageService service;
	
	@RequestMapping("/firstpage/wishList.do")
	@ResponseBody
	public List<Product> selectBestWith(){	
		List<Product> list = service.selectBestWish();
		return list;	
	}
	
	@RequestMapping("/firstpage/about.do")
	public ModelAndView about(ModelAndView mv) {
		mv.setViewName("common/about");
		return mv;
	}

}
