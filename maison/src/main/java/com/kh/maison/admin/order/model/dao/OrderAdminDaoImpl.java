package com.kh.maison.admin.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.order.model.vo.Order;

@Repository
public class OrderAdminDaoImpl implements OrderAdminDao {

	@Override
	public List<Order> selectOrderList(SqlSession session,int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectTotalCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectTotalCount");
	}
	
	
	
	

}
