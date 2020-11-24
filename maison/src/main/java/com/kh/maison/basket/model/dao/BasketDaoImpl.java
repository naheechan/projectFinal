package com.kh.maison.basket.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BasketDaoImpl implements BasketDao {

	@Override
	public List<Map> selectBasketList(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectList("basket.selectBasketList",memberId);
	}

	@Override
	public int deleteBasket(SqlSessionTemplate session, int basketNo) {
		// TODO Auto-generated method stub
		return session.delete("basket.deleteBasket",basketNo);
	}

	
}
