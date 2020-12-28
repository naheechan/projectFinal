package com.kh.maison.firstpage.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailUtils;
import com.kh.maison.firstpage.model.service.FirstpageService;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

@Controller
public class FisrstpageController {
	
	@Autowired
	private JavaMailSenderImpl mailSender;

	@Autowired
	private FirstpageService service;
	//양방향 암호화
	@Autowired
	private AES256Util aes;
	
	@RequestMapping("/firstpage/wishList.do")
	@ResponseBody
	public List<Product> selectBestWith(){	
		List<Product> list = service.selectBestWish();
		return list;	
	}
	
	@RequestMapping("/firstpage/bestSeller.do")
	@ResponseBody
	public List<Product> selectBestSeller(){
		List<Product> list = service.selectBestSeller();
		return list;
	}
	
	@RequestMapping("/firstpage/about.do")
	public ModelAndView about(ModelAndView mv) {
		mv.setViewName("common/about");
		return mv;
	}
	
	@RequestMapping("/firstpage/writeAdmin.do")
	@ResponseBody
	public Member selectAdmin() {
		Member m= service.selectAdmin();
		Member mem = new Member();
		try {
			mem.setZipcode(aes.decrypt(m.getZipcode()));
			mem.setAddress(aes.decrypt(m.getAddress()));
			mem.setDetailAddress(aes.decrypt(m.getDetailAddress()));
			mem.setEmail(aes.decrypt(m.getEmail()));
			mem.setPhone(aes.decrypt(m.getPhone()));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mem;
	}
	
	@RequestMapping("/firstpage/emailSend.do")
	public ModelAndView emailSend(ModelAndView mv,@RequestParam String nickname,
									@RequestParam String email,
									@RequestParam String title,
									@RequestParam String content) {
//		System.out.println(nickname);
//		System.out.println(email);
//		System.out.println(title);
//		System.out.println(content);
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject(nickname+"님으로부터의 문의 메일");
			sendMail.setText(new StringBuffer().append("<h1>MAISON 회원 문의</h1>")
							.append("<h3>&nbsp;제목 : </h3>")
							.append("<p>&nbsp;"+title+"</p>")
							.append("<h3>&nbsp;회신이메일 :</h3>")
							.append("<p>&nbsp;"+email+"</p>")
							.append("<h3>&nbsp;내용 : </h3>")
							.append("<p>&nbsp;"+content+"</p>")
							.toString());
			sendMail.setForm("maisonRclass@gmail.com", nickname);
			sendMail.setTo("maisonRclass@gmail.com");
			sendMail.send();
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
		mv.addObject("msg", "문의 메일이 발송되었습니다. 빠른시간 내에 답장드리겠습니다.");
		mv.addObject("loc", "/firstpage/about.do");
		mv.setViewName("common/msg");	
		
		return mv;
		
	}
	
	//footer에 신상품 이미지 꽂아주기 
	//신상품을 할지, 조회수가 높은 상품을 할지
	//만약에 조회수 높은걸 하려면 product에 column을 추가해서 해야함. 
	//진짜 진짜 마지막에 하자. 
	///firstpage/recentlyBuy.do
	@RequestMapping("/firstpage/recentlyBuy.do")
	@ResponseBody
	public List<Product> recentlyBuy(){
		List<Product> list = service.selectrecentlyBuy();
		return list;
	}
}
