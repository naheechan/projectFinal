package com.kh.maison.basket.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.basket.model.vo.Basket;

public interface BasketService {

	List<Map> selectBasketList(String memberId);
	int deleteBasket(int basketNo);
	int updateAmount(Map param);
	int selectBasketCount(String memberId);
	Basket selectBasketOne(int basketNo);
	
	
}
