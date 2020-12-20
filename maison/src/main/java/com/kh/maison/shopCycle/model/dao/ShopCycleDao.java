package com.kh.maison.shopCycle.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

public interface ShopCycleDao {

	List<CycleProduct> selectCycleList(SqlSessionTemplate session, Map<String,String> cateMap);
	CycleProduct selectCycleOne(SqlSessionTemplate session, Map<String,String> cycleMap);
	int updateCycle(SqlSessionTemplate session, Map map);
	List<CountCycle> selectCountCycle(SqlSessionTemplate session, String id);
	int selectCycleExist(SqlSessionTemplate session, Map map);
	int insertCycle(SqlSessionTemplate session, Map map);
	List<Map<String,String>> selectRecentCycle(SqlSessionTemplate session, Map<String,String> map);
	int updateOnCycle(SqlSessionTemplate session, Map<String,String> map);
	int selectProductNo(SqlSessionTemplate session, Map<String,String> map);
}
