package com.kh.maison.order.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.model.vo.CancelSearch;
import com.kh.maison.basket.model.vo.Basket;
import com.kh.maison.order.model.vo.Order;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.order.model.vo.ShippingDestination;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Override
	public int insertOrder(SqlSession session, Order o) {
		// TODO Auto-generated method stub
		return session.insert("order.insertOrder",o);
	}

	@Override
	public int insertOrderDetail(SqlSession session, Basket b) {
		// TODO Auto-generated method stub
		
		return session.insert("order.insertOrderDetail",b);
	}

	@Override
	public int updateMileage(SqlSession session, Map<String,Object> map2) {
		// TODO Auto-generated method stub
		return session.update("member.updateMileage",map2);
	}

	@Override
	public int updateStock(SqlSession session, Map<String, Object> map3) {
		// TODO Auto-generated method stub
		return session.update("shop.updateStock",map3);
	}

	@Override
	public int bupdateStock(SqlSession session, Basket b) {
		// TODO Auto-generated method stub
		return session.update("shop.bupdateStock",b);
	}

	@Override
	public OrderDetail selectOdOne(SqlSession session, int orderDetailNo) {
		// TODO Auto-generated method stub
		return session.selectOne("shop.selectOdOne",orderDetailNo);
	}
	
	@Override
	public int insertBuyOrderDetail(SqlSession session, Map<String, Object> map4) {
		// TODO Auto-generated method stub
		return session.insert("order.insertBuyOrderDetail",map4);
	}

	@Override
	public List<OrderDetail> selectOrderDetail(SqlSession session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderDetail",memberId);
	}

	@Override
	public List<Order> selectShippingDestination(SqlSession session,String memberId) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectShippingDestination",memberId);
	}

	@Override
	public int insertShippingDestination(SqlSession session, Order o) {
		// TODO Auto-generated method stub
		return session.insert("order.insertShippingDestination",o);
	}

	@Override
	public Order selectOneOrder(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOneOrder",orderNo);
	}
	@Override
	public List<Order> selectMyOrderList(SqlSession session, Map param, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectMyOrderList",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int updateOrderStatus(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.update("order.updateOrderStatus",orderNo);
	}
	@Override
	public int deleteBasket(SqlSession session, Basket b) {
		// TODO Auto-generated method stub
		return session.delete("order.deleteBasket",b);
	}

	@Override
	public int countMyOrderList(SqlSession session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("order.countMyOrderList",param);
	}

	@Override
	public List<Order> selectMyOrderListAll(SqlSession session, Map param) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectMyOrderListAll",param);
	}

	@Override
	public Order selectOrderOne(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderOne",orderNo);
	}

	
	@Override
	public List<Map<String, Object>> selectCancelList(SqlSession session,int cPage,int numPerPage,CancelSearch cs) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectCancelList",cs,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectCanCelListCount(SqlSession session, CancelSearch cs) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectCancelListCount",cs);
	}

	@Override
	public List<Map<String, Object>> selectCancelOne(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectCancelOne",orderNo);
	}

	@Override
	public int updateOrderStatusSecond(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.update("order.updateOrderStatusSecond",orderNo);
	}

	@Override
	public int deleteOrderDetail(SqlSession session, int orderNo) {
		// TODO Auto-generated method stub
		return session.delete("order.deleteOrderDetail",orderNo);
	}

	@Override
	public int countMyOrder(SqlSession session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("order.countMyOrder",param);
	}

	

	
}
