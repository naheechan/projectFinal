package com.kh.maison.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.order.model.vo.ShippingDestination;

public interface OrderService {
	
	int insertOrder(Order o);
	
	int insertOrderDetail(Basket b);
	
	int updateMileage(Map<String,Object> map2);
	
	int updateStock(Map<String,Object> map3);
	
	int bupdateStock(Basket b);
	
	OrderDetail selectOdOne(int orderDetailNo);

	int insertBuyOrderDetail(Map<String,Object> map4);
	
	List<OrderDetail> selectOrderDetail(String memberId);
	
	List<Order> selectShippingDestination(String memberId);
	
	int insertShippingDestination(Order o);
	
	
	

}
