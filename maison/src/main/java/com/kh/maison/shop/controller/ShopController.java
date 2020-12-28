package com.kh.maison.shop.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.common.PageBarFactory;
import com.kh.maison.shop.model.service.ShopService;
import com.kh.maison.shop.model.vo.InquiryReply;
import com.kh.maison.shop.model.vo.PdInquiry;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.shop.model.vo.TotalInquiry;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	private ShopService service;
	
	@RequestMapping("/shopView.do")
	public String moveShopView(Model m,
		@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
		@RequestParam(value="numPerPage", required=false, defaultValue="10") int numPerPage) {
		List<Product> list = service.selectProductList(cPage,numPerPage);
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
	public ModelAndView insertRequestProduct(@RequestParam String memberId, @RequestParam String requestContent, ModelAndView mv) {
		
		System.out.println("id "+memberId+","+"content "+requestContent);
		Request rq = new Request();
		rq.setMemberId(memberId);
		rq.setRequestContent(requestContent);
		int result = service.insertRequestProduct(rq);
		System.out.println(rq);
		
		mv.addObject("msg",result>0?"요청성공":"요청실패");
		mv.addObject("loc","/shop/shopView.do");
		mv.setViewName("common/msg");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/cateSearch.do")
	public String searchCate(@RequestParam(value="category")String category) {
		System.out.println("category 카테고리서치 :"+category);
		
		List<ProductCate> list = null;
		ObjectMapper mapper = new ObjectMapper();
		String str = null;
		try {
			list = service.searchCate(category);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("shop controller category"+category);
		System.out.println("shop controller 리스트"+list);
		/* m.addAttribute("cateSearchList",list); */
		/* mv.setViewName("shop/shopView"); */
		return str;
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
	
	@ResponseBody
	@RequestMapping("/shopInquiry")
	public String selectInquiryList(Model m,
			@RequestParam(value="no")String no,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="16") int numPerPage,HttpServletResponse response) 
	throws Exception{
		
		Map<String,Object> map = new HashMap<>();
		map.put("no",no);
		List<TotalInquiry> list = null;	
		ObjectMapper mapper = new ObjectMapper();
		String str = null;
		int totalData=0;
		try {
				list = service.selectInquiryList(cPage, numPerPage,map);
				str=mapper.writeValueAsString(list);
				System.out.println("list in shopcontroller문의"+list);
				totalData = service.selectCountInquiry(map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		m.addAttribute("list",list);
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "shopInquiry"));
		return str;
	}
	
//문의하기이동	
	@RequestMapping("/user/writeInQuiry.do")
	public String moveWriteInquiry(int no, Model m) {
		Date from = new Date(no);
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String to = fm.format(from);
		Product one = service.selectPdOne(no);
		
		m.addAttribute("productOne",one);
		return "shop/inquiryWrite";
	}
	
//문의하기등록	
	@RequestMapping("/user/inquiryEnd.do")
	public ModelAndView writeInquiry(ModelAndView mv,
			@RequestParam(value="productNo") int no,
			@RequestParam(value="piTitle") String piTitle,
			@RequestParam(value="piContent") String piContent,
			@RequestParam(value="memberId") String memberId,
			@RequestParam(value="piCate") String piCate) {
		PdInquiry pi = new PdInquiry();
		pi.setPiTitle(piTitle);
		pi.setPiContent(piContent);
		pi.setMemberId(memberId);
		pi.setProductNo(no);
		pi.setPiCate(piCate);
		
		
		int result = service.writeInquiry(pi);
		System.out.println(pi);
		
		if(result>0) {
			mv.addObject("msg","문의가 등록되었습니다.");
			mv.addObject("loc","/shop/shopDetail.do?no="+no);
		}else {
			mv.addObject("msg","문의등록에 실패했습니다.");
			mv.addObject("loc","/shop/shopDetail.do?no="+no);
		}
		mv.setViewName("common/msg");
		return mv;
	}

	
	//답글등록
	@ResponseBody
	@RequestMapping("/admin/inquiryReply.do")
	public String insertReply(ModelAndView mv, 
			@RequestParam(value="pirContent") String pirContent,
			@RequestParam(value="piNo") int piNo,
			@RequestParam(value="no") int no) {
	
		InquiryReply ir = new InquiryReply();
		ir.setPiNo(piNo);
		ir.setPirContent(pirContent);
		
		int result =0;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = service.insertReply(ir);
			System.out.println(ir);
			str=mapper.writeValueAsString(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg",result>0?"댓글등록성공":"댓글등록실패");
		mv.addObject("loc","/shop/shopDetail.do?no="+no);
		mv.setViewName("common/msg");
		return str;
	}
	
	//답변여부상태업데이트
	@ResponseBody
	@RequestMapping("/updateStatus.do")
	public String updateStatus(@RequestParam int no) {
		int result = 0;
		String str = null;
		ObjectMapper mapper  = new ObjectMapper();
		try {
			result = service.updateStatus(no);
			System.out.println("컨트롤러piNo값 : "+no);
			str = mapper.writeValueAsString(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	//관리자 답글 수정
	@ResponseBody
	@RequestMapping("/admin/modiReply.do")
	public String modiReply(@RequestParam int pirNo, @RequestParam String rmContent) {
		Map<String,Object> param= new HashMap<String,Object>();
		param.put("pirNo", pirNo);
		param.put("pirContent",rmContent);
		System.out.println("param관리자댓글수정"+param);
		int result = 0;
		String str = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = service.modiReply(param);
			str=mapper.writeValueAsString(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}

	//user 문의글 수정
	@ResponseBody
	@RequestMapping("/user/modiInQuiry.do")
	public String updateInquiry(ModelAndView mv,
			@RequestParam(value="piNo") int piNo,
			@RequestParam(value="umContent") String piContent,
			@RequestParam(value="piCate") String piCate) {
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("piNo",piNo);
		m.put("piContent",piContent);
		m.put("piCate",piCate);
		int result = 0;
		String str = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = service.updateInquiry(m);
			str=mapper.writeValueAsString(result);
			if(result>0) {
				mv.addObject("msg","문의수정이 완료되었습니다.");
			}else {
				mv.addObject("msg","문의수정에 실패했습니다.");
			}
			mv.setViewName("common/msg");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/user/deleteInQuiry.do")
	public String deleteInquiry(@RequestParam(value="no") int no) {
		int result = 0;
		int repResult=0;
		String str = null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			result = service.deleteInquiry(no);
			if(result>0) {
				repResult = service.deleteRep(no);
			}
			str=mapper.writeValueAsString(result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	
}
