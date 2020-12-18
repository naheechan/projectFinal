package com.kh.maison.admin.scheduler.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.kh.maison.admin.scheduler.service.AdminSchedulerService;
import com.kh.maison.member.controller.MemberController;
import com.kh.maison.shop.vo.Product;


@Controller
public class AminSchedulerController {
		

	@Autowired
	private AdminSchedulerService service;
	 
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
}
