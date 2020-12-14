package com.kh.maison.order.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;

public interface OrderDao {
	
	int insertOrder(SqlSession session,Order o);
	
	int insertOrderDetail(SqlSession session,Basket b);
	
	int updateMileage(SqlSession session, Map<String,Object> map2);
	
	int updateStock(SqlSession session, Map<String,Object> map3);

}
