package com.kh.maison.admin.scheduler.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.vo.Product;
import com.kh.maison.shopCycle.model.vo.CycleAdmin;

@Repository
public class AdminSchedulerDaoImpl implements AdminSchedulerDao {

	
	@Override
	public List<Product> selectProductList(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectProductList");
	}

	@Override
	public List<CycleAdmin> selectAllCycleList(SqlSessionTemplate session) {
		return session.selectList("admin.selectAllCycleList");
		
	}
	
	@Override
	public List<Member> selectMemberList(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectMemberList");
	}

	@Override
	public int selectTotalPriceSum(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectTotalPriceSum",memberId);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectTotalPriceSum",memberId);
		}
	}

	@Override
	public List<Grade> selectGradeList(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectGradeList");
	}

	@Override
	public int updateToGold(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.update("admin.updateToGold",memberId);
	}

	@Override
	public int updateToVip(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.update("admin.updateToVip",memberId);
	}

	@Override
	public int updateToMvg(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.update("admin.updateToMvg",memberId);
	}

}
