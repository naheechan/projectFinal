package com.kh.maison.basket.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface BasketDao {
	
	List<Map> selectBasketList(SqlSessionTemplate session,String memberId);
	int deleteBasket(SqlSessionTemplate session,int basketNo);
	
}
