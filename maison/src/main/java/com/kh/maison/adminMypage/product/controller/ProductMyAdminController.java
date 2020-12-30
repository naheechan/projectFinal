package com.kh.maison.adminMypage.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.ProductCate;
import com.kh.maison.adminMypage.product.model.service.ProductMyAdminService;
import com.kh.maison.adminMypage.product.model.vo.MyAdminCate;
import com.kh.maison.adminMypage.product.model.vo.MyAdminEnroll;
import com.kh.maison.adminMypage.product.model.vo.MyAdminInquiry;
import com.kh.maison.common.PageBarFactory;

@Controller
@RequestMapping("/admin/mypage/product")
public class ProductMyAdminController {

	@Autowired
	private ProductMyAdminService service;
//상품등록,수정	
	@RequestMapping("/enrollView.do")
	public String moveEnrollView(Model m,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		
		List<ProductCate> list = service.selectTotalList(cPage,numPerPage);
		List<MyAdminEnroll> popular = service.selectPopularList();
		
		int totalData = service.selectTotalCount();
		int showProduct = service.selectShowCount();
		int stockData = service.selectStockCount();
		int todayData = service.selectTodayCount();
		
		m.addAttribute("showCount",showProduct);
		m.addAttribute("stockCount",stockData);
		m.addAttribute("todayCount",todayData);
		m.addAttribute("totalCount",totalData);
		m.addAttribute("product",list);
		m.addAttribute("popular",popular);
//		System.out.println("인기리스트"+popular);
//		System.out.println("상품카테 리스트"+list);
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "enrollView.do"));
		
		return "admin/mypage/product/productEnrollModi";
	}
	
	@RequestMapping("/inquiryView.do")
	public String moveInquiryView(Model m,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		
		List<MyAdminInquiry> IQlist = service.selectInquiryList(cPage,numPerPage);
		List<MyAdminInquiry> Replist = service.selectReplyList(cPage,numPerPage);
		int totalData1 = service.selectInquiryCount();
		int totalData2 = service.selectReplyCount();
		int noRepData = service.selectnoRepCount();
		int yesRepData = service.selectYRepCount();
		int delRepData=service.selectDelRepCount();
		int todayData = service.selectTodayIQCount();
		
		m.addAttribute("totalCount",totalData1);
		m.addAttribute("totalCount2",totalData2);
		m.addAttribute("noRepData",noRepData);
		m.addAttribute("yesRepData",yesRepData);
		m.addAttribute("delRepData",delRepData);
		m.addAttribute("todayCount",todayData);
		m.addAttribute("list",IQlist);//문의리스트
		m.addAttribute("RepList",Replist);//답글리스트
//		System.out.println("문의"+IQlist);
//		System.out.println("답글"+Replist);
		
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalData1, cPage, numPerPage, "inquiryView.do"));
		m.addAttribute("pageBar2",PageBarFactory.getPageBar(totalData2, cPage, numPerPage, "inquiryView.do"));
		return "admin/mypage/product/productInquiry";
	};
	
	
//	//검색기능
//	@RequestMapping("inquiryView.do")
//	public ModelAndView list(
//			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
//			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage,
//			@RequestParam(defaultValue="name", required=false)String searchType,
//			@RequestParam(defaultValue="",required=false)String searchKeyword,
//			@RequestParam(defaultValue="상품문의",required=false)String selectKeyword
//			)throws Exception{
//		List<MyAdminInquiry> list = service.listAll(searchType,searchKeyword,selectKeyword,cPage, numPerPage);
//		int count = service.countArticle(searchType,searchKeyword,selectKeyword);
//		ModelAndView mv = new ModelAndView();
//		
//		Map<String,Object> map = new HashMap<>();
//		map.put("list",list);//list
//		map.put("count",count);//레코드개수
//		map.put("searchType",searchType);//검색옵션
//		map.put("keyword",searchKeyword);//검색키워드
//		map.put("select",selectKeyword);
//		map.put("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage,"inquiryView.do"));
//		System.out.println(map+"map");
//		mv.addObject("map",map);
//		mv.setViewName("admin/mypage/product/productInquiry");
//		
//		return mv;
//				
//	}
	
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
		
		int pdData=service.selectPdCateCount();
		m.addAttribute("list",list);
		m.addAttribute("largeCate",largeClist);
		m.addAttribute("mediCate",mediClist);
		
		m.addAttribute("total",totalData);
		m.addAttribute("largeCount",largeCate);
		m.addAttribute("mediCount",mediumCate);
		m.addAttribute("todayCount",todayCount);
		m.addAttribute("pageBar",PageBarFactory.getPageBar(pdData, cPage, numPerPage, "categoryView.do"));
		//m.addAttribute("new",newCate);
		return "admin/mypage/product/productCategory";
	}
	//카테고리 분류에서 카테고리 검색
	@ResponseBody
	@RequestMapping("/selectListInMedi.do")
	public String selectListInMedi(Model m, @RequestParam(value="medi", required=false)String medi,
			@RequestParam(value="large", required=false)String large) {
		Map<String,Object> param = new HashMap<>();
		param.put("largeCate",large);
		param.put("mcName",medi);
		
		List<MyAdminCate> c = null;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			c=service.selectListInMedi(param);
//			System.out.println("list in medi.do :ajax리스트"+c);
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
//		System.out.println(name);
		Category c =service.cateNameCheck(name);
//		System.out.println(c);
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
//		System.out.println(param+"값");
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
	public String searchDate(@RequestParam(value="one")String one,@RequestParam(value="two")String two,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7") int numPerPage) {
		Map<String,Object> param = new HashMap<>();
		param.put("one",one);
		param.put("two",two);
		List<MyAdminCate> list = null;
		String str=null;
		ObjectMapper mapper = new ObjectMapper();
				try {
					list=service.searchDate(param,cPage,numPerPage);
					str=mapper.writeValueAsString(list);
//					System.out.println("date"+list);
				}catch(Exception e) {
					e.printStackTrace();
				}
		return str;
	}
	
//문의하기
	@ResponseBody
	@RequestMapping("/noreply.do")
	public String noreply(ModelAndView mv,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7") int numPerPage){
		List<MyAdminInquiry> list = null;
		String str=null;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list=service.noreply(cPage,numPerPage);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/yesreply.do")
	public String yesreply(ModelAndView mv,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7") int numPerPage){
		List<MyAdminInquiry> list = null;
		String str=null;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list=service.yesreply(cPage, numPerPage);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/delreply.do")
	public String delreply(ModelAndView mv,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7") int numPerPage){
		List<MyAdminInquiry> list = null;
		String str=null;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list=service.delreply(cPage,numPerPage);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	};
	
	@ResponseBody
	@RequestMapping("/allList.do")
	public String allList() {
		List<MyAdminInquiry> list = null;
		String str=null;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.allList();
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/todayEnroll.do")
	public String todayEnroll(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="7") int numPerPage) {
		List<MyAdminInquiry> list = null;
		String str=null;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.todayEnroll(cPage,numPerPage);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}

	/* 문의 */
	@ResponseBody
	@RequestMapping("/search.do")
	public String list(@RequestParam(defaultValue="name")String searchType,
			@RequestParam(defaultValue="", required=false)String selectCate,
			@RequestParam(defaultValue="",required=false)String searchKeyword,
			@RequestParam(defaultValue="",required=false)String datepicker,
			@RequestParam(defaultValue="",required=false)String datepicker2,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminInquiry> list =null;
		int count=0;
		ObjectMapper mapper= new ObjectMapper();
		String str=null;
		try{
			list = service.selectsearch(searchType,selectCate,searchKeyword,datepicker,datepicker2,cPage,numPerPage);
			count = service.searchCountInq(searchType,selectCate,searchKeyword,datepicker,datepicker2);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("count",count);
		map.put("searchType",searchType);
		map.put("selectCate",selectCate);
		map.put("keyword",searchKeyword);
		mv.addObject("map",map);
		mv.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage, "search"));
//		System.out.println("컨트롤러search리스트"+list);
//		System.out.println(map);
//		mv.setViewName("admin/mypage/product/productInquiry");
		return str;
	}
	//답글있을시에만 삭제
	@RequestMapping("/deleteInq.do")
	public ModelAndView deleteInq(@RequestParam(value="no")int no,ModelAndView mv) {
		int repResult=0;
		int result=service.deleteInq(no);
		if(result>0) {
			repResult=service.deleteRep(no);
		}
		mv.addObject("msg",result>0?"삭제완료":"삭제실패");
		mv.addObject("loc","/admin/mypage/product/inquiryView.do");
		mv.setViewName("common/msg");
		return mv;
	}
	
//상품등록관리
//	int totalData = service.selectTotalCount();
//	int showProduct = service.selectShowCount();
//	int stockData = service.selectStockCount();
//	int todayData = service.selectTodayCount();
//	
//	m.addAttribute("showCount",showProduct);
//	m.addAttribute("stockCount",stockData);
//	m.addAttribute("todayCount",todayData);
//	m.addAttribute("totalCount",totalData);
	
	@ResponseBody
	@RequestMapping("/allPdList.do")
	public String allPdList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		String str=null;
		int count=0;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.allPdList(cPage,numPerPage);
			count = service.enrollAllCount();
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/todayPdEnroll.do")
	public String todayPdEnroll(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		String str=null;
		int count=0;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.todayPdEnroll(cPage,numPerPage);
			count = service.enrolltodayCount();
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/pdStatus.do")
	public String pdStatus(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		String str=null;
		int count=0;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.pdStatus(cPage,numPerPage);
			count = service.selectShowCount();
			str=mapper.writeValueAsString(list);
//			System.out.println("값!"+list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	@ResponseBody
	@RequestMapping("/pdStock.do")
	public String pdStock(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		String str=null;
		int count=0;
		ObjectMapper mapper=new ObjectMapper();
		try {
			list = service.pdStock(cPage,numPerPage);
			count = service.selectStockCount();
			str=mapper.writeValueAsString(list);
//			System.out.println("값!"+list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
	@ResponseBody
	@RequestMapping("/Enrollsearch.do")
	public String Enrollsearch(@RequestParam(defaultValue="productName")String searchType,
			@RequestParam(defaultValue="",required=false)String searchKeyword,
			@RequestParam(defaultValue="",required=false)String datepicker,
			@RequestParam(defaultValue="",required=false)String datepicker2,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list =null;
		int count=0;
		ObjectMapper mapper= new ObjectMapper();
		String str=null;
		try{
			list = service.Enrollsearch(searchType,searchKeyword,datepicker,datepicker2,cPage,numPerPage);
			count = service.EnrollsearchCount(searchType,searchKeyword,datepicker,datepicker2);
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		ModelAndView mv = new ModelAndView();
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("count",count);
		map.put("searchType",searchType);
		map.put("keyword",searchKeyword);
		mv.addObject("map",map);
		mv.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerPage, "search"));
		
		return str;
	}
	
	@ResponseBody
	@RequestMapping("deleteReply.do")
	public int deleteReply(@RequestParam(value="no")int no) {
		int result = service.deleteRep(no);
		if(result>0) {
			int update=service.updateRep(no);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/searchTop3.do")
	public String searchTop(@RequestParam(defaultValue="popular")String searchType,
			@RequestParam(value="val")String val,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		int count =0;
		ObjectMapper mapper = new ObjectMapper();
		String str=null;
		try {
			list=service.searchTop(searchType,val,cPage,numPerPage);
			/* count = service.searchTopCount(searchType,val); */
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		Map<String,Object> map = new HashMap<>();
		
		return str;
	}
		
	@ResponseBody
	@RequestMapping("/searchTopAll.do")
	public String searchTopAll(
			@RequestParam(value="name")String name,
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage", required=false, defaultValue="5") int numPerPage) {
		List<MyAdminEnroll> list = null;
		int count =0;
		ObjectMapper mapper = new ObjectMapper();
		String str=null;
		try {
			list=service.searchTopAll(name,cPage,numPerPage);
			/* count = service.searchTopCount(searchType,val); */
			str=mapper.writeValueAsString(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return str;
	}
}
