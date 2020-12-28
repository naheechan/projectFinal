package com.kh.maison.admin.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.maison.order.model.vo.Order;

public interface OrderAdminDao {
	
	List<Order> selectOrderList(SqlSession session,int cPage, int numPerPage);
	
	int selectTotalCount(SqlSession session);

}
