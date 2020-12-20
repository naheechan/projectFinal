package com.kh.maison.admin.scheduler.service;

import java.util.List;

import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;

public interface AdminSchedulerService {

	
	List<Product> selectProductList();
	List<CycleAdmin> selectAllCycleList();
}
