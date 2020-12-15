package com.kh.maison.order.controller;



import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.basket.model.service.BasketServiceImpl;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.mileage.model.service.MileageService;
import com.kh.maison.mileage.model.vo.Mileage;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.service.OrderServiceImpl;
import com.kh.maison.order.model.vo.Order;
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
	
	@Autowired
	private MileageService mservice;
	
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
		if(useMile.equals("")) {
			o.setUseMile(0);
		}else {
			o.setUseMile(Integer.parseInt(useMile));		
		}
		o.setStackMile(Integer.parseInt(stackMile));
		if(totalPrice.equals("")) {
			o.setTotalPrice(Integer.parseInt(orderPrice));
		}else {
			o.setTotalPrice(Integer.parseInt(totalPrice));			
		}

		//마일리지 계산
		int result=0;
		int memberMileage=0;
		if(useMile.equals("")) {
			memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-0;
		}else {
			memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-Integer.parseInt(useMile);
		}
		
		
		


		
		result=service.insertOrder(o);
		Map<String,Object> map=new HashMap<String,Object>();
		
		
		
		Map<String,Object> map2=new HashMap<String, Object>();
		map2.put("memberMileage", memberMileage);
		map2.put("memberId", memberId);
		if(result>0) {
			//마일리지 처리 필요
			//마일리지 테이블에 마일리지 쌓기(가감)
			Mileage mil = new Mileage();
			mil.setMemberId(memberId);
			mil.setMile(Integer.parseInt(stackMile));
			mservice.insertBuyMileage(mil);

			//상품 구매시 사용한 적립금 
			Mileage mil2 = new Mileage();
			mil2.setMemberId(memberId);
			if(useMile.equals("")) {
				mil2.setMile(0);
			}else {
				mil2.setMile(-Integer.parseInt(useMile));
			}
			mservice.updateUseMileage(mil2);
			
			
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
			String productName) {
		
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
		if(useMile.equals("")) {
			o.setUseMile(0);
		}else {
			o.setUseMile(Integer.parseInt(useMile));		
		}
		o.setStackMile(Integer.parseInt(stackMile));
		if(totalPrice.equals("")) {
			o.setTotalPrice(Integer.parseInt(orderPrice));
		}else {
			o.setTotalPrice(Integer.parseInt(totalPrice));			
		}
		
		//마일리지 계산
		int result=0;
		int memberMileage=0;
		if(useMile.equals("")) {
			memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-0;
		}else {
			memberMileage=Integer.parseInt(mileage)+Integer.parseInt(stackMile)-Integer.parseInt(useMile);
		}
		
		
		result=service.insertOrder(o);
		
		Map<String,Object> map2=new HashMap<String, Object>();
		map2.put("memberMileage", memberMileage);
		map2.put("memberId", memberId);
		
		//마일리지 테이블에 마일리지 쌓기(가감)
		Mileage mil = new Mileage();
		mil.setMemberId(memberId);
		mil.setMile(Integer.parseInt(stackMile));
		mservice.insertBuyMileage(mil);
		
		//상품 구매시 사용한 적립금 
		Mileage mil2 = new Mileage();
		mil2.setMemberId(memberId);
		if(useMile.equals("")) {
			mil2.setMile(0);
		}else {
			mil2.setMile(-Integer.parseInt(useMile));
		}
		mservice.updateUseMileage(mil2);

		//상품재고

		
		Map<String,Object> map3=new HashMap<String, Object>();
		map3.put("amount", amount);
		map3.put("productName", productName);
		
		if(result>0) {
			int result2=service.updateMileage(map2);
			int result3=service.updateStock(map3);
		}
		
		
		return result;
	}
	
	
	
	
	
	
}
