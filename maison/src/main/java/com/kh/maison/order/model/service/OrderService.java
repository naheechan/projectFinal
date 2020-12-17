package com.kh.maison.order.model.service;

import java.util.Map;

import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;

public interface OrderService {
	
	int insertOrder(Order o);
	
	int insertOrderDetail(Basket b);
	
	int updateMileage(Map<String,Object> map2);
	
	int updateStock(Map<String,Object> map3);
	
	int bupdateStock(Basket b);
	
	OrderDetail selectOdOne(int orderDetailNo);
	
	

}
