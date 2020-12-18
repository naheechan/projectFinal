package com.kh.maison.admin.scheduler.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.shop.vo.Product;

@Repository
public class AdminSchedulerDaoImpl implements AdminSchedulerDao {

	
	@Override
	public List<Product> selectProductList(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectProductList");
	}

}
