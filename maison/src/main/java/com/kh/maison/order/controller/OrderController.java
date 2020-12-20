package com.kh.maison.order.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.basket.model.service.BasketServiceImpl;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.service.OrderServiceImpl;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.service.ProductServiceImpl;
import com.kh.maison.shop.vo.Product;



@Controller
public class OrderController {
	
	@Autowired
	private OrderService service=new OrderServiceImpl();
	
	@Autowired
	private ProductService pservice=new ProductServiceImpl();
	
	@Autowired
	private BasketService bservice=new BasketServiceImpl();
	
	@RequestMapping("/order/orderInsert.do")
	@ResponseBody
	public int insertOrder(@RequestParam String receiver,
							@RequestParam String orPhone,
							@RequestParam String memberId,
							@RequestParam String orZipcode,
							@RequestParam String orAddress,
							@RequestParam String orDetailAddress,
							@RequestParam String sellRequest,
							@RequestParam String deliRequest,
							@RequestParam String orderPrice,
							@RequestParam String mileage,
							@RequestParam String useMile,
							@RequestParam String stackMile,
							@RequestParam String totalPrice,
							 String[] basketNo
							) {
		
		
		
		
		Order o=new Order();
		o.setReceiver(receiver);
		o.setOrPhone(orPhone);
		o.setMemberId(memberId);
		o.setOrZipcode(orZipcode);
		o.setOrAddress(orAddress);
		o.setOrDetailAddress(orDetailAddress);
		o.setSellRequest(sellRequest);
		o.setDeliRequest(deliRequest);
		o.setOrderPrice(Integer.parseInt(orderPrice));
		o.setUseMile(Integer.parseInt(useMile));
		o.setStackMile(Integer.parseInt(stackMile));
		o.setTotalPrice(Integer.parseInt(totalPrice));
		
		System.out.println(o);
		
		
		
		
		//마일리지 계산
		int result=0;
		int memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-Integer.parseInt(useMile);
		


		
		result=service.insertOrder(o);
		Map<String,Object> map=new HashMap<String,Object>();
		
		
		
		Map<String,Object> map2=new HashMap<String, Object>();
		map2.put("memberMileage", memberMileage);
		map2.put("memberId", memberId);
		if(result>0) {
			//orderDetail insert
			for(String a: basketNo) {
				Basket b=new Basket();
				b.setBasketNo(Integer.parseInt(a));
				int result3=service.insertOrderDetail(b);
			}
			
			//재고 업데이트 productNo, productStock, amount
			for(String basketno : basketNo) {
				Basket b=new Basket();
				b.setBasketNo(Integer.parseInt(basketno));
				int result4=service.bupdateStock(b);
			}
			
			//마일리지 업데이트
			int result2=service.updateMileage(map2);
			
			

		}
		
		
		
		
		
		return result;
	}
	
	@RequestMapping("/order/buy.do")
	public ModelAndView buy(ModelAndView mv, int productNo, int amount) {
		
		Product p=pservice.selectProductOne(productNo);
		mv.addObject("product",p);
		mv.addObject("amount",amount);
		mv.setViewName("order/buy");
		return mv;
	}
	
	@RequestMapping("/order/buyInsert.do")
	@ResponseBody
	public int buy(ModelAndView mv,@RequestParam String receiver,
			@RequestParam String orPhone,
			@RequestParam String memberId,
			@RequestParam String orZipcode,
			@RequestParam String orAddress,
			@RequestParam String orDetailAddress,
			@RequestParam String sellRequest,
			@RequestParam String deliRequest,
			@RequestParam String orderPrice,
			@RequestParam String mileage,
			@RequestParam String useMile,
			@RequestParam String stackMile,
			@RequestParam String totalPrice,
			@RequestParam String amount,
			String productName, String productNo) {
		
		Order o=new Order();
		o.setReceiver(receiver);
		o.setOrPhone(orPhone);
		o.setMemberId(memberId);
		o.setOrZipcode(orZipcode);
		o.setOrAddress(orAddress);
		o.setOrDetailAddress(orDetailAddress);
		o.setSellRequest(sellRequest);
		o.setDeliRequest(deliRequest);
		o.setOrderPrice(Integer.parseInt(orderPrice));
		
		o.setUseMile(Integer.parseInt(useMile));
		o.setStackMile(Integer.parseInt(stackMile));
		o.setTotalPrice(Integer.parseInt(totalPrice));
		
		//마일리지 계산
		int result=0;
		int memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-Integer.parseInt(useMile);
		
		//order_tb insert
		result=service.insertOrder(o);
		
		Map<String,Object> map2=new HashMap<String, Object>();
		map2.put("memberMileage", memberMileage);
		map2.put("memberId", memberId);
		
		//상품재고
		
		Map<String,Object> map3=new HashMap<String, Object>();
		map3.put("amount", amount);
		map3.put("productName", productName);
		
		//바로구매 orderDetail insert
		Map<String,Object> map4=new HashMap<String, Object>();
		map4.put("amount", amount);
		map4.put("productNo", productNo);
		
		if(result>0) {
			
			int result4=service.insertBuyOrderDetail(map4);
			int result2=service.updateMileage(map2);
			int result3=service.updateStock(map3);
		}
		
		
		return result;
	}
	
	@RequestMapping("/order/orderEnd.do")
	public ModelAndView orderEnd(ModelAndView mv,HttpServletRequest request) {
		
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();
		
		List<OrderDetail> list=service.selectOrderDetail(memberId);
		
		mv.addObject("list",list);
		mv.setViewName("order/orderEnd");
		return mv;
	}
	
	
	
	
	
	
	
	
}
