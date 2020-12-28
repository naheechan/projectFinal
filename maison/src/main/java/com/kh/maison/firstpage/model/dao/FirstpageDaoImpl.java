package com.kh.maison.firstpage.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

@Repository
public class FirstpageDaoImpl implements FirstpageDao {

	@Override
	public List<Product> selectBestWish(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("firstpage.selectBestWith");
	}

	@Override
	public List<Product> selectBestSeller(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("firstpage.selectBestSeller");
	}
	
	@Override
	public Member selectAdmin(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("firstpage.selectAdmin");
	}

	@Override
	public List<Product> selectrecentlyBuy(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("firstpage.selectRecentlyBuy");
	}


}
