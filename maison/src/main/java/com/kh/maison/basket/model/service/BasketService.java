package com.kh.maison.basket.model.service;

import java.util.List;
import java.util.Map;

public interface BasketService {

	List<Map> selectBasketList(String memberId);
	int deleteBasket(int basketNo);
	int updateAmount(Map param);
}
