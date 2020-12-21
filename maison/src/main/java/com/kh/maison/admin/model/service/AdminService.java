package com.kh.maison.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.admin.model.vo.MemberSearch;
import com.kh.maison.admin.model.vo.ProductStock;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.model.vo.Request;

public interface AdminService {
	
	//productStock.jsp 첫번째 div에 들어갈 값들 가져오는 메소드
	int selectFirstTotal(int numDate);
	int selectFirstChange(int numDate);
	int selectFirstIn(int numDate);
	int selectFirstOut(int numDate);
	
	//productStock.jsp 두번째 div에 들어갈 값들 가져오는 메소드 
	int selectSecondChange(int sendNum);
	int selectSecondIn(int sendNum);
	int selectSecondOut(int sendNum);
	
	//productStock.jsp 세번째 div에 들어갈 값들 가져오는 메소드
	List<ProductStock> bringThirdList(int cPage,int numPerPage);
	int bringThirdCount();
	
	//productRequest.jsp에 들어갈 데이터
	List<Request> selectAllRequest(int cPage,int numPerPage,String requestStatus);
	int selectAllRequestCount(String requestStatus);
	
	//productRequest 세부 데이터 보여주는 작은창
	Request selectOneRequest(int no);
	int requestStatusUpdate(Map<String,Object> map);
	
	//admin밑에 member밑에 memberList.jsp에 들어갈 거
	List<Member> selectAllMember(int cPage,int numPerPage,MemberSearch ms);
	int selectAllMemberCount(MemberSearch ms);
	int updateMemberStatus(String memberId);
}
