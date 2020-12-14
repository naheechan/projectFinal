package com.kh.maison.shopCycle.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

public interface ShopCycleService {
	
	List<CycleProduct> selectCycleList(Map<String,String> cateMap);
	CycleProduct selectCycleOne(Map<String,String> cycleMap);
	int updateCycle(Map map);
	List<CountCycle> selectCountCycle(String id);
}
