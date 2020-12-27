package com.kh.maison.mileage.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.mileage.model.vo.Mileage;


@Repository
public class MileageDaoImpl implements MileageDao {

	@Override
	public int insertWelcomeMileage(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.insert("mileage.insertWelcomeMileage",memberId);
	}

	@Override
	public int updateMemberMileage(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.update("mileage.updateMemberMileage",memberId);
	}

	@Override
	public int insertBuyMileage(SqlSessionTemplate session, Mileage mil) {
		// TODO Auto-generated method stub
		return session.insert("mileage.insertBuyMileage",mil);
	}

	@Override
	public int updateUseMileage(SqlSessionTemplate session, Mileage mil2) {
		// TODO Auto-generated method stub
		return session.insert("mileage.updateUseMileage",mil2);
	}

	@Override
	public List<Mileage> selectDefaultMileage(SqlSessionTemplate session, String memberId, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("mileage.selectDefaultMileage",memberId,new RowBounds((cPage-1)*numPerPage,numPerPage));
		
	}

	@Override
	public int selectDefaultMileageCount(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("mileage.selectDefaultMileageCount",memberId);
	}


	@Override
	public List<Mileage> selectConditionMileage(SqlSessionTemplate session, int cPage, int numPerPage,
			Map<String, Object> condition) {
		// TODO Auto-generated method stub
		return session.selectList("mileage.selectConditionMileage",condition,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectConditionMileageCount(SqlSessionTemplate session, Map<String, Object> condition) {
		// TODO Auto-generated method stub
		return session.selectOne("mileage.selectConditionMileageCount",condition);
	}

	@Override
	public int insertCancelMileageFirst(SqlSessionTemplate session, Mileage mil) {
		// TODO Auto-generated method stub
		return session.insert("mileage.insertCancelMileageFirst",mil);
	}

	@Override
	public int insertCancelMileageSecond(SqlSessionTemplate session, Mileage mil2) {
		// TODO Auto-generated method stub
		return session.insert("mileage.insertCancelMileageSecond",mil2);
	}

}
