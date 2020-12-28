package com.kh.maison.admin.scheduler.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.kh.maison.admin.scheduler.service.AdminSchedulerService;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.common.email.MailSendService;
import com.kh.maison.member.controller.MemberController;
import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
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
	
	@Scheduled(cron="0 59 23 1 * ?")
	public void memberGradeUpdate() {
		
	//매월 말일 11시 59분에 돌아가게 만들기 0 59 23 L * ?
	//1. 먼저 멤버리스트를 전부다 가져옵니다. 
	List<Member> list = service.selectMemberList();
	//2. 멤버를 가져와서 거기서 memberId를 뽑아냅니다. 
	//그런다음 4개의 등급의 기준선을 불러옵니다. 
	List<Grade> list2 = service.selectGradeList();
	int aceBase = list2.get(0).getGradeBase();
	int goldBase = list2.get(1).getGradeBase();
	int vipBase = list2.get(2).getGradeBase();
	int mvgBase = list2.get(3).getGradeBase();
	for(int i=0;i<list.size();i++) {
		//3. order_tb에서 totalprice의 sum을 불러옵니다. 
		//이때 where절에 memberId를 넣어서 불러옵니다. 
		int totalPriceSum = service.selectTotalPriceSum(list.get(i).getMemberId());
		if(totalPriceSum<aceBase) {
			//아예 totalPriceSum이 aceBase보다 작아. 그러면 아무것도 안해
			//어쩌피 처음에 default값이 ace로 되어 있거든
		}else {
			//어? 근데 aceBase보다 크네?
			//그러면 이제 goldBase부터 체크를 하는겨
			if(totalPriceSum>goldBase) {
				//totalPriceSum이 aceBase보다 크고, goldBase보다 커 
				//그러면 우선 얘의 membId를 where절로 가져가서, 얘의 gradeCode를 gold로 바꿔주는겨.
				service.updateToGold(list.get(i).getMemberId());
				if(totalPriceSum>vipBase) {
					//얘의 grade를 gold로 업데이트 했어.
					//왐마?근데 얘가 vipBase보다 도 크네?그러면 다시 update해주는 거지
					service.updateToVip(list.get(i).getMemberId());
					if(totalPriceSum>mvgBase) {
						//완전 대박이지 얘가 mvgBase보다 더 크대
						//그러면 다시 mvgBase로 업데이트 해줘야지
						service.updateToMvg(list.get(i).getMemberId());
					}else {
						//아니면 또 어쩔 수 없고. 
					}
				}else {
					//아니면 그냥 gold업데이트 한채로 넘어가고. 
				}
			}else {
				//얘는 이제 aceBase보다는 큰데 goldBase보다는 작은거지.
				//그러면 얘도 변화 안줌.
			}
		}
	}

	}
	
	
//	@Scheduled(cron="0/20 * * ? * ?") //테스트용
	@Scheduled(cron="0 0 13 * * *") //매일 13시0분0초에 실행
	public void sendCycleEmail() {
		logger.debug("sendCycleEmail 실행");
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
				
				//해당 상품의 large카테고리를 기준으로 구매율TOP3 가져오기
				Map<String,String> recommendMap = new HashMap<>();
				recommendMap.put("no", String.valueOf(product.getProductNo()));
				recommendMap.put("largeCate", product.getLargeCate());
				List<Product> recommendList = service.selectRecommendList(recommendMap);
				
				logger.debug("추천 상품");
				for(Product p : recommendList) {
					logger.debug(p.getProductNo()+"번 : "+p.getProductName());
				}
				logger.debug("추천 상품 끝");
				
				int result = mss.sendCycleEmail(cycle.getEmail(), cycle.getMemberName(), cycle.getProductNo(), product.getProductName(), recommendList);
				
				if(result==1) logger.debug("오늘의 쇼핑주기 메일알림서비스. 상품번호 : "+cycle.getProductNo()+" 아이디 : "+cycle.getMemberId());					
				else logger.debug("메일알림서비스 전송 실패!!! 상품번호 : "+cycle.getProductNo()+" 아이디 : "+cycle.getMemberId());
			}
			
			
		}
	}
}
