package com.kh.maison.shopCycle.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.shopCycle.model.dao.ShopCycleDao;
import com.kh.maison.shopCycle.model.vo.CountCycle;
import com.kh.maison.shopCycle.model.vo.CycleProduct;

@Service
public class ShopCycleServiceImpl implements ShopCycleService {
	
	@Autowired
	private ShopCycleDao dao;
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<CycleProduct> selectCycleList(Map<String,String> cateMap) {
		return dao.selectCycleList(session, cateMap);
	}

	@Override
	public CycleProduct selectCycleOne(Map<String, String> cycleMap) {
		return dao.selectCycleOne(session, cycleMap);
	}

	@Override
	public int updateCycle(Map map) {
		return dao.updateCycle(session, map);
	}

	@Override
	public List<CountCycle> selectCountCycle(String id) {
		return dao.selectCountCycle(session, id);
	}

	@Override
	public int selectCycleExist(Map map) {
		return dao.selectCycleExist(session, map);
	}

	@Override
	public int insertCycle(Map map) {
		return dao.insertCycle(session, map);
	}

	@Override
	public List<Map<String, String>> selectRecentCycle(Map<String, String> map) {
		return dao.selectRecentCycle(session, map);
	}

	@Override
	public int updateOnCycle(Map<String, String> map) {
		return dao.updateOnCycle(session, map);
	}
	
	
	
	
	

}
