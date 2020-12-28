package com.kh.maison.mileage.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.mileage.model.vo.Mileage;



public interface MileageDao {
	
	int insertWelcomeMileage(SqlSessionTemplate session,String memberId);
		
	int insertBuyMileage(SqlSessionTemplate session, Mileage mil);
	
	int updateMemberMileage(SqlSessionTemplate session,String memberId);
	
	int updateUseMileage(SqlSessionTemplate session,Mileage mil2);
	
	List<Mileage> selectDefaultMileage(SqlSessionTemplate session,String memberId,int cPage,int numPerPage);
	
	int selectDefaultMileageCount(SqlSessionTemplate session,String memberId);
	
	List<Mileage> selectConditionMileage(SqlSessionTemplate session, int cPage, int numPerPage, Map<String,Object> condition);

	int selectConditionMileageCount(SqlSessionTemplate session,Map<String,Object> condition);

	int insertCancelMileageFirst(SqlSessionTemplate session,Mileage mil);
	int insertCancelMileageSecond(SqlSessionTemplate session,Mileage mil2);
}
