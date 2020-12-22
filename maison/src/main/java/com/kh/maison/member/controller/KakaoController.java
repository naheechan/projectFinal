package com.kh.maison.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.omg.DynamicAny.NameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.kh.maison.common.captcha.CaptchaUtil;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailSendService;
import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.member.recaptcha.VerifyRecaptcha;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import nl.captcha.Captcha;


@Controller
@SessionAttributes({"state", "memKakao"})
public class KakaoController {

	
	@Autowired
	private MemberService service;
	//단방향 암호화
	@Autowired
	private BCryptPasswordEncoder encoder;
	//양방향 암호화
	@Autowired
	private AES256Util aes;
	@Autowired
	private MailSendService mss;
//	@Autowired
//	private Logger logger;
	private Logger logger = LoggerFactory.getLogger(KakaoController.class);
	
	
	
	@RequestMapping(value="/member/kakako/login")
	public String naverLogin(Model m) throws UnsupportedEncodingException {
		
		String clientId = "ox1UH2H5tD1qdFjz7mFS"; //네이버 api에서 부여받은 id값
		String redirectURI = URLEncoder.encode("http://localhost:9090/maison/member/naver/checkStatus","UTF-8"); //돌아갈 주소
		//상태토큰 생성(사용자 인증용)
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);
		
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id="+clientId;
		apiURL += "&redirect_uri="+redirectURI;
		apiURL += "&state="+state;
		m.addAttribute("state", state);  //세션에 state값 저장
		
		return "redirect:"+apiURL;
	}
	

	
}
