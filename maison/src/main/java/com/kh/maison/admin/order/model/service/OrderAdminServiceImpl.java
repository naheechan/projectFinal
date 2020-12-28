package com.kh.maison.admin.order.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.order.model.dao.OrderAdminDao;
import com.kh.maison.order.model.vo.Order;

@Service
public class OrderAdminServiceImpl implements OrderAdminService {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	OrderAdminDao dao;

	@Override
	public List<Order> selectOrderList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectOrderList(session,cPage,numPerPage);
	}

	@Override
	public int selectTotalCount() {
		// TODO Auto-generated method stub
		return dao.selectTotalCount(session);
	}
	
	

	
	
}
