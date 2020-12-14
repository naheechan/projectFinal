package com.kh.maison.shopCycle.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.admin.product.model.vo.Category;
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
						, String detailTab, @SessionAttribute("loginMember") Member mem) {
		
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
				cycleList = service.selectCycleList(cateMap);	
			}else {
				//대분류카테고리 선택o, 소분류카테고리 선택o 일때
				cateMap.put("detailTab",detailTab);
				cycleList = service.selectCycleList(cateMap);
			}
		}else {
			//'한번에 보기'일때 cycle전체를 가져옴
			cycleList = service.selectCycleList(cateMap);	
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
		
		
		mv.addObject("product", cycleProduct);
		mv.addObject("category",catelist);
		
		
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
