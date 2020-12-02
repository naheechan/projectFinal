package com.kh.maison.basket.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.vo.Product;

@Controller
public class BasketController {

	@Autowired
	private BasketService service;

	@Autowired
	private ProductService pservice;
	
	@RequestMapping("basket/basket.do")
	public ModelAndView basket(ModelAndView mv, HttpSession session) {

		Member m = (Member) session.getAttribute("loginMember");
		if (m != null) {
			String memberId = m.getMemberId();
			List<Map> list = service.selectBasketList(memberId);
			mv.addObject("list", list);
			mv.setViewName("basket/basket");
		} else {
			mv.addObject("msg", "로그인 후 이용가능합니다 !");
			mv.addObject("loc", "member/login");
			mv.setViewName("common/msg");

		}
		return mv;
	}

	@RequestMapping("basket/deleteBasket.do")
	public String deleteBasket(int basketNo) {

		int result = service.deleteBasket(basketNo);

		return "redirect:/basket/basket.do";
	}

	@RequestMapping("basket/upDown.do")
	@ResponseBody
	public ModelAndView upDown(@RequestParam Map param, HttpServletResponse response, ModelAndView mv,
			HttpSession session) throws JsonMappingException, JsonGenerationException, IOException {

		// 수량 변경
		int result = service.updateAmount(param);

		// 다시불러오기
		Member m = (Member) session.getAttribute("loginMember");
		String memberId = m.getMemberId();

		List<Map> list = service.selectBasketList(memberId);
		mv.addObject("list", list);
		mv.setViewName("/basket/amountChange");

		return mv;
	}

	
	  @RequestMapping("basket/orderBasket") 
	  public ModelAndView  orderBasket(ModelAndView mv,HttpServletRequest request) {
	  
			String msg = "";
			String loc = "";
			String[] basketNos = request.getParameterValues("basketNo");
			
			
			// 장바구니에 상품이 없을때
			if (basketNos == null) {
				msg = "장바구니에 담긴 상품이 없습니다 !";
				loc = "/basket/basket.do";
				mv.addObject("msg", msg);
				mv.addObject("loc", loc);
				mv.setViewName("common/msg");
				return mv;

			} else {

				// 장바구니에 상품이 있음
				List<Basket> list = new ArrayList<Basket>();
				Map<String, Basket> mapf = new HashMap<String, Basket>();
				boolean soldout=false;

				// 상품 수량이 있음
				// 1.일단 장바구니를 다 받아옴
				for (String basketNo : basketNos) {
					
					//mapf.put(basketNo, service.selectBasketOne(Integer.parseInt(basketNo)));
					// list.add(service.selectBasketOne(Integer.parseInt(basketNo)));
					
					// 2. basketNos에 담긴 장바구니의 상품을 product테이블에서 불러와서 stock과 amount를 비교
					Basket b=service.selectBasketOne(Integer.parseInt(basketNo));
					Product p=pservice.selectProductOne(b.getProductno());
					
					//상품 수량이 부족함
					if(b.getAmount()>p.getProductStock()) {
						soldout=true;
						
					}else {
						//상품 수량이 있으면 list에 추가
						list.add(b);
					}
				}
				
				mv.addObject("list",list);
				
				if(soldout) {
					msg = "수량이 부족한 상품은 결제화면에서 제외됩니다 !";
					loc = "/basket/payment";
					mv.addObject("msg", msg);
					mv.addObject("loc", loc);
					mv.setViewName("common/msg");
					
				}else {
					mv.addObject("loc","/basket/payment");
					mv.setViewName("common/msg");
				}
				
				
			}

			return mv;
		}
	 

}
