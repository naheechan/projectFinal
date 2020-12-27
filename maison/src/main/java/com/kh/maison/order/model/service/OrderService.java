package com.kh.maison.order.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.model.vo.CancelSearch;
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

	int insertBuyOrderDetail(Map<String,Object> map4);
	
	List<OrderDetail> selectOrderDetail(String memberId);
	
	List<Order> selectShippingDestination(String memberId);
	
	int insertShippingDestination(Order o);
	
	//마이페이지 주문취소 관련
	Order selectOneOrder(int orderNo);
	int updateOrderStatus(int orderNo);
	List<Map<String,Object>> selectCancelList(int cPage,int numPerPage,CancelSearch cs);
	int selectCancelListCount(CancelSearch cs);
	List<Map<String,Object>> selectCancelOne(int orderNo);
	int updateOrderStatusSecond(int orderNo);
	int deleteOrderDetail(int orderNo);
}
