package com.kh.maison.shopCycle.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.order.model.vo.Order;
import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

public interface ShopCycleService {
	
	List<CycleProduct> selectCycleList(Map<String,String> cateMap, int cPage, int numPerPage);
	CycleProduct selectCycleOne(Map<String,String> cycleMap);
	int updateCycle(Map map);
	List<CountCycle> selectCountCycle(String id);
	int selectCycleExist(Map map);
	int insertCycle(Map map);
	List<Map<String,String>> selectRecentCycle(Map<String,String> map);
	int updateOnCycle(Map<String,String> map);
	int selectProductNo(Map<String,String> map);
	int updateAlertStatus(Map<String,String> map);
	
	int checkCycleExist(Order o);
}	
