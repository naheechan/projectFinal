package com.kh.maison.firstpage.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.firstpage.model.dao.FirstpageDao;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

@Service
public class FirstpageServiceImpl implements FirstpageService {

	@Autowired
	SqlSessionTemplate session;
	
	@Autowired
	private FirstpageDao dao;
	
	@Override
	public List<Product> selectBestWish() {
		// TODO Auto-generated method stub
		List<Product> list = dao.selectBestWish(session);
		return list;
	}

	@Override
	public List<Product> selectBestSeller() {
		// TODO Auto-generated method stub
		List<Product> list = dao.selectBestSeller(session);
		return list;
	}
	
	@Override
	public Member selectAdmin() {
		// TODO Auto-generated method stub
		Member m = dao.selectAdmin(session);
		return m;
	}


}
