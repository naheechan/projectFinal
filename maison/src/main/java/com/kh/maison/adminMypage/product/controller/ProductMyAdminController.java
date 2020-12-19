package com.kh.maison.adminMypage.product.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.service.ProductMyAdminService;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
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
	public String moveCategoryView(Model m,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		
		List<MyAdminCate> list = service.selectCateList(cPage,numPerPage);
		/* 카테고리메뉴바불러오기 */
		List<Category> largeClist = service.selectLargeCateList();
		List<Category> mediClist = service.selectMediCateList();
		//List<Category> newCate = service.selectNewOneCate();
		
		int totalData = service.selectTotalCateCount();
		int largeCate = service.largeCateCount();
		int mediumCate = service.mediCateCount();
		int todayCount = service.todayEnrollCount();
		m.addAttribute("list",list);
		m.addAttribute("largeCate",largeClist);
		m.addAttribute("mediCate",mediClist);
		System.out.println(mediClist);
		m.addAttribute("total",totalData);
		m.addAttribute("largeCount",largeCate);
		m.addAttribute("mediCount",mediumCate);
		m.addAttribute("todayCount",todayCount);
		//m.addAttribute("new",newCate);
		return "admin/mypage/product/productCategory";
	}
	
	@ResponseBody
	@RequestMapping("/selectListInMedi.do")
	public String selectListInMedi(Model m, @RequestParam(value="medi", required=false)String medi,
			@RequestParam(value="large", required=false)String large) {
		Map<String,Object> param = new HashMap<>();
		param.put("largeCate",large);
		param.put("mcName",medi);
		System.out.println(param);
		List<MyAdminCate> c = null;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			c=service.selectListInMedi(param);
			System.out.println("ajax리스트"+c);
			str=mapper.writeValueAsString(c);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/cateView.do")
	public String cateView(@RequestParam(value="value")String val) {
		List<Category> c = null;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
				try {
					c=service.cateView(val);
					str=mapper.writeValueAsString(c);
				}catch(Exception e) {
					e.printStackTrace();
				}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/cateCheck.do")
	public Category cateNameCheck(@RequestParam(value="name", required=false)String name) {
		System.out.println(name);
		Category c =service.cateNameCheck(name);
		System.out.println(c);
		return c;
	}
	
	@ResponseBody
	@RequestMapping("/updateCate.do")
	public int updateCate(@RequestParam(value="large")String largeCate,
			@RequestParam(value="mcName")String mcName, @RequestParam(value="id")String id) {
		Map<String,Object> param = new HashMap<>();
		param.put("largeCate",largeCate);
		param.put("mcName",mcName);
		param.put("mediumCate",id);
		System.out.println(param+"값");
		int result=0;
		result=service.updateCate(param);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/insertCate.do")
	public int insertCate(@RequestParam(value="large")String largeCate,
			@RequestParam(value="mcName")String mcName) {
		Map<String,Object> param = new HashMap<>();
		param.put("largeCate",largeCate);
		param.put("mcName",mcName);
		
		int result = service.insertCate(param);
		return result;
	}
	@ResponseBody
	@RequestMapping("/deleteCate.do")
	public int deleteCate(@RequestParam(value="id")String id) {
		
		int result = service.deleteCate(id);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/searchDate.do")
	public String searchDate(@RequestParam(value="one")String one,@RequestParam(value="two")String two) {
		Map<String,Object> param = new HashMap<>();
		param.put("one",one);
		param.put("two",two);
		List<MyAdminCate> list = null;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
				try {
					list=service.searchDate(param);
					str=mapper.writeValueAsString(list);
					System.out.println("date"+list);
				}catch(Exception e) {
					e.printStackTrace();
				}
		return str;
	}
}
