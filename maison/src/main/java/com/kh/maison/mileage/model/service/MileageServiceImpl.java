package com.kh.maison.mileage.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.mileage.model.dao.MileageDao;
import com.kh.maison.mileage.model.vo.Mileage;


@Service
public class MileageServiceImpl implements MileageService {
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private MileageDao dao;

	@Override
	public int insertWelcomeMileage(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.insertWelcomeMileage(session,memberId);
		return result;
	}


	@Override
	public int updateMemberMileage(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.updateMemberMileage(session,memberId);
		return result;
	}



	@Override
	public int insertBuyMileage(Mileage mil) {
		// TODO Auto-generated method stub
		int result = dao.insertBuyMileage(session, mil);
		return result;
	}


	@Override
	public int updateUseMileage(Mileage mil2) {
		// TODO Auto-generated method stub
		int result = dao.updateUseMileage(session,mil2);
		return result;
	}


	@Override
	public List<Mileage> selectDefaultMileage(String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<Mileage> list = dao.selectDefaultMileage(session,memberId,cPage,numPerPage);
		return list;
	}


	@Override
	public int selectDefaultMileageCount(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.selectDefaultMileageCount(session,memberId);
		return result;
	}


	@Override
	public List<Mileage> selectConditionMileage(int cPage, int numPerPage, Map<String, Object> condition) {
		// TODO Auto-generated method stub
		List<Mileage> list = dao.selectConditionMileage(session, cPage, numPerPage, condition);
		return list;
	}


	@Override
	public int selectConditionMileageCount(Map<String, Object> condition) {
		// TODO Auto-generated method stub
		int result = dao.selectConditionMileageCount(session,condition);
		return result;
	}




}
