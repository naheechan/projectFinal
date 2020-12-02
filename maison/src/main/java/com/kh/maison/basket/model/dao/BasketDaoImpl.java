package com.kh.maison.basket.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.basket.model.vo.Basket;

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

	@Override
	public int updateAmount(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.update("basket.updateAmount",param);
	}

	@Override
	public int selectBasketCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		int result=session.selectOne("basket.selectBasketCount",memberId);
		
		return result;
	}

	@Override
	public Basket selectBasketOne(SqlSessionTemplate session, int basketNo) {
		// TODO Auto-generated method stub
		return session.selectOne("basket.selectBasketOne",basketNo);
	}
	
	
	
	

	
	
}
