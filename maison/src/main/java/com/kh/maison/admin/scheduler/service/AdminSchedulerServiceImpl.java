package com.kh.maison.admin.scheduler.service;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.maison.admin.scheduler.dao.AdminSchedulerDao;
import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

@Component
public class AdminSchedulerServiceImpl implements AdminSchedulerService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private AdminSchedulerDao dao;
	
	@Override
	public List<Product> selectProductList() {
		// TODO Auto-generated method stub
		List<Product> list = dao.selectProductList(session);
		return list;
	}

	@Override
	public List<Member> selectMemberList() {
		// TODO Auto-generated method stub
		List<Member> list = dao.selectMemberList(session);
		return list;
	}

	@Override
	public int selectTotalPriceSum(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.selectTotalPriceSum(session,memberId);
		return result;
	}

	@Override
	public List<Grade> selectGradeList() {
		// TODO Auto-generated method stub
		List<Grade> list = dao.selectGradeList(session);
		return list;
	}

	@Override
	public int updateToGold(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.updateToGold(session,memberId);
		return result;
	}

	@Override
	public int updateToVip(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.updateToVip(session,memberId);
		return result;
	}

	@Override
	public int updateToMvg(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.updateToMvg(session,memberId);
		return result;
	}

}
