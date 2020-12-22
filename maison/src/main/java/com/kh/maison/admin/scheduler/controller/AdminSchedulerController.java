package com.kh.maison.admin.scheduler.controller;

import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.kh.maison.admin.scheduler.service.AdminSchedulerService;
import com.kh.maison.member.controller.MemberController;
import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;


@Controller
public class AdminSchedulerController {
		

	@Autowired
	private AdminSchedulerService service;
	 
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
}
