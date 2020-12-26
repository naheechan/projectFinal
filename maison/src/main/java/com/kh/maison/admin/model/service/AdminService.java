package com.kh.maison.admin.model.service;

import java.util.List;
import java.util.Map;

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
	
	//admin > member > deletedMemberList.jsp에 들어갈거
	List<MemberWithdraw> deletedMemberList(int cPage,int numPerPage,MemberSearch ms);
	int deletedMemberListCount(MemberSearch ms);
	//회원무덤테이블에 insert하기
	int insertMemberWithdraw(String memberId);
	
	//admin>member>memberShip.jsp 에 들어갈거
	List<Map<String,Object>> selectAllMemberShip(int cPage, int numPerPage);
	int selectAllMemberShipCount();
	//마일리지 기본값 가져오기
	int selectDefaultMileage();
	//마일리지 기본값 업데이트하기 2개
	int updateDefaultMileage1(Mileage mi);
	int updateDefaultMileage2(Mileage mi);
	
	//마일리지 업데이트 하기 
	Grade selectOneMembership(String gradecode);
	
	//grade내용 업데이트 하기 
	int updateMemership(Grade g);
	
	//함께해요 관련된 애들 
	List<WithBoard> selectAllWithBoard(WithSearch ws);
	int selectAllWithBoardCount(WithSearch ws);
	
	List<WithComment> selectAllWithComment(MemberSearch ms);
	int selectAllWithCommentCount(MemberSearch ms);
	
	List<Map<String,Object>> selectAllWithReport(WithSearch ws);
	int selectAllWithReportCount(WithSearch ws);
	
}
