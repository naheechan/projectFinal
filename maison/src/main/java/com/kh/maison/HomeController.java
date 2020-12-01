package com.kh.maison;

import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.Member;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	MemberService service;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, @RequestParam Map<String,String> map) {
		

		if(map.get("authId")!=null && map.get("authKey")!=null) {
			//사용자 이메일 인증
			Member mem = service.selectMemberOne(map.get("authId"));
			if(map.get("authKey").equals(mem.getAuthKey())) {
				int result = service.updateAuthStatus(map.get("authId"));
				model.addAttribute("auth",result>0?"이메일 인증완료!":"이메일 인증실패 -관리자에게 문의하세요");
			}else {
				model.addAttribute("auth","이메일 인증실패 -관리자에게 문의하세요");
			}
		}
		
		return "index";
	}
	
}
