package com.kh.maison.firstpage.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;

public interface FirstpageDao {
	
	List<Product> selectBestWish(SqlSessionTemplate session);

	Member selectAdmin(SqlSessionTemplate session);
}
