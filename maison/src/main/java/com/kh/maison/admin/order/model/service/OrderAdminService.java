package com.kh.maison.admin.order.model.service;

import java.util.List;

import com.kh.maison.order.model.vo.Order;

public interface OrderAdminService {
	
	List<Order> selectOrderList(int cPage, int numPerPage);
	
	int selectTotalCount();

}
