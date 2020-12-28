package com.kh.maison.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.admin.model.vo.CancelSearch;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;

public interface OrderDao {
	
	int insertOrder(SqlSession session,Order o);
	
	int insertOrderDetail(SqlSession session,Basket b);
	
	int updateMileage(SqlSession session, Map<String,Object> map2);
	
	int updateStock(SqlSession session, Map<String,Object> map3);

	int bupdateStock(SqlSession session, Basket b);
	
	OrderDetail selectOdOne(SqlSession session, int orderDetailNo );
	
	int insertBuyOrderDetail(SqlSession session, Map<String,Object> map4);
	
	List<OrderDetail> selectOrderDetail(SqlSession session,String memberId);
	
	List<Order> selectShippingDestination(SqlSession session,String memberId);
	
	int insertShippingDestination(SqlSession session,Order o);
	

	Order selectOneOrder(SqlSession session,int orderNo);
	int updateOrderStatus(SqlSession session,int orderNo);
	List<Map<String,Object>> selectCancelList(SqlSession session,int cPage,int numPerPage,CancelSearch cs);
	int selectCanCelListCount(SqlSession session,CancelSearch cs);
	List<Map<String,Object>> selectCancelOne(SqlSession session,int orderNo);
	int updateOrderStatusSecond(SqlSession session,int orderNo);
	int deleteOrderDetail(SqlSession session,int orderNo);

	List<Order> selectMyOrderList(SqlSession session,Map param,int cPage, int numPerPage);
 
	int deleteBasket(SqlSession session, Basket b);
	
	int countMyOrderList(SqlSession session,Map param);
	
	List<Order> selectMyOrderListAll(SqlSession session,Map param);	
	
	Order selectOrderOne(SqlSession session,int orderNo);

}
