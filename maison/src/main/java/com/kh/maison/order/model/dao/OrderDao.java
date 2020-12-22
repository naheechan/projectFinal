package com.kh.maison.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.order.model.vo.ShippingDestination;

public interface OrderDao {
	
	int insertOrder(SqlSession session,Order o);
	
	int insertOrderDetail(SqlSession session,Basket b);
	
	int updateMileage(SqlSession session, Map<String,Object> map2);
	
	int updateStock(SqlSession session, Map<String,Object> map3);

	int bupdateStock(SqlSession session, Basket b);
	
	int insertBuyOrderDetail(SqlSession session, Map<String,Object> map4);
	
	List<OrderDetail> selectOrderDetail(SqlSession session,String memberId);
	
	List<Order> selectShippingDestination(SqlSession session,String memberId);
	
	int insertShippingDestination(SqlSession session,Order o);
	
	
}
