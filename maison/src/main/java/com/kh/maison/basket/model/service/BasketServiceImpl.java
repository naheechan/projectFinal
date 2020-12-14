package com.kh.maison.basket.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.basket.model.dao.BasketDao;
import com.kh.maison.basket.model.dao.BasketDaoImpl;
import com.kh.maison.basket.model.vo.Basket;

@Service
public class BasketServiceImpl implements BasketService {
	
	@Autowired
	SqlSessionTemplate session;
	@Autowired
	BasketDao dao;
	
	@Override
	public List<Map> selectBasketList(String memberId) {

		List<Map> list=dao.selectBasketList(session,memberId);
		
		return list;
	}

	@Override
	public int deleteBasket(int basketNo) {
		// TODO Auto-generated method stub
		int result=dao.deleteBasket(session,basketNo);
		return result;
	}

	@Override
	public int updateAmount(Map param) {
		// TODO Auto-generated method stub
		return dao.updateAmount(session,param);
	}

	@Override
	public int selectBasketCount(String memberId) {
		// TODO Auto-generated method stub
		int result=dao.selectBasketCount(session, memberId);
		
		return result;
	}

	@Override
	public Basket selectBasketOne(int basketNo) {
		// TODO Auto-generated method stub
		return dao.selectBasketOne(session,basketNo);
	}

	@Override
	public int insertBasket(Map param) {
		// TODO Auto-generated method stub
		return dao.insertBasket(session,param);
	}

	@Override
	public int checkBasket(Map param) {
		// TODO Auto-generated method stub
		return dao.checkBasket(session,param);
	}

	@Override
	public int updateBasket(Map param) {
		// TODO Auto-generated method stub
		return dao.updateBasket(session,param);
	}

	
	
}
