package com.kh.maison.admin.scheduler.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.kh.maison.admin.scheduler.service.AdminSchedulerService;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailSendService;
import com.kh.maison.member.controller.MemberController;
import com.kh.maison.shop.model.service.ShopService;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;


@Controller
public class AdminSchedulerController {
		

	@Autowired
	private AdminSchedulerService service;
	@Autowired
	private AES256Util aes;
	@Autowired
	private MailSendService mss;
	@Autowired
	private ProductService productService;
	 
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Scheduled(cron="0 0/5 9 * * ?")
	public void autoUpdate() {
		logger.debug("경축! 성공! 축배를 들어라~");
		
		List<Product> list = service.selectProductList();
		
		for(int i=0;i<list.size();i++) {
			System.out.println(list.get(i).getProductName()+" : "+list.get(i).getProductStock());
		}
		
//		try {
//			MailUtils sendMail = new MailUtils(mailSender);
//			sendMail.setSubject("제목");
//			sendMail.setText(new StringBuffer().append("<table>")
//					.append("<tr>")
//					.append("<td>설마 테이블도 되는겨?</td>")
//					.append("</tr>")
//					.append("</table>")
//					.toString());
//			sendMail.setForm("maisonRclass@gmail.com", "재고 관리자");
//			sendMail.setTo("maisonRclass@gmail.com");
//			sendMail.send();
//		}catch(MessagingException e) {
//			e.printStackTrace();
//		}catch(UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
	}
	
	
//	@Scheduled(cron="0/20 * * ? * ?") //테스트용
	@Scheduled(cron="0 0 13 * * *") //매일 13시0분0초에 실행
	public void sendCycleEmail() {
		List<CycleAdmin> cycleList = service.selectAllCycleList();
		for(CycleAdmin cycle : cycleList) {
			
			int day = 1;
			int count = cycle.getOdAmount(); //직전에 구매한 갯수
			
			//이메일 복호화
			try {
				cycle.setEmail(aes.decrypt(cycle.getEmail()));
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			//현재 cycleMode에 맞게 day변수에 값 넣기
			if("onCycle".equals(cycle.getCycleMode())) {
				day = cycle.getOnCycle();
			}else {
				day = cycle.getOffCycle();
			}
			
			//오늘 날짜(시간,분,초는 전부 0으로 설정)
			Calendar calToday = Calendar.getInstance();
			calToday.set(Calendar.HOUR_OF_DAY, 0);
			calToday.set(Calendar.MINUTE, 0);
			calToday.set(Calendar.SECOND, 0);
			calToday.set(Calendar.MILLISECOND, 0);
			
			//startDate날짜
			Date startDate = cycle.getStartDate();
			Calendar calStart = Calendar.getInstance();
			calStart.setTime(startDate);
			
			//오늘보다 같거나 커질때까지 주기날짜를 더함. (다음 예상 구매일 구하는 거임)
			do {
				calStart.add(Calendar.DATE, day*count);
			}while(calStart.getTimeInMillis() < calToday.getTimeInMillis());
		
			//다음 예상 구매일이 오늘이라면 이메일 발송
			if(calStart.getTimeInMillis() == calToday.getTimeInMillis()) {
				
				//해당 상품 정보 가져오기
				Product product = productService.selectProductOne(cycle.getProductNo());
				
				int result = mss.sendCycleEmail(cycle.getEmail(), cycle.getMemberName(), cycle.getProductNo(), product.getProductName());
				
				if(result==1) logger.debug("오늘의 쇼핑주기 메일알림서비스. 상품번호 : "+cycle.getProductNo()+" 아이디 : "+cycle.getMemberId());					
				else logger.debug("메일알림서비스 전송 실패!!! 상품번호 : "+cycle.getProductNo()+" 아이디 : "+cycle.getMemberId());
			}
			
			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
}
