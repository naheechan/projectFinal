package com.kh.maison.adminMypage.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.service.ProductMyAdminService;
import com.kh.spring.common.PageBarFactory;

@Controller
@RequestMapping("/admin/mypage/product")
public class ProductMyAdminController {

	@Autowired
	private ProductMyAdminService service;
	
	@RequestMapping("/enrollView.do")
	public String moveEnrollView(Model m,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		
		List<ProductCate> list = service.selectTotalList(cPage,numPerPage);
		
		int totalData = service.selectTotalCount();
		int showProduct = service.selectShowCount();
		int stockData = service.selectStockCount();
		int todayData = service.selectTodayCount();
		
		m.addAttribute("showCount",showProduct);
		m.addAttribute("stockCount",stockData);
		m.addAttribute("todayCount",todayData);
		m.addAttribute("totalCount",totalData);
		m.addAttribute("product",list);
		System.out.println("상품카테 리스트"+list);
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "enrollView.do"));
		
		return "admin/mypage/product/productEnrollModi";
	}
	
	@RequestMapping("/inquiryView.do")
	public String moveInquiryView(Model m) {
		
		return "admin/mypage/product/productInquiry";
	}
	
	@RequestMapping("/categoryView.do")
	public String moveCategoryView(Model m) {
		
		return "admin/mypage/product/productCategory";
	}
	
//	@RequestMapping("/search.do")
//	public String searchProduct(SearchCriteria cri,Model m) {
//
//	}
	
}
