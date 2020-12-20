package com.kh.maison.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.maison.admin.model.service.AdminService;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	
	@RequestMapping("/admin/dashBoard.do")
	public String adminMain() {
		return "admin/dashBoard";
	}
	
	//상품재고 관리 페이지 전환 
	@RequestMapping("/admin/productStock.do")
	public String adminProductStock() {
		return "admin/productStock";
	}
	
	//상품재고관리 페이지 첫번째 div데이터 가져오기
	@RequestMapping("/admin/bringFirstDiv.do")
	@ResponseBody
	public Map<String,Object> bringFirstDiv(@RequestParam int numDate){
		//현재 총 재고, 재고변동, 입고량, 출고량 가져와야 함. 
		//가져와서 map에 담아야 함. 
		//그때 numDate를 넘겨줘가지고 계산해야함. 
		int total = service.selectFirstTotal(numDate);
		int change = service.selectFirstChange(numDate);
		int in = service.selectFirstIn(numDate);
		int out = service.selectFirstOut(numDate);
		Map<String,Object> map = new HashMap<String,Object>();
		if(total==0) {
			map.put("total", 0);
		}else {
			map.put("total", total);
		}
		if(change==0) {
			map.put("change", 0);
		}else {
			map.put("change", change);
		}
		if(in==0) {
			map.put("in", 0);
		}else {
			map.put("in", in);
		}
		if(out==0) {
			map.put("out", 0);
		}else {
			if(out<0) {
				map.put("out", out*-1);
			}else {
				map.put("out", out);
			}
		}
		
		return map;
	}
	
	//상품재고관리 페이지 두번째 div데이터 가져오기
	@RequestMapping("/admin/bringSecondDiv.do")
	@ResponseBody
	public Map<String,Object> bringSecondDiv(@RequestParam int sendNum){
		//재고변동, 입고량, 출고량을 가져와야 하는데 sendNum에서 0,1,2,3,4,5,6을 보낼거임
		//얘가 무슨의미냐면, 0이면 오늘, 1이면 어제 즉, 몇일 전의 데이터인지를 sendNum으로 전송
		int change = service.selectSecondChange(sendNum);
		int in = service.selectSecondIn(sendNum);
		System.out.println("in null?"+in);
		int out = service.selectSecondOut(sendNum);
		Map<String,Object> map = new HashMap<String,Object>();
		if(change==0) {
			map.put("change", 0);
		}else {
			map.put("change", change);
		}
		if(in==0) {
			map.put("in",0);
		}else {
			map.put("in",in);
		}
		if(out==0) {
			map.put("out", 0);
		}else {
			if(out<0) {
				map.put("out", out*-1);
			}else {
				map.put("out", out);
			}
		}
		return map;
	}
}
