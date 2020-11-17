package com.kh.maison.member.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Autowired
	private AES256Util aes;
//	@Autowired
//	private Logger logger;
	
	
	@RequestMapping(value="/member/login")
	public ModelAndView login(ModelAndView mv) {
		
		mv.setViewName("member/login");
		
		return mv;
	}
	
	@RequestMapping(value="/member/enroll")
	public ModelAndView enroll(ModelAndView mv) {
		mv.setViewName("member/enroll");
		return mv;
	}
	
	@RequestMapping(value="/member/enrollEnd")
	public ModelAndView enroll(ModelAndView mv, Member mem) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		
		//비밀번호 단방향 암호화
		mem.setMemberPw(encoder.encode(mem.getMemberPw()));
		//양방향 암호화
		mem.setZipcode(aes.encrypt(mem.getZipcode()));
		mem.setAddress(aes.encrypt(mem.getAddress()));
		mem.setDetailAddress(aes.encrypt(mem.getDetailAddress()));
		mem.setEmail(aes.encrypt(mem.getEmail()));
		mem.setPhone(aes.encrypt(mem.getPhone()));
		
		int result = service.insertMember(mem);
		
		//성공하면 로그인페이지로, 실패하면 회원가입 페이지로
		mv.addObject("msg",result>0?"회원가입 성공":"회원가입 실패");
		mv.addObject("loc",result>0?"/member/login":"/member/enroll");
		mv.setViewName("common/msg");
		return mv;
	}
	
	//RequestMapping(value="/member/ajax/checkMemberId")
	
	
}
