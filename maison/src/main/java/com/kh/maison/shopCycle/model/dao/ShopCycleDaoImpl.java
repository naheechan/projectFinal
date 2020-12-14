package com.kh.maison.shopCycle.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

@Repository
public class ShopCycleDaoImpl implements ShopCycleDao {

	@Override
	public List<CycleProduct> selectCycleList(SqlSessionTemplate session, Map<String,String> cateMap) {
		return session.selectList("cycle.selectCycleList", cateMap);
	}

	@Override
	public CycleProduct selectCycleOne(SqlSessionTemplate session, Map<String, String> cycleMap) {
		return session.selectOne("cycle.selectCycleOne", cycleMap);
	}

	@Override
	public int updateCycle(SqlSessionTemplate session, Map map) {
		return session.update("cycle.updateCycle", map);
	}

	@Override
	public List<CountCycle> selectCountCycle(SqlSessionTemplate session, String id) {
		return session.selectList("cycle.selectCountCycle", id);
	}
	
	

	
	
}
