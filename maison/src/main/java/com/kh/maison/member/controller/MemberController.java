package com.kh.maison.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.Member;

@Controller
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Autowired
	private AES256Util aes;
//	@Autowired
//	private Logger logger;
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	@RequestMapping(value="/member/login")
	public ModelAndView login(ModelAndView mv) {
		
		mv.setViewName("member/login");
		
		return mv;
	}
	
	@RequestMapping(value="/member/loginEnd")
	public ModelAndView loginEnd(ModelAndView mv, @RequestParam Map map, HttpServletResponse response) {
		
		//쿠키에 아이디 저장
		if(map.get("saveId")!=null) {
			Cookie cookie = new Cookie("saveId", String.valueOf(map.get("memberId")));
			cookie.setMaxAge(60*60*24*30);
			response.addCookie(cookie);
		}else {
			Cookie cookie = new Cookie("saveId", null);
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		Member mem = service.selectMemberOne(String.valueOf(map.get("memberId")));
		logger.debug(mem==null?"null":mem.toString());
		//비밀번호 다 소문자로 바꿔서 암호화된 비번이랑 비교
		if(mem!=null && encoder.matches(String.valueOf(map.get("memberPw")).toLowerCase(), mem.getMemberPw())) {
			//이메일 인증 여부
			if("Y".equals(mem.getAuthStatus())) {
				logger.debug("로그인 성공");
				//세션처리
				mv.addObject("loginMember", mem);
				mv.setViewName("redirect:/");
			}else {
				logger.debug("이메일 인증 미완료");
				mv.addObject("msg", "이메일이 아직 인증되지 않았습니다.");
				mv.addObject("loc", "/member/login");
				mv.setViewName("common/msg");
			}
		}else {
			logger.debug("로그인 실패");
			mv.addObject("msg", "아이디 또는 비밀번호가 잘못되었습니다.");
			mv.addObject("loc", "/member/login");
			mv.setViewName("common/msg");
		}
		
		return mv;
	}
	
	
	@RequestMapping(value="/member/enroll")
	public ModelAndView enroll(ModelAndView mv) {
		mv.setViewName("member/enroll");
		return mv;
	}
	
	@RequestMapping(value="/member/enrollEnd")
	public ModelAndView enrollEnd(ModelAndView mv, Member mem) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		
		String email = mem.getEmail();
		
		//비밀번호 단방향 암호화(비밀번호를 모두 소문자로 바꿔서 암호화시킴)
		mem.setMemberPw(encoder.encode(mem.getMemberPw().toLowerCase()));
		//양방향 암호화
		mem.setZipcode(aes.encrypt(mem.getZipcode()));
		mem.setAddress(aes.encrypt(mem.getAddress()));
		mem.setDetailAddress(aes.encrypt(mem.getDetailAddress()));
		mem.setEmail(aes.encrypt(mem.getEmail()));
		mem.setPhone(aes.encrypt(mem.getPhone()));
		
		int result = service.insertMember(mem);
		
		//성공하면 안내페이지로, 실패하면 회원가입 페이지로
		if(result>0) {
			mv.addObject("email",email);
			mv.setViewName("redirect:/member/enrollAnnoun");
		}else {
			mv.addObject("msg","회원가입 실패");
			mv.addObject("loc","/member/enroll");
			mv.setViewName("common/msg");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/member/enrollAnnoun")
	public ModelAndView enrollAnnoun(ModelAndView mv) {
		
		return mv;
	}
	
	@RequestMapping(value="/member/ajax/checkMemberId")
	@ResponseBody
	public Map<String,Integer> ajaxCheckId(String checkId) throws JsonMappingException, JsonGenerationException, IOException{
		Member mem = service.selectMemberOne(checkId);
		//logger.debug(mem==null?"member는 null":mem.toString());
		
		//회원이 존재하면 0보내고, 없으면 1보냄
		Map<String,Integer> map = new HashMap<>();
		map.put("result",mem==null?1:0);
		return map;
		
	}
	
	@RequestMapping(value="/member/logout")
	public String logout(SessionStatus status) {
		if(!status.isComplete()) {
			status.setComplete();
		}
		
		return "redirect:/";
	}
	
	
}
