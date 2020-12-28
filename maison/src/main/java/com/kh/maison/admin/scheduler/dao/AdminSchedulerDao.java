package com.kh.maison.admin.scheduler.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;

public interface AdminSchedulerDao {
	
	List<Product> selectProductList(SqlSessionTemplate session);
	List<CycleAdmin> selectAllCycleList(SqlSessionTemplate session);
	
	List<Member> selectMemberList(SqlSessionTemplate session);
	
	int selectTotalPriceSum(SqlSessionTemplate session,String memberId);
	
	List<Grade> selectGradeList(SqlSessionTemplate session);
	
	int updateToGold(SqlSessionTemplate session,String memberId);
	int updateToVip(SqlSessionTemplate session,String memberId);
	int updateToMvg(SqlSessionTemplate session,String memberId);
	
	List<Product> selectRecommendList(SqlSessionTemplate session, Map<String,String> map);
}
