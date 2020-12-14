package com.kh.maison.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.maison.basket.model.service.BasketService;
import com.kh.maison.member.model.vo.Member;

@Component
public class BasketInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	BasketService service;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		//멤버 합치고 주석해제
		Member login=(Member)request.getSession().getAttribute("loginMember");
		
		
		if(login!=null) {
			int basketCount=service.selectBasketCount(login.getMemberId());
			
			request.setAttribute("basketCount", basketCount);
		}else {
			request.setAttribute("basketCount", 0);
		}
		
		super.postHandle(request, response, handler, modelAndView);
	}

	
}
