package com.kh.maison.order.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.mileage.model.service.MileageService;
import com.kh.maison.mileage.model.vo.Mileage;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.service.OrderServiceImpl;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
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

		if(useMile=="") {
			o.setUseMile(0);
			
		}else {
			o.setUseMile(Integer.parseInt(useMile));
		}

		o.setStackMile(Integer.parseInt(stackMile));

		o.setTotalPrice(Integer.parseInt(totalPrice));
		
		System.out.println(o);
	

		//마일리지 계산
		int result=0;

		int memberMileage=Integer.parseInt(mileage)+o.getStackMile()-o.getUseMile();

		

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
			

			//배송지 insert
			int result5=service.insertShippingDestination(o);

			
			//쇼핑시계에 상품추가하는 부분
			Map<String,String> cycleMap = new HashMap<>();
			cycleMap.put("id",memberId);
			
			for(String basketno : basketNo) {
				cycleMap.put("basketno",basketno);
				//basket번호를 이용해서 productNo를 가져옴
				cycleMap.put("no",String.valueOf(cycleService.selectProductNo(cycleMap)));
				
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
			}
			
			
			
			


		}

		return result;
	}

	//바로구매
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

		if(useMile=="") {
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

		
		//order_tb insert
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
		

		//바로구매 orderDetail insert
		Map<String,Object> map4=new HashMap<String, Object>();
		map4.put("amount", amount);
		map4.put("productNo", productNo);

		
		if(result>0) {
			int result5=service.insertShippingDestination(o);
			int result4=service.insertBuyOrderDetail(map4);
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
	
	@RequestMapping("/order/shippingDestination.do")
	public ModelAndView shippingDestination(ModelAndView mv,HttpServletRequest request) {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		String memberId=loginMember.getMemberId();
		
		List<Order> list=service.selectShippingDestination(memberId);
		
	
		
		mv.addObject("list",list);
		mv.setViewName("order/shippingDestination");
		return mv;
	}
	
	
	
	@RequestMapping("/order/deleteShippingDestination.do")
	public ModelAndView insertShippingEnrollEnd(ModelAndView mv,String no) {
		System.out.println(no);
		
		return mv;
	}
	
	
	
	
	
}
