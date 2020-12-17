package com.kh.maison.admin.scheduler.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.kh.maison.admin.scheduler.service.AdminSchedulerService;
import com.kh.maison.shop.vo.Product;


@Controller
public class AminSchedulerController {
		

	@Autowired
	private AdminSchedulerService service;
	 
	
	@Scheduled(cron="0 45 23 * * *")
	public void autoUpdate() {
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
