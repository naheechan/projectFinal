package com.kh.maison.shopCycle.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.common.PageBarFactory;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.model.service.ShopService;
import com.kh.maison.shopCycle.model.service.ShopCycleService;
import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

@Controller
@RequestMapping("/shopCycle")
public class ShopCycleController {

	@Autowired
	private ShopCycleService service;
	@Autowired
	private ShopService shopService;
	
	//@Autowired
	private Logger logger = LoggerFactory.getLogger(ShopCycleController.class);
	
	@RequestMapping("/cycleList")
	public String cycleList(Model m, @RequestParam(defaultValue="all") String tab
						, String detailTab, @SessionAttribute("loginMember") Member mem
						, @RequestParam(defaultValue="1") int cPage
						, @RequestParam(defaultValue="9") int numPerPage
						, HttpServletRequest request) {
		
		Map<String,String> cateMap = new HashMap<>();
		cateMap.put("id",mem.getMemberId());
		
		//대분류
		List<Category> catelist = shopService.selectCategory();
		List<CycleProduct> cycleList = new ArrayList<>();
		//중분류
		List<Category> medicate = new ArrayList<>();
		if(!tab.equals("all")) {
			//'한번에 보기'가 아닐때 소뷴류카테고리 리스트 가져옴
			medicate=shopService.searchMediCate(tab);
			cateMap.put("tab",tab);
			if(detailTab==null) {
				//대분류카테고리 선택o, 소분류카테고리 선택x 일때
				cycleList = service.selectCycleList(cateMap, cPage, numPerPage);	
			}else {
				//대분류카테고리 선택o, 소분류카테고리 선택o 일때
				cateMap.put("detailTab",detailTab);
				cycleList = service.selectCycleList(cateMap, cPage, numPerPage);
			}
		}else {
			//'한번에 보기'일때 cycle전체를 가져옴
			cycleList = service.selectCycleList(cateMap, cPage, numPerPage);	
		}
		
		
		//대분류 별 cycle갯수 가져오기
		List<CountCycle> countCycleList = service.selectCountCycle(mem.getMemberId());
		//list를 map에 넣기
		Map<String,Integer> countCycleMap = new HashMap<>();
		int totalData = 0;
		
		for(CountCycle c : countCycleList) {
			switch(c.getLargeCate()) {
			case "주방": countCycleMap.put("kitchen", c.getCount()); break;
			case "욕실": countCycleMap.put("bathroom", c.getCount()); break;
			case "세탁실": countCycleMap.put("laundry", c.getCount()); break;
			case "현관": countCycleMap.put("front", c.getCount()); break;
			case "창고": countCycleMap.put("warehouse", c.getCount()); break;
			}
			totalData+=c.getCount();
		}
		countCycleMap.put("total", totalData);
		
		
		m.addAttribute("category",catelist);
		m.addAttribute("medicate",medicate);
		m.addAttribute("cycleList",cycleList);
		m.addAttribute("tab",tab);
		m.addAttribute("detailTab",detailTab);
		m.addAttribute("countCycleMap",countCycleMap);
		m.addAttribute("pageBar", PageBarFactory.getPageBar(cycleList.size(), cPage, numPerPage, request.getRequestURI()));
		return "shopCycle/cycleList";
	}
	
	@RequestMapping(value="/cycleDetail")
	public ModelAndView cycleDetail(ModelAndView mv, String no, @SessionAttribute("loginMember") Member mem) {
		
		Map<String,String> cycleMap = new HashMap<>();
		cycleMap.put("id", mem.getMemberId());
		cycleMap.put("no", no);
		//해당 상품정보 가져오기
		CycleProduct cycleProduct = service.selectCycleOne(cycleMap);
		
		//대분류(카테고리 표시용)
		List<Category> catelist = shopService.selectCategory();
		
		//대분류 별 cycle갯수 가져오기
		List<CountCycle> countCycleList = service.selectCountCycle(mem.getMemberId());
		//list를 map에 넣기
		Map<String,Integer> countCycleMap = new HashMap<>();
		int totalData = 0;
		
		for(CountCycle c : countCycleList) {
			switch(c.getLargeCate()) {
			case "주방": countCycleMap.put("kitchen", c.getCount()); break;
			case "욕실": countCycleMap.put("bathroom", c.getCount()); break;
			case "세탁실": countCycleMap.put("laundry", c.getCount()); break;
			case "현관": countCycleMap.put("front", c.getCount()); break;
			case "창고": countCycleMap.put("warehouse", c.getCount()); break;
			}
			totalData+=c.getCount();
		}
		countCycleMap.put("total", totalData);
		
		
		//구매내역 최근5개만 가져오기
		cycleMap.put("limit", "5"); //가져올 개수
		List<Map<String,String>> recentCycleList = service.selectRecentCycle(cycleMap);
		
		mv.addObject("product", cycleProduct);
		mv.addObject("category",catelist);
		mv.addObject("countCycleMap",countCycleMap);
		mv.addObject("recentCycleList",recentCycleList);
		
		
		mv.setViewName("shopCycle/cycleDetail");
		
		return mv;
	}
	
	@RequestMapping(value="/editCycle")
	public ModelAndView editCycle(ModelAndView mv, @SessionAttribute("loginMember") Member mem
							, @RequestParam Map map) {
		
		mv.addObject("no",map.get("no"));
		map.put("id", mem.getMemberId());
		int result = service.updateCycle(map);
		
		if(result<1) {
			mv.addObject("loc","/shopCycle/cycleDetail");
			mv.addObject("msg","주기 수정에 실패하였습니다.");
			mv.setViewName("common/msg");
			return mv;
		}
		
//		if("on".equals(map.get("chooseCycle"))) {
//			//onCycle로 주기를 변경하는 경우
//			if(null!=map.get("startCheckbox")) {
//				//시작일도 변경하는 경우
//				
//			}else {
//				//시작일은 변경 안하는 경우
//			}
//		}else {
//			//offCycle로 주기를 변경하는 경우
//			if(null!=map.get("startCheckbox")) {
//				//시작일도 변경하는 경우
//				
//			}else {
//				//시작일은 변경 안하는 경우
//			}
//		}
		
		mv.setViewName("redirect:/shopCycle/cycleDetail");
		return mv;
	}
	
	//ajax로 alertStatus 변경
	@ResponseBody
	@RequestMapping(value="/editAlert")
	public String editAlert(String no, String check, @SessionAttribute("loginMember") Member mem) throws JsonMappingException, JsonGenerationException, IOException {
		ObjectMapper mapper= new ObjectMapper();
		
		Map<String,String> map = new HashMap<>();
		map.put("id",mem.getMemberId());
		map.put("no",no);
		map.put("check",check);

		//checkbox의 checked가 true이면 alertStatus='Y'로 업데이트
		//checkbox의 checked가 false이면 alertStatus='Y'로 업데이트
		int result = service.updateAlertStatus(map);
		
		if(result>0) logger.debug("쇼핑시계 alertStatus변경 성공. memberId="+mem.getMemberId()+", productNo="+no);
		else logger.debug("쇼핑시계 alertStatus변경 실패. memberId="+mem.getMemberId()+", productNo="+no);
		
		return mapper.writeValueAsString(result);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
