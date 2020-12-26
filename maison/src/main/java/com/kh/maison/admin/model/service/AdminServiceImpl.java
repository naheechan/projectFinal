package com.kh.maison.admin.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.model.dao.AdminDao;
import com.kh.maison.admin.model.vo.MemberSearch;
import com.kh.maison.admin.model.vo.MemberWithdraw;
import com.kh.maison.admin.model.vo.ProductStock;
import com.kh.maison.admin.model.vo.WithSearch;
import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.mileage.model.vo.Mileage;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private AdminDao dao;

	@Override
	public int selectFirstTotal(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstTotal(session,numDate);
		return result;
	}

	@Override
	public int selectFirstChange(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstChange(session,numDate);
		return result;
	}

	@Override
	public int selectFirstIn(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstIn(session,numDate);
		return result;
	}

	@Override
	public int selectFirstOut(int numDate) {
		// TODO Auto-generated method stub
		int result = dao.selectFirstOut(session,numDate);
		return result;
	}

	@Override
	public int selectSecondChange(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondChange(session,sendNum);
		return result;
	}

	@Override
	public int selectSecondIn(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondIn(session,sendNum);
		return result;
	}

	@Override
	public int selectSecondOut(int sendNum) {
		// TODO Auto-generated method stub
		int result = dao.selectSecondOut(session,sendNum);
		return result;
	}

	@Override
	public List<ProductStock> bringThirdList(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		List<ProductStock> list = dao.bringThirdList(session,cPage,numPerPage);
		return list;
	}

	@Override
	public int bringThirdCount() {
		// TODO Auto-generated method stub
		int result = dao.bringThirdCount(session);
		return result;
	}

	@Override
	public List<Request> selectAllRequest(int cPage, int numPerPage, String requestStatus) {
		// TODO Auto-generated method stub
		List<Request> list = dao.selectAllRequest(session,cPage,numPerPage,requestStatus);
		return list;
	}

	@Override
	public int selectAllRequestCount(String requestStatus) {
		// TODO Auto-generated method stub
		int result = dao.selectAllRequestCount(session,requestStatus);
		return result;
	}

	@Override
	public Request selectOneRequest(int no) {
		// TODO Auto-generated method stub
		Request r = dao.selectOneRequest(session,no);
		return r;
	}

	@Override
	public int requestStatusUpdate(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int result = dao.requestStatusUpdate(session,map);
		return result;
	}

	@Override
	public List<Member> selectAllMember(int cPage, int numPerPage, MemberSearch ms) {
		// TODO Auto-generated method stub
		List<Member> list = dao.selectAllMember(session,cPage,numPerPage,ms);
		return list;
	}

	@Override
	public int selectAllMemberCount(MemberSearch ms) {
		// TODO Auto-generated method stub
		int result = dao.selectAllMemberCount(session,ms);
		return result;
	}

	@Override
	public int updateMemberStatus(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.updateMemberStatus(session,memberId);
		return result;
	}

	@Override
	public List<MemberWithdraw> deletedMemberList(int cPage, int numPerPage,MemberSearch ms) {
		// TODO Auto-generated method stub
		List<MemberWithdraw> list= dao.deletedMemberList(session,cPage,numPerPage,ms);
		return list ;
	}

	@Override
	public int deletedMemberListCount(MemberSearch ms) {
		// TODO Auto-generated method stub
		int result = dao.deletedMemberListCount(session,ms);
		return result;
	}

	@Override
	public List<Map<String, Object>> selectAllMemberShip(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return dao.selectAllMemberShip(session,cPage,numPerPage);
	}

	@Override
	public int insertMemberWithdraw(String memberId) {
		// TODO Auto-generated method stub
		int result = dao.insertMemberWithdraw(session,memberId);
		return result;
	}

	@Override
	public int selectDefaultMileage() {
		// TODO Auto-generated method stub
		return dao.selectDefaultMileage(session);
	}

	@Override
	public int selectAllMemberShipCount() {
		// TODO Auto-generated method stub
		return dao.selectAllMemberShipCount(session);
	}

	@Override
	public int updateDefaultMileage1(Mileage mi) {
		// TODO Auto-generated method stub
		return dao.updateDefaultMileage1(session,mi);
	}

	@Override
	public int updateDefaultMileage2(Mileage mi) {
		// TODO Auto-generated method stub
		return dao.updateDefaultMileage2(session,mi);
	}

	@Override
	public Grade selectOneMembership(String gradecode) {
		// TODO Auto-generated method stub
		return dao.selectOneMembership(session,gradecode);
	}

	@Override
	public int updateMemership(Grade g) {
		// TODO Auto-generated method stub
		return dao.updateMembership(session,g);
	}

	@Override
	public List<WithBoard> selectAllWithBoard(WithSearch ws) {
		// TODO Auto-generated method stub
		return dao.selectAllWithBoard(session,ws);
	}

	@Override
	public int selectAllWithBoardCount(WithSearch ws) {
		// TODO Auto-generated method stub
		return dao.selectAllWithBoardCount(session,ws);
	}

	@Override
	public List<WithComment> selectAllWithComment(MemberSearch ms) {
		// TODO Auto-generated method stub
		return dao.selectAllWithComment(session,ms);
	}

	@Override
	public int selectAllWithCommentCount(MemberSearch ms) {
		// TODO Auto-generated method stub
		return dao.selectAllWithCommentCount(session,ms);
	}

	@Override
	public List<Map<String,Object>> selectAllWithReport(WithSearch ws) {
		// TODO Auto-generated method stub
		return dao.selectAllWithReport(session,ws);
	}

	@Override
	public int selectAllWithReportCount(WithSearch ws) {
		// TODO Auto-generated method stub
		return dao.selectAllWithReportCount(session,ws);
	}
	
}
