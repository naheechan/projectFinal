package com.kh.maison.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("loginMember")==null) {
			request.setAttribute("loc", "/member/login");
			request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}

	
	
}
