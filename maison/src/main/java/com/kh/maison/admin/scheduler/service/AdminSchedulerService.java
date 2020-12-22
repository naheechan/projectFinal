package com.kh.maison.admin.scheduler.service;

import java.util.List;

import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

public interface AdminSchedulerService {

	
	List<Product> selectProductList();
	
	List<Member> selectMemberList();
	
	int selectTotalPriceSum(String memberId);
	
	List<Grade> selectGradeList();
	
	int updateToGold(String memberId);
	int updateToVip(String memberId);
	int updateToMvg(String memberId);
	
}
