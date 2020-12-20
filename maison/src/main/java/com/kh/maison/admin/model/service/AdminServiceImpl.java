package com.kh.maison.admin.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.model.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private AdminDao dao;

	@Override
	public int selectFirstTotal(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstTotal(session,numDate);
		return result;
	}

	@Override
	public int selectFirstChange(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstChange(session,numDate);
		return result;
	}

	@Override
	public int selectFirstIn(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstIn(session,numDate);
		return result;
	}

	@Override
	public int selectFirstOut(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstOut(session,numDate);
		return result;
	}

	@Override
	public int selectSecondChange(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondChange(session,sendNum);
		return result;
	}

	@Override
	public int selectSecondIn(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondIn(session,sendNum);
		return result;
	}

	@Override
	public int selectSecondOut(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondOut(session,sendNum);
		return result;
	}
	
}
