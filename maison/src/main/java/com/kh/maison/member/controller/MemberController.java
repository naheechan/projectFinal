package com.kh.maison.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailSendService;
import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember", "state", "res", "memNaver"})
public class MemberController {

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
		
		if(mem.getMemberPw()!=null) {
			//비밀번호 단방향 암호화(비밀번호를 모두 소문자로 바꿔서 암호화시킴)
			mem.setMemberPw(encoder.encode(mem.getMemberPw().toLowerCase()));
		}
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
			String authKey = mss.sendAuthMail(email, mem.getMemberId());
			Map<String,String> map = new HashMap<>();
			map.put("id",mem.getMemberId());
			map.put("key",authKey);
			//db에 인증키 넣어주기
			result = service.updateAuthKey(map);
			if(result>0) {
				mv.setViewName("redirect:/member/enrollAnnoun");
			}else {
				mv.addObject("msg","인증 이메일 발송 실패 - 관리자에게 문의하세요");
				mv.addObject("loc","/");
				mv.setViewName("common/msg");
			}
		}else {
			mv.addObject("msg","회원가입 실패");
			mv.addObject("loc","/member/enroll");
			mv.setViewName("common/msg");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/member/enrollAnnoun")
	public ModelAndView enrollAnnoun(ModelAndView mv, @RequestParam Map map) {
		
		
		
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
	
	
	@RequestMapping(value="/member/naver/login")
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
	
	@RequestMapping(value="/member/naver/checkStatus")
	public String naverCheckStatus(@SessionAttribute("state") String state, @RequestParam Map map, Model m) throws UnsupportedEncodingException {
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
		logger.debug("체크 스테이터스!");
		//세션의 state와 콜백으로 받은 state값이 일치하는지 확인
		if(state != null && state.equals(String.valueOf(map.get("state")))) {
			//일치함.
			//인증코드(code)를 이용해서 접근토큰 발급받을거임
			String clientId = "ox1UH2H5tD1qdFjz7mFS";
			String clientSecret = "BSJvDH8Kk8";
			String code = String.valueOf(map.get("code"));
			String redirectURI = URLEncoder.encode("http://localhost:9090/maison/member/naver/loginEnd", "UTF-8");
			apiURL += "&client_id="+clientId;
			apiURL += "&client_secret="+clientSecret;
			//apiURL += "&redirect_uri="+redirectURI;
			apiURL += "&code="+code;
			apiURL += "&state="+state;
			
			logger.debug("apiURL="+apiURL);
			
			try {
				URL url = new URL(apiURL); //apiURL를 URL객체로 만듬
				HttpURLConnection con = (HttpURLConnection)url.openConnection(); //해당 주소로 연결
				con.setRequestMethod("GET");
				int responseCode = con.getResponseCode(); //연결이 어떤 상태인지 확인(200은 정상연결)
				BufferedReader br;
				logger.debug("responseCode : "+responseCode);
				if(responseCode==200) {
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				}else {
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}
				String inputLine;
				StringBuffer res = new StringBuffer(); //성능향상을 위해서 String대신 StringBuffer를 사용
				//br을 한줄씩 읽어옴
				while((inputLine=br.readLine())!=null) {
					res.append(inputLine);
				}
				br.close();
				if(responseCode==200) {
					m.addAttribute("res",res.toString());
				}else {
					m.addAttribute("res", "");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}else {
			m.addAttribute("msg", "잘못된 접근입니다.");
			m.addAttribute("loc", "/member/login");
			return "common/msg";
		}
	
		return "redirect:/member/naver/loginEnd";
	}
	
	
	@RequestMapping(value="/member/naver/loginEnd")
	public String naverLoginEnd(@SessionAttribute("res") String res, SessionStatus status, Model m) throws ParseException {
		
		logger.debug("loginEnd 도착");
		
		logger.debug(res);
		String loc = "";
		
		if(res!=null || !"".equals(res)) {
		
			//토큰 문자열 빼오기
			JSONParser parser = new JSONParser();
			JSONObject jsonToken = (JSONObject)parser.parse(res);
			String accessToken = jsonToken.get("access_token").toString();
			String refreshToken = jsonToken.get("refresh_token").toString();
			
			//세션 없애서 res세션 없애기
//			if(!status.isComplete()) {
//				status.setComplete();
//			}
			
			//프로필조회api
			String header = "Bearer "+accessToken;
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			Map<String,String> requestHeaders = new HashMap<>();
			requestHeaders.put("Authorization", header);
			String responseBody = get(apiURL, requestHeaders);
			
			
			//프로필 정보 확인
			JSONObject jsonData = (JSONObject)((JSONObject)parser.parse(responseBody)).get("response");
			String id = jsonData.get("id").toString();

			//String age = jsonData.get("age").toString();

			String gender = jsonData.get("gender").toString();
			String email = jsonData.get("email").toString();
			String name = jsonData.get("name").toString();

			//String birthday = jsonData.get("birthday").toString();


			//회원이 DB에 있는지 확인
			Member mem = service.selectMemberOne(id);
			if(mem!=null) {
				//로그인
				
				//이메일 인증 여부
				if("Y".equals(mem.getAuthStatus())) {
					logger.debug("로그인 성공");
					//세션처리
					m.addAttribute("loginMember", mem);
					loc = "redirect:/";
				}else {
					logger.debug("이메일 인증 미완료");
					m.addAttribute("msg", "이메일이 아직 인증되지 않았습니다.");
					m.addAttribute("loc", "/member/login");
					loc = "common/msg";
				}
	
				
			}else {
				//회원가입
				logger.debug("네이버 회원가입으로 가자");
				Member memNaver = new Member();
				memNaver.setMemberId(id);
				memNaver.setGender(gender);
				memNaver.setEmail(email);
				memNaver.setMemberName(name);
				//memNaver을 세션에 넣음
				m.addAttribute("memNaver", memNaver);
				return "redirect:/member/naver/enroll";
			}
			
		}else {
			m.addAttribute("msg", "네이버 로그인중 오류발생");
			m.addAttribute("loc", "/member/login");
			return "common/msg";
		}

		return loc;
	}
	
	
	
	private static String get(String apiUrl, Map<String,String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for(Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}
			int responseCode = con.getResponseCode();
			if(responseCode == HttpURLConnection.HTTP_OK) {
				//정상 호출
				return readBody(con.getInputStream());
			}else {
				//에러 발생
				return readBody(con.getErrorStream());
			}
		}catch(IOException e) {
			throw new RuntimeException("프로필 조회API 요청과 응답 실패");
		}finally {
			con.disconnect();
		}
	}
	
	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection)url.openConnection();
		}catch(MalformedURLException e) {
			throw new RuntimeException("프로필 조회API URL연결이 잘못되었습니다. : "+apiUrl);
		}catch(IOException e) {
			throw new RuntimeException("프로필 조회API 연결에 실패했습니다. : "+apiUrl);
		}
	}
	
	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);
		
		try(BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();
			String line;
			while((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			return responseBody.toString();
			
		}catch(IOException e) {
			throw new RuntimeException("프로필 조회 API를  읽는데 실패했습니다.");
		}
	}
	
	
	@RequestMapping("/member/naver/enroll")
	public ModelAndView enrollNaver(@SessionAttribute("memNaver") Member memNaver, SessionStatus status, ModelAndView mv) {
		
		logger.debug("네이버 회원가입 도착");
		mv.addObject("memNaver",memNaver);
		mv.setViewName("member/enrollNaver");
		
		if(!status.isComplete()) {
			//세션에 임시로 담긴 memNaver 삭제
			status.setComplete();
		}
		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
