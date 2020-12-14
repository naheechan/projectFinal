package com.kh.maison.basket.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.basket.model.vo.Basket;

public interface BasketDao {
	
	List<Map> selectBasketList(SqlSessionTemplate session,String memberId);
	int deleteBasket(SqlSessionTemplate session,int basketNo);
	int updateAmount(SqlSessionTemplate session,Map param);
	int selectBasketCount(SqlSessionTemplate session,String memberId);
	Basket selectBasketOne(SqlSessionTemplate session,int basketNo);
	int insertBasket(SqlSessionTemplate session,Map param); 
	int checkBasket(SqlSessionTemplate session,Map param);
	int updateBasket(SqlSessionTemplate session, Map param);
	
}
