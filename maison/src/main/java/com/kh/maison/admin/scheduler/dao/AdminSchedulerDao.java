package com.kh.maison.admin.scheduler.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;

public interface AdminSchedulerDao {
	
	List<Product> selectProductList(SqlSessionTemplate session);
	List<CycleAdmin> selectAllCycleList(SqlSessionTemplate session);

}
