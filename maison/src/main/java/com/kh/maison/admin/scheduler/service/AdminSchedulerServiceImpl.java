package com.kh.maison.admin.scheduler.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kh.maison.admin.scheduler.dao.AdminSchedulerDao;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;

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
	public List<CycleAdmin> selectAllCycleList() {
		return dao.selectAllCycleList(session);
	}

	
}
