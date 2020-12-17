package com.kh.maison.admin.scheduler.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.shop.vo.Product;

public interface AdminSchedulerDao {
	
	List<Product> selectProductList(SqlSessionTemplate session);

}
