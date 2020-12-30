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
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.common.captcha.CaptchaUtil;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailSendService;
import com.kh.maison.member.model.service.MemberService;
import com.kh.maison.member.model.vo.KakaoProfile;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.member.model.vo.OAuthToken;
import com.kh.maison.member.recaptcha.VerifyRecaptcha;
import com.kh.maison.mileage.model.service.MileageService;
import com.kh.maison.mileage.model.vo.Mileage;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.with.model.service.WithBoardService;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.spring.common.PageBarFactory;

import nl.captcha.Captcha;


@Controller
@SessionAttributes({"loginMember", "state", "res", "memNaver","memKakao"})
public class MemberController {

	//마일리지 관련
	@Autowired
	private MileageService milService;
	//함께해요 관련
	@Autowired
	private WithBoardService withService;
	//주문관련
	@Autowired
	private OrderService orderService;
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
	
	@Autowired
	private OrderService oservice;
	
	
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
		
		//비밀번호 다 소문자로 바꿔서 암호화된 비번이랑 비교 + 탈퇴여부도 확인
		if(mem!=null && encoder.matches(String.valueOf(map.get("memberPw")).toLowerCase(), mem.getMemberPw()) && "Y".equals(mem.getMemberStatus())) {
			//이메일 인증 여부
			if("Y".equals(mem.getAuthStatus())) {
				logger.debug("로그인 성공");
				//세션처리
				mv.addObject("loginMember", mem);
				mv.setViewName("redirect:/");
			}else {
				logger.debug("이메일 인증 미완료");
				mv.addObject("warn", "1");
				mv.addObject("msg", "이메일이 아직 인증되지 않았습니다.");
				mv.addObject("extraMsg", "회원가입 시 작성한 이메일을 통해 인증을 해주세요.");
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
			//회원가입하면 디폴트값으로 설정된 만큼 적립금 줌
			milService.insertWelcomeMileage(mem.getMemberId());
			milService.updateMemberMileage(mem.getMemberId());
			
			mv.addObject("email",email);
			String authKey = mss.sendAuthMail(email, mem.getMemberId(), mem.getMemberName());
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
		String redirectURI = URLEncoder.encode("http://rclass.iptime.org:9999/20AM_MAISON_final/member/naver/checkStatus","UTF-8"); //돌아갈 주소
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
	public String naverCheckStatus(@SessionAttribute("state") String state, @RequestParam Map map, Model m, SessionStatus status) throws UnsupportedEncodingException {
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
		logger.debug("체크 스테이터스!");
		//세션의 state와 콜백으로 받은 state값이 일치하는지 확인
		if(state != null && state.equals(String.valueOf(map.get("state")))) {
			//일치함.
			//인증코드(code)를 이용해서 접근토큰 발급받을거임
			String clientId = "ox1UH2H5tD1qdFjz7mFS";
			String clientSecret = "BSJvDH8Kk8";
			String code = String.valueOf(map.get("code"));
			//String redirectURI = URLEncoder.encode("http://rclass.iptime.org:9999/20AM_MAISON_final/member/naver/loginEnd", "UTF-8");
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
				//세션 삭제(state세션 삭제용)
				if(!status.isComplete()) {
					status.setComplete();
				}
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
	
		return "member/naverLoginHidden";
	}
	
	
	@RequestMapping(value="/member/naver/loginEnd")
//	public String naverLoginEnd(@SessionAttribute("res") String res, SessionStatus status, Model m) throws ParseException {
	public String naverLoginEnd(HttpServletRequest request, SessionStatus status, Model m) throws ParseException {
		
		logger.debug("loginEnd 도착");

		String res = request.getParameter("res");
		
		logger.debug("res : "+res);
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

			String email = jsonData.get("email").toString();
			String name = jsonData.get("name").toString();

			//회원이 DB에 있는지 확인
			Member mem = service.selectMemberOne(id);
			if(mem!=null) {
				//로그인
				
				//회원탈퇴 여부
				if(!"Y".equals(mem.getMemberStatus())) {
					logger.debug("탈퇴회원 로그인 시도");
					m.addAttribute("msg", "탈퇴한 회원입니다.홈페이지 자체 회원가입을 해주세요.");
					m.addAttribute("loc", "/member/login");
					loc = "common/msg";
					
				 //이메일 인증 여부
				}else if("Y".equals(mem.getAuthStatus())) {
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
	
	//마이페이지 화면전환용
	@RequestMapping("/member/mypage.do")
	public ModelAndView mypage(HttpSession session,ModelAndView mv) {
		
		Member m=(Member)session.getAttribute("loginMember");
		if(m==null) {
			mv.addObject("msg","로그인이 필요합니다 !");
			mv.addObject("loc","/member/login");
			mv.setViewName("common/msg");
		}else {
			
			Map param=new HashMap<String,String>();
			param.put("memberId", m.getMemberId());
			List<Order> list=oservice.selectMyOrderList(param,1,10);

			mv.addObject("list",list);
				
			mv.setViewName("member/mypage");
		}
		return mv;
	}
	
	//회원정보수정 화면전환용 (memberPw가 null이 아닌 경우)
	@RequestMapping("/member/update.do")
	public ModelAndView memberUpdate(ModelAndView mv) {
		mv.setViewName("member/update");
		return mv;
	}
	
	@RequestMapping("/member/updateCheck.do")
	public ModelAndView memberUpdateCheck(ModelAndView mv, Member m) {
		//그냥 m은 비밀번호 입력 화면에서 불러온 아이디랑 비밀번호 
		// mem은 m에서 가져온 아이디를 where절에 넣어서 불러온 member 데이터

		Member mem = service.selectMemberOne(m.getMemberId());

		if(mem!=null && encoder.matches(m.getMemberPw(), mem.getMemberPw())) {
			mv.addObject("msg", "비밀번호가 인증되었습니다.");
			mv.addObject("loc", "/member/updateEnd.do");

		}else {
			mv.addObject("msg", "비밀번호 인증 실패! 비밀번호를 다시 입력해주세요.");
			mv.addObject("loc", "/member/update.do");
		}
			mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/member/updateEnd.do")
	public ModelAndView memberUpdateEnd(ModelAndView mv) {
		mv.setViewName("member/updateEnd");
		return mv;
	}
	
	
	@RequestMapping("/member/findId")
	public ModelAndView findId(ModelAndView mv) {
		
		
		mv.setViewName("member/findId");
		return mv;
	}
	
	@RequestMapping("/member/findPw")
	public ModelAndView findPw(ModelAndView mv) {
		
		mv.setViewName("member/findPw");
		return mv;
	}
	
	@RequestMapping("/member/findIdSMTP")
	public ModelAndView findIdSMTP(ModelAndView mv,Date birth,String name,Member mem) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		mem.setBirth(birth);
		mem.setMemberName(name);
		String memberId="";
		String email="";
		
		List<Member> result=service.findId(mem);
		
		if(!result.isEmpty()) {
			memberId=result.get(0).getMemberId().toString();
			email=aes.decrypt((result.get(0).getEmail().toString()));
		}
		System.out.println(email);
		
		if(result.isEmpty()) {

			mv.addObject("msg", "사용자가 존재하지 않습니다");
			mv.addObject("loc", "/member/findId");
			mv.setViewName("common/msg");
			
		}else {
			int suc=mss.sendFindIdMail(email, memberId);
			if(suc==0) {
				System.out.println("이메일 발송 실패:관리자에게 문의하세요");
			}
			else {
				mv.addObject("msg", "등록하신 이메일로 아이디가 전송되었습니다.");
				mv.addObject("loc", "/member/findId");
				mv.setViewName("common/msg");
			}
		}
				
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/member/findPwSMTP")
	public int findPwSMTP(Date birth,String name,Member mem,String memberId,String pwCheck) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {

		int suc=0;
		System.out.println(birth+"gggggggggggggg"+name+"ggggggggg"+memberId);
		mem.setMemberId(memberId);
		mem.setBirth(birth);
		mem.setMemberName(name);
		String email="";
		System.out.println(pwCheck+"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		
		List<Member> result=service.findPw(mem);
	
		if(!result.isEmpty()) {
			email=aes.decrypt((result.get(0).getEmail().toString()));
		}
		
		if(result.isEmpty()) {
			//사용자 정보가 존재하지 않음
			suc=1;
			
		}else {
			//등록한 이메일로 발송
			suc=mss.sendFindPwMail(email,pwCheck);
		}
				
		
		return suc;
	}
	
	//회원정보 변경 눌렀을때 memberPw가 null인 경우 바로 이동 
	@RequestMapping("/member/updateNaver.do")
	public ModelAndView memberUpdateNaver(ModelAndView mv) {
		mv.setViewName("member/updateNaver");
		return mv;
	}
	
	@RequestMapping("/member/updateEndEnd.do")
	public ModelAndView memberUpdateEndEnd(ModelAndView mv, Member mem, SessionStatus status) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
		
		System.out.println(mem);
		
		String email = mem.getEmail();
		//이메일을 바꾸지 않았어. 
		if(email.equals(aes.decrypt(service.selectMemberOne(mem.getMemberId()).getEmail()))) {
			mem.setAuthStatus("Y");
		}else {
			mem.setAuthStatus("N");
		}
		
		if(mem.getMemberPw()!=null) {
			//비밀번호 단방향 암호화(비밀번호를 모두 소문자로 바꿔서 암호화시킴)
			//비밀번호가 null이던 아니던 상관없이 같은 메소드를 적용할 수 있어야 해서 null조건
			mem.setMemberPw(encoder.encode(mem.getMemberPw().toLowerCase()));
		}
		//양방향 암호화
		mem.setZipcode(aes.encrypt(mem.getZipcode()));
		mem.setAddress(aes.encrypt(mem.getAddress()));
		mem.setDetailAddress(aes.encrypt(mem.getDetailAddress()));
		mem.setEmail(aes.encrypt(mem.getEmail()));
		mem.setPhone(aes.encrypt(mem.getPhone()));
		
		int result = service.updateMember(mem);
		
		//조건 1. 이메일을 변경하지 않았으면서 나머지가 update성공했을때
		//조건2. 이메일을 변경했고, update성공햇으나 아직 인증되지 않았을때. 
		//조건 3. update실패했을때. 
		
		
		if(result>0) {
			// 이메일을 변경했고, 이메일 인증을 발송해야하는 경우.
			if(mem.getAuthStatus().equals("N")) {
				mv.addObject("email",email);
				String authKey = mss.sendAuthMail(email, mem.getMemberId(), mem.getMemberName());
				Map<String,String> map = new HashMap<>();
				map.put("id",mem.getMemberId());
				map.put("key",authKey);
				//db에 인증키 넣어주기
				result = service.updateAuthKey(map);
				if(result>0) {
					mv.setViewName("redirect:/member/enrollAnnoun");
					if(!status.isComplete()) {
						status.setComplete();
					}
				}else {
					mv.addObject("msg","인증 이메일 발송 실패 - 관리자에게 문의하세요");
					mv.addObject("loc","/");
					mv.setViewName("common/msg");
				}		
				// 회원정보 변경 자체는 성공해서, 다른 정보들을 바꿨는데 이메일은 안바꿨어. 
			}else {
				if(!status.isComplete()) {
					status.setComplete();
				}
				mv.addObject("msg","회원정보가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
				mv.addObject("loc","/");
				mv.setViewName("common/msg");
			}
		// 회원정보 update자체가 실패했을때. 
		}else {
			mv.addObject("msg","회원정보 변경 실패 - 관리자에게 문의하세요.");
			mv.addObject("loc","/member/mypage.do");
			mv.setViewName("common/msg");
		}
		
		return mv;
	}
	
	@RequestMapping("/member/updatePw")
	public ModelAndView updatePw(ModelAndView mv,String password,Member mem,String modalId) {
		System.out.println(password);
		mem.setMemberPw(password);
		if(mem.getMemberPw()!=null) {
			//비밀번호 단방향 암호화(비밀번호를 모두 소문자로 바꿔서 암호화시킴)
			mem.setMemberPw(encoder.encode(password.toLowerCase()));
		}
		mem.setMemberId(modalId);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+mem);
		int result=service.updatePw(mem);
		
		if(result>0) {
			mv.addObject("msg", "비밀번호 재설정이 완료되었습니다");
			mv.addObject("loc", "/member/login");
			mv.setViewName("common/msg");
		}else {
			mv.addObject("msg", "비밀번호 재설정이 실패하였습니다");
			mv.addObject("loc", "/member/findId");
			mv.setViewName("common/msg");
		}
		return mv;
	}
		
	@RequestMapping("/member/updatePw.do")
	public ModelAndView updateMemberPw(ModelAndView mv) {
		mv.setViewName("member/updatePw");
		return mv;
	}

	@RequestMapping("/member/updatePwCheck.do")
	public ModelAndView memberUpdatePwCheck(ModelAndView mv, Member m) {
		//그냥 m은 비밀번호 입력 화면에서 불러온 아이디랑 비밀번호 
		// mem은 m에서 가져온 아이디를 where절에 넣어서 불러온 member 데이터

		Member mem = service.selectMemberOne(m.getMemberId());

		if(mem!=null && encoder.matches(m.getMemberPw(), mem.getMemberPw())) {
			mv.addObject("msg", "비밀번호가 인증되었습니다.비밀번호 변경 화면으로 전환합니다.");
			mv.addObject("loc", "/member/updatePwEnd.do");

		}else {
			mv.addObject("msg", "비밀번호 인증 실패!비밀번호를 다시 입력해주세요.");
			mv.addObject("loc", "/member/updatePw.do");
		}
			mv.setViewName("common/msg");
		return mv;
	}
	

	 @ResponseBody
		@RequestMapping(value = "/member/VerifyRecaptcha", method = RequestMethod.POST)
		public int VerifyRecaptcha(HttpServletRequest request) {		    
		 	VerifyRecaptcha.setSecretKey("6LdmOf4ZAAAAANb1RZhYfscOrxGJ0JxhkoaZ5Ncy");
		    String gRecaptchaResponse = request.getParameter("recaptcha");
		    try {
		       if(VerifyRecaptcha.verify(gRecaptchaResponse))
		          return 0; // 성공
		       else return 1; // 실패
		    } catch (Exception e) {
		        e.printStackTrace();
		        return -1; //에러
		    }
		}

	@RequestMapping("/member/updatePwEnd.do")
	public ModelAndView updatePwEnd(ModelAndView mv) {
		mv.setViewName("member/updatePwEnd");
		return mv;
	}

	// simpleCaptcha관련
	// captcha 이미지 가져오는 메서드
	@RequestMapping("/captchaImg.do")
	@ResponseBody
	public void captchaImg(HttpServletRequest req, HttpServletResponse res) throws Exception{ 
		new CaptchaUtil().getImgCaptCha(req, res); 
	}

	
	// 전달받은 문자열로 음성 가져오는 메서드 
	@RequestMapping("/captchaAudio.do") 
	@ResponseBody 
	public void captchaAudio(HttpServletRequest req, HttpServletResponse res) throws Exception{ 
		Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME); 
		String getAnswer = captcha.getAnswer(); 
		new CaptchaUtil().getAudioCaptCha(req, res, getAnswer); }


	@RequestMapping("/member/captchaCheck.do")
	@ResponseBody
	public int captchaCheck(@RequestParam String target, HttpServletRequest req) {
		int result = 0;
		Captcha captcha = (Captcha) req.getSession().getAttribute(Captcha.NAME);
		if(target!=null && !"".equals(target)) {
			if(captcha.isCorrect(target)) {
				req.getSession().removeAttribute(Captcha.NAME);
				result = 1;
			}else {
				result = 0;
			}
		}
		return result;
	}
	
	@RequestMapping("/member/updatePwEndEnd.do")
	public ModelAndView updatePwEndEnd(ModelAndView mv, Member m, SessionStatus status) {
		
		//m은 updatePwEndEnd에서 가져온 member데이터고
		//mem은 m에서 가져온 데이터를 encode해준 애 넣은거. 
		Map<String,String> map = new HashMap<>();
		
		map.put("id",m.getMemberId());
		map.put("pw", encoder.encode(m.getMemberPw().toLowerCase()));
		
		int result = service.updateMemberPw(map);
		if(result>0) {
			if(!status.isComplete()) {
				status.setComplete();
			}
			mv.addObject("msg","비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
			mv.addObject("loc","/");
			
		}else {
			mv.addObject("msg","비밀번호 변경 실패 - 관리자에게 문의하세요.");
			mv.addObject("loc","/member/mypage.do");	
		}
		mv.setViewName("common/msg");
		return mv;
	}
	
	

	//마이페이지에서 마일리지 관리로 화면전환
	@RequestMapping("/member/mileage.do")
	public String selectMileageList(Model m,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage,
			@RequestParam(value="status",required=false,defaultValue="")String status,
			@RequestParam(value="startDate",required=false,defaultValue="")String startDate,
			@RequestParam(value="endDate",required=false,defaultValue="")String endDate) {
		
//		List<Mileage> list = milService.selectMileageList(cPage,numPerPage,keyword,startDate,endDate);
//		
//		int totalContents = milService.selectMileageCount(keyword,startDate,endDate);
//		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "mileage.do"));
//		m.addAttribute("list",list);
//		m.addAttribute("totalContents",totalContents);
		
		return "member/mileageList";
	}
	
	@RequestMapping("/member/defaultMileage.do")
	@ResponseBody
	public Map<String,Object> defaultMileage(@RequestParam String memberId,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage){
		List<Mileage> list = milService.selectDefaultMileage(memberId,cPage,numPerPage);
		int totalContents = milService.selectDefaultMileageCount(memberId);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "defaultMileage.do");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalContents", totalContents);
		map.put("pageBar", pageBar);
		return map;
	}
	
	@RequestMapping("/member/conditionMileage.do")
	@ResponseBody
	public Map<String,Object> conditionMileage(@RequestParam String memberId,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage,
			@RequestParam(value="status",required=false,defaultValue="")String status,
			@RequestParam(value="startDate",required=false,defaultValue="")String startDate,
			@RequestParam(value="endDate",required=false,defaultValue="")String endDate
			){

		Map<String,Object> condition = new HashMap<String,Object>();
		condition.put("memberId", memberId);
		condition.put("status", status);
		condition.put("startDate", startDate);
		condition.put("endDate", endDate);
		
		List<Mileage> list = milService.selectConditionMileage(cPage,numPerPage,condition);
		int totalContents = milService.selectConditionMileageCount(condition);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "conditionMileage.do");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalContents", totalContents);
		map.put("pageBar",pageBar);
		return map;
	}
	
	//함께해요 관리
	@RequestMapping("/member/withList.do")
	public ModelAndView memberWithList(ModelAndView mv, @RequestParam String memberId) {
		
		mv.addObject("withBoardTotalCount",withService.bringAllWithBoardCount(memberId));
		mv.addObject("withCommentTotalCount",withService.bringAllWithCommentCount(memberId));
		mv.setViewName("member/withList");
		return mv;
	}
	
	//함께해요 관리 내가 작성한글 보기 
	@RequestMapping("/member/bringAllWithBoard.do")
	@ResponseBody
	public Map<String,Object> bringAllWith(@RequestParam String memberId,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage){
		List<WithBoard> list = withService.bringAllWithBoard(memberId,cPage,numPerPage);
		int totalContents = withService.bringAllWithBoardCount(memberId);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "bringAllWithBoard.do");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalContents", totalContents);
		map.put("pageBar", pageBar);
		return map;
	}
	
	@RequestMapping("/member/bringAllWithComment.do")
	@ResponseBody
	public Map<String,Object> bringAllWithComment(@RequestParam String memberId,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage){
		List<WithComment> list = withService.bringAllWithComment(memberId,cPage,numPerPage);
		int totalContents = withService.bringAllWithCommentCount(memberId);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "bringAllWithComment.do");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalContents", totalContents);
		map.put("pageBar", pageBar);
		return map;
	}	
	
	@RequestMapping("/member/deletedWithBoard.do")
	@ResponseBody
	public WithBoard deletedWithBoard(@RequestParam int wbNo) {
		WithBoard wb = withService.selectOneWith(wbNo);
		return wb;
	}
	
	@RequestMapping("/member/bringCommentedWith.do")
	@ResponseBody
	public Map<String,Object> bringCommentedWith(@RequestParam String memberId,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage){
		List<WithBoard> list = withService.bringCommentedWith(memberId,cPage,numPerPage);
		int totalContents = withService.bringCommentedWithCount(memberId);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "bringCommentedWith.do");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalContents", totalContents);
		map.put("pageBar", pageBar);
		return map;
	}	
	
	@RequestMapping("/member/deleteBringAllWith.do")
	@ResponseBody
	public int deleteBringAllWith(@RequestParam(value="checkfordelete[]") List<String> checkfordelete) {
		int result = 0;
		System.out.println(checkfordelete.size());
		if(checkfordelete.size()==0) {
			result = 1;
		}else {
			for(int i=0;i<checkfordelete.size();i++) {
				System.out.println("여기====="+Integer.parseInt(checkfordelete.get(i))+"=====여기");
				result = withService.deleteBringAllWith(Integer.parseInt(checkfordelete.get(i)));
			}			
		}
		return result;
	}
	
	@RequestMapping("/member/deleteBringAllWithComment.do")
	@ResponseBody
	public int deleteBringAllWithComment(@RequestParam(value="checkStatus[]") List<String> checkStatus) {
		int result = 0;
		System.out.println(checkStatus.size());
		if(checkStatus.size()==0) {
			result = 1;
		}else {
			for(int i=0;i<checkStatus.size();i++) {
				result = withService.deleteBringAllWithComment(Integer.parseInt(checkStatus.get(i)));
			}			
		}
		return result;
	}
	
	//이메일 수신 동의 페이지 전환
	@RequestMapping("/member/emailAgree.do")
	public String emailAgree() {
		return "member/emailAgree";
	}
	
	//이메일 수신 동의 확인 눌렀을때
	@RequestMapping("/member/emailAgreeEnd.do")
	public ModelAndView emailAgreeEnd(@RequestParam Map<String,Object> map,ModelAndView mv, SessionStatus status) {
//		for(String key : map.keySet()) { 
//			String value = (String) map.get(key); 
//			System.out.println(key + " : " + value); 
//		}
		
		Map<String,Object> target = new HashMap<String,Object>();
		target.put("memberId", (String)map.get("memberId"));
		if(map.get("emailStatus")==null) {
			target.put("emailStatus", "N");
		}else {
			target.put("emailStatus", "Y");
		}
		int result = service.updateEmailStatus(target);
		if(result>0) {
			if(!status.isComplete()) {
				status.setComplete();
			}
			mv.addObject("msg", "이메일 수신 동의가 변경되었습니다.");
			mv.addObject("subMsg","로그인이 해제 됩니다. 다시 로그인해주세요.");
			mv.addObject("status","success");
			mv.addObject("loc", "/");
		}else {
			mv.addObject("msg", "이메일 수신 동의 변경 실패!");
			mv.addObject("subMsg","관리자에게 문의해주세요.");
			mv.addObject("status","error");
			mv.addObject("loc", "/member/emailAgree.do");
		}
			mv.setViewName("common/sweetMsg");
		
		return mv;

	}
	
	//회원탈퇴 페이지 전환 
	@RequestMapping("/member/withdraw.do")
	public String memberWithdraw() {
		return"member/withdraw";
	}
	
	//memberStatus 전환하기
	@RequestMapping("/member/withdrawEnd.do")
	public ModelAndView withdrawEnd(@RequestParam Map<String,Object> map,ModelAndView mv, SessionStatus status) {
//		for(String key : map.keySet()) { 
//			String value = (String) map.get(key); 
//			System.out.println(key + " : " + value); 
//		}
		//체크 안하고 넘기면 
		if(map.get("withdrawChk")==null) {
			mv.addObject("msg", "회원탈퇴에 동의하지않으셨습니다.");
			mv.addObject("subMsg","탈퇴하시려면 회원탈퇴 유의사항을 모두 확인하시고, 메종 회원탈퇴에 동의해주세요.");
			mv.addObject("status","info");
			mv.addObject("loc", "/member/withdraw.do");
			mv.setViewName("common/sweetMsg");			
		}else {
			//확인 버튼을 누르면 일단 스왈을 띄워줍니다. 
			mv.addObject("memberId",(String)map.get("memberId"));
			if(map.get("withdrawCom")==null) {
				mv.addObject("withdrawCom","");		
			}else {
				mv.addObject("withdrawCom",(String)map.get("withdrawCom"));				
			}
			mv.setViewName("member/memberStatusMsg");
		}
		
		return mv;

	}
	
	//탈퇴 진행용 메소드
	@RequestMapping("member/memberStatusNo")
	public ModelAndView memberStatusNo(@RequestParam Map<String,Object> map, SessionStatus status, ModelAndView mv) {
		Map<String,Object> target = new HashMap<String,Object>();
		target.put("memberId", (String)map.get("memberId"));
		if(map.get("withdrawCom")==null) {
			target.put("withdrawCom", "");
		}else {
			target.put("withdrawCom", map.get("withdrawCom"));
		}	
		target.put("withdrawChk", "N");
		
		//회원테이블에 업데이트 해주고
		int result = service.updateMemberStatus(target);
		if(result>0) {
			//멤버 무덤 테이블에 insert해주기
			result = service.updateMemberWithdraw(target);
			if(result>0) {
				if(!status.isComplete()) {
					status.setComplete();
				}
				mv.setViewName("redirect:/");
			}else {
				mv.addObject("msg", "회원 탈퇴 실패!");
				mv.addObject("subMsg","관리자에게 문의해주세요.");
				mv.addObject("status","error");
				mv.addObject("loc", "/member/withdraw.do");
				mv.setViewName("common/sweetMsg");			
			}
		}else {
			mv.addObject("msg", "회원 탈퇴 실패!");
			mv.addObject("subMsg","관리자에게 문의해주세요.");
			mv.addObject("status","error");
			mv.addObject("loc", "/member/withdraw.do");
			mv.setViewName("common/sweetMsg");			
		}
		
		return mv;
	}

	@RequestMapping("/auth/kakao/callback")
	public String kakaoCallback(String code,Model m,ModelAndView mv,HttpServletRequest request) throws Exception {
		//post방식으로 key=value 데이터를 요청(카카오쪽으로)
		RestTemplate rt=new RestTemplate();
		HttpHeaders headers=new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String,String> params=new LinkedMultiValueMap<>();
		params.add("grant_type","authorization_code");
		params.add("client_id", "818a08c8e17c0dda3c071f31ea989c44");

		//params.add("redirect_uri", "http://localhost:9090/maison/auth/kakao/callback");

		params.add("redirect_uri", "http://rclass.iptime.org:9999/20AM_MAISON_final/auth/kakao/callback");
		params.add("code", code);
		
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest=
				new HttpEntity<>(params,headers);
		
		ResponseEntity<String> response=rt.exchange(
					"https://kauth.kakao.com/oauth/token",
					HttpMethod.POST,
					kakaoTokenRequest,
					String.class
		);
		
		
		ObjectMapper objectMapper=new ObjectMapper();
		OAuthToken oauthToken=null;
		try {
			oauthToken=objectMapper.readValue(response.getBody(), OAuthToken.class);
		}catch(JsonMappingException e){
			e.printStackTrace();
		}catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("카카오 엑세스 토큰 : "+oauthToken.getAccess_token());
		
		RestTemplate rt2=new RestTemplate();
		HttpHeaders headers2=new HttpHeaders();
		headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		HttpEntity<MultiValueMap<String,String>> kakaoProfileRequest2=
				new HttpEntity<>(headers2);
		
		ResponseEntity<String> response2=rt2.exchange(
					"https://kapi.kakao.com/v2/user/me",
					HttpMethod.POST,
					kakaoProfileRequest2,
					String.class
		);
		
		ObjectMapper objectMapper2=new ObjectMapper();
		KakaoProfile kakaoProfile=null;
		try {
			kakaoProfile=objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		}catch(JsonMappingException e){
			e.printStackTrace();
		}catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		UUID garbagePassword=UUID.randomUUID();
		
		System.out.println("카카오 아이디 :"+kakaoProfile.getId());
		
		System.out.println("카카오 이메일 :"+kakaoProfile.getKakao_account().getEmail());
		System.out.println("카카오 이름 :"+kakaoProfile.getKakao_account().getProfile().getNickname());
		System.out.println("서버 패스워드 :"+garbagePassword);
		
		Member mem=service.selectMemberOne(Integer.toString(kakaoProfile.getId()));
		String loc="";
		System.out.println(mem);
		
		
		if(mem!=null) {
			if("Y".equals(mem.getAuthStatus())) {
				logger.debug("로그인 성공");
				//세션처리
				m.addAttribute("loginMember", mem);
				m.addAttribute("msg", "로그인 성공");
				m.addAttribute("loc", "/");
				loc = "redirect:/";
			}else {
				logger.debug("이메일 인증 미완료");
				m.addAttribute("msg", "이메일이 아직 인증되지 않았습니다.");
				m.addAttribute("loc", "/member/login");
				loc = "common/msg";
			}
			
		}else {
			Member memKakao = new Member();
			memKakao.setMemberId(Integer.toString(kakaoProfile.getId()));
			memKakao.setEmail(kakaoProfile.getKakao_account().getEmail());
			memKakao.setMemberName(kakaoProfile.getKakao_account().getProfile().getNickname());
			//memKakao.setMemberPw(garbagePassword.toString());
			//memKakaor을 세션에 넣음
			m.addAttribute("memKakao", memKakao);
			loc= "redirect:/member/kakao/enroll";
		
		}
		
		return loc;
	}
	
	@RequestMapping("/member/kakao/enroll")
	public ModelAndView enrollKakao(@SessionAttribute("memKakao") Member memKakao, SessionStatus status, ModelAndView mv) {


		

		mv.addObject("memKakao",memKakao);
		mv.setViewName("member/kakaoLogin");
		
		if(!status.isComplete()) {
			status.setComplete();
		}
		
		return mv;
	}
	
	
	//주문취소 버튼 눌렀을때
	@RequestMapping("/member/order/cancel.do")
	public ModelAndView memberOrderCancel(ModelAndView mv, @RequestParam int orderNo) {
		Order o = orderService.selectOneOrder(orderNo);
		mv.addObject("order",o);
		mv.setViewName("member/mypage/order/cancelChk");
		return mv;
	}
	
	//주문취소 sweet alert에서 확인을 눌렀을때
	@RequestMapping("/member/order/cancelEnd.do")
	public ModelAndView memberOrderCancelEnd(ModelAndView mv, @RequestParam int orderNo) {
		int result = orderService.updateOrderStatus(orderNo);
		if(result>0) {
			mv.addObject("msg", "주문 취소 신청이 완료되었습니다.");
			mv.addObject("subMsg","관리자가 취소완료할때까지는 2-3일이 소요됩니다.");
			mv.addObject("status","success");
			mv.addObject("loc", "/member/mypage.do");	
		}else {
			mv.addObject("msg", "주문취소 신청 실패!");
			mv.addObject("subMsg","다시한번 시도해보시고 관리자에게 문의해주세요.");
			mv.addObject("status","error");
			mv.addObject("loc", "/member/mypage.do");	
		}
		mv.setViewName("common/sweetMsg");
		return mv;
	}
	

}
