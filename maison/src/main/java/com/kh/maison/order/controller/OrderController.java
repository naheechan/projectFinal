package com.kh.maison.order.controller;


import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.basket.model.service.BasketServiceImpl;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.service.OrderServiceImpl;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.service.ProductServiceImpl;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.service.ShopCycleService;



@Controller
public class OrderController {
	
	@Autowired
	private OrderService service=new OrderServiceImpl();
	
	@Autowired
	private ProductService pservice=new ProductServiceImpl();
	
	@Autowired
	private BasketService bservice=new BasketServiceImpl();
	
	@Autowired
	private ShopCycleService cycleService;
	
	private Logger logger = LoggerFactory.getLogger(OrderController.class);
	
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
			String productName,
			String productNo) {
		
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
		
		
		result=service.insertOrder(o);
		
		Map<String,Object> map2=new HashMap<String, Object>();
		map2.put("memberMileage", memberMileage);
		map2.put("memberId", memberId);
		
		//상품재고
		
		Map<String,Object> map3=new HashMap<String, Object>();
		map3.put("amount", amount);
		map3.put("productName", productName);
		
		
		if(result>0) {
			int result2=service.updateMileage(map2);
			int result3=service.updateStock(map3);
		}
		
		
		//쇼핑시계에 상품추가하는 부분
		Map<String,String> cycleMap = new HashMap<>();
		cycleMap.put("id",memberId);
		cycleMap.put("no",productNo);
		//쇼핑시계에 이미 있는 상품인지 조회
		int resultCycle = cycleService.selectCycleExist(cycleMap);
		if(resultCycle==0) {
			//존재 안하면! 새로 insert시킴
			resultCycle = cycleService.insertCycle(cycleMap);
			logger.debug("아직 존재안해서 insert했다");
		}else {
			//이미 존재하면
			//구매내역(최근기준으로 최대 3개까지) 가져오기
			cycleMap.put("limit", "3"); //가져올 개수
			List<Map<String,String>> recentCycleList = cycleService.selectRecentCycle(cycleMap);
			
			//구매한 물건 갯수
			int onCycle = 0;
			int total = 0;
			for(int i=0; i<recentCycleList.size(); i++) {
				total+=Integer.parseInt(String.valueOf(recentCycleList.get(0).get("ODAMOUNT")));
			}
			logger.debug("total갯수 : "+total);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				//제일 최신의 구매일자
				Date newOrderDate = sdf.parse(String.valueOf(recentCycleList.get(0).get("ORDERDATE")));
				//제일 마지막의 구매일자(3개내역 중에서)
				Date oldOrderDate = sdf.parse(String.valueOf(recentCycleList.get(recentCycleList.size()-1).get("ORDERDATE")));
				
				//두 날짜의 차이(getTime()은 ms을 구하는 메소드, (1000*60*60*24)는 하루(1일)을 ms로 나타낸것)
				int diffDay = Long.valueOf(((newOrderDate.getTime() - oldOrderDate.getTime()) / (1000*60*60*24))).intValue();
				
				//물품 1개당 사용일을 구함.(이때 '올림' 했음)
				onCycle = (int)Math.ceil(diffDay*1.0/total);
				if(onCycle<1) {
					//오류막기위해 최소 1일로 설정해줌
					onCycle=1;
				}
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			cycleMap.put("onCycle", String.valueOf(onCycle));
			resultCycle = cycleService.updateOnCycle(cycleMap);
		}
		if(resultCycle<1) {
			//쇼핑시계 부분에서 에러
			
		}
		
		
		
		
		return result;
	}
	
	
	
	
	
	
}
