package com.kh.maison.order.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.dao.OrderDao;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.order.model.vo.ShippingDestination;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	OrderDao dao;

	@Override
	public int insertOrder(Order o) {
		// TODO Auto-generated method stub
		return dao.insertOrder(session,o);
	}

	@Override
	public int insertOrderDetail(Basket b) {
		// TODO Auto-generated method stub
		return dao.insertOrderDetail(session,b);
	}

	@Override
	public int updateMileage(Map<String,Object> map2) {
		// TODO Auto-generated method stub
		return dao.updateMileage(session,map2);
	}

	@Override
	public int updateStock(Map<String, Object> map3) {
		// TODO Auto-generated method stub
		return dao.updateStock(session,map3);
	}

	@Override
	public int bupdateStock(Basket b) {
		// TODO Auto-generated method stub
		return dao.bupdateStock(session,b);
	}

	@Override
	public OrderDetail selectOdOne(int orderDetailNo) {
		// TODO Auto-generated method stub
		return dao.selectOdOne(session,orderDetailNo);
	}

	@Override
	public List<OrderDetail> selectOrderDetail(String memberId) {
		// TODO Auto-generated method stub
		return dao.selectOrderDetail(session, memberId);
	}

	@Override
	public int insertBuyOrderDetail(Map<String, Object> map4) {
		// TODO Auto-generated method stub
		return dao.insertBuyOrderDetail(session,map4);
	}

	@Override
	public List<Order> selectShippingDestination(String memberId) {
		// TODO Auto-generated method stub
		return dao.selectShippingDestination(session,memberId);
	}

	@Override
	public int insertShippingDestination(Order o) {
		// TODO Auto-generated method stub
		return dao.insertShippingDestination(session,o);
	}

	@Override
	public int deleteBasket(Basket b) {
		// TODO Auto-generated method stub
		return dao.deleteBasket(session,b);
	}
	
	

	
	

	
	
	
	

}
