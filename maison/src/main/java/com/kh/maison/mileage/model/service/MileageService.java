package com.kh.maison.mileage.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.mileage.model.vo.Mileage;

public interface MileageService {
	
	int insertWelcomeMileage(String memberId);
	
	int insertBuyMileage(Mileage mil);
	
	int updateMemberMileage(String memberId);
	
	int updateUseMileage(Mileage mil2);
	
	//List<Mileage> selectMileageList(int cPage,int numPerPage,String keyword,String startDate,String endDate);
	
	List<Mileage> selectDefaultMileage(String memberId,int cPage,int numPerPage);
	
	int selectDefaultMileageCount(String memberId);
	
	List<Mileage> selectConditionMileage(int cPage,int numPerPage,Map<String,Object> condition);

	int selectConditionMileageCount(Map<String,Object> condition);

	int insertCancelMileageFirst(Mileage mil);
	int insertCancelMileageSecond(Mileage mil2);
}
