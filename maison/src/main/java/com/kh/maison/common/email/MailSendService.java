package com.kh.maison.common.email;

import java.io.UnsupportedEncodingException;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int size;
	
	private String getKey(int size) {
		this.size = size;
		return getAuthCode();
	}
	
	private String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length()<size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		return buffer.toString();
	}
	
	public String sendAuthMail(String email, String memberId) {
		String authKey = getKey(6);
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("MAISON 회원가입 이메일 인증");
			sendMail.setText(new StringBuffer().append("<h1>MAISON 이메일 인증</h1>")
					.append("<p>환영합니다 고객님</p>")
					.append("<p>저희 MAISON을 이용해주셔서 감사합니다.</p>")
					.append("<p>아래 링크를 클릭하셔서 이메일 인증을 해주세요.</p>")
					
					.append("<a href='http://localhost:9090/maison/?authId=")
					.append(memberId)
					.append("&authKey=")
					.append(authKey)
					.append("' target='_blenk'>이메일 인증 확인</a>")
					
					.toString());
					sendMail.setForm("maisonRclass@gmail.com", "MAISON");
					sendMail.setTo(email);
					sendMail.send();
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return authKey;
	}
	
	
	
}
