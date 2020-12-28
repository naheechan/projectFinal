package com.kh.maison.shopCycle.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.order.model.vo.Order;
import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

@Repository
public class ShopCycleDaoImpl implements ShopCycleDao {

	@Override
	public List<CycleProduct> selectCycleList(SqlSessionTemplate session, Map<String,String> cateMap, int cPage, int numPerPage) {
		return session.selectList("cycle.selectCycleList", cateMap, new RowBounds((cPage-1)*numPerPage, numPerPage));
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

	@Override
	public int selectCycleExist(SqlSessionTemplate session, Map map) {
		return session.selectOne("cycle.selectCycleExist", map);
	}

	@Override
	public int insertCycle(SqlSessionTemplate session, Map map) {
		return session.insert("cycle.insertCycle", map);
	}

	@Override
	public List<Map<String, String>> selectRecentCycle(SqlSessionTemplate session, Map<String, String> map) {
		return session.selectList("cycle.selectRecentCycle", map);
	}

	@Override
	public int updateOnCycle(SqlSessionTemplate session, Map<String, String> map) {
		return session.update("cycle.updateOnCycle", map);
	}

	@Override
	public int selectProductNo(SqlSessionTemplate session, Map<String, String> map) {
		return session.selectOne("cycle.selectProductNo", map);
	}

	@Override
	public int updateAlertStatus(SqlSessionTemplate session, Map<String, String> map) {
		return session.update("cycle.updateAlertStatus", map);
	}

	@Override
	public int checkCycleExist(SqlSessionTemplate session, Order o) {
		// TODO Auto-generated method stub
		return session.delete("cycle.checkCycleExist",o);
	}
	
	
	
	

	
	
}
