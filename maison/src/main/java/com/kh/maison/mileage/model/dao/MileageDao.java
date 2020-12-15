package com.kh.maison.mileage.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.mileage.model.vo.Mileage;



public interface MileageDao {
	
	int insertWelcomeMileage(SqlSessionTemplate session,String memberId);
		
	int insertBuyMileage(SqlSessionTemplate session, Mileage mil);
	
	int updateMemberMileage(SqlSessionTemplate session,String memberId);
	
	int updateUseMileage(SqlSessionTemplate session,Mileage mil2);
	
	List<Mileage> selectDefaultMileage(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);
	
	int selectDefaultMileageCount(SqlSessionTemplate session,String memberId);
}
