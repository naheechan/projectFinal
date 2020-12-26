package com.kh.maison.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

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

public interface AdminDao {
	
	//productStock.jsp 첫번째 div데이터 가져오기 
	int selectFirstTotal(SqlSessionTemplate session,int numDate);
	int selectFirstChange(SqlSessionTemplate session,int numDate);
	int selectFirstIn(SqlSessionTemplate session,int numDate);
	int selectFirstOut(SqlSessionTemplate session,int numDate);
	
	//productStock.jsp 두번째 div데이터가져오기
	int selectSecondChange(SqlSessionTemplate session,int sendNum);
	int selectSecondIn(SqlSessionTemplate session,int sendNum);
	int selectSecondOut(SqlSessionTemplate session,int sendNum);
	
	//productStock.jsp 세번째 div데이터 가져오기
	List<ProductStock> bringThirdList(SqlSessionTemplate session,int cPage,int numPerPage);
	int bringThirdCount(SqlSessionTemplate session);
	
	//productRequest.jsp 데이터 가져오기
	List<Request> selectAllRequest(SqlSessionTemplate session,int cPage,int numPerPage,String requestStatus);
	int selectAllRequestCount(SqlSessionTemplate session,String requestStatus);
	
	//productRequest view 보기
	Request selectOneRequest(SqlSessionTemplate session,int no);
	int requestStatusUpdate(SqlSessionTemplate session, Map<String,Object> map);
	
	//admin/member/memberList.jsp에 데이터 불러오기
	List<Member> selectAllMember(SqlSessionTemplate session,int cPage,int numPerPage,MemberSearch ms);
	int selectAllMemberCount(SqlSessionTemplate session,MemberSearch ms);
	int updateMemberStatus(SqlSessionTemplate session,String memberId);
	
	//admin/member/deletedMemberList.jsp
	List<MemberWithdraw> deletedMemberList(SqlSessionTemplate session,int cPage,int numPerPage,MemberSearch ms);
	int deletedMemberListCount(SqlSessionTemplate session,MemberSearch ms);
	//회원무덤 테이블에 insert하기 
	int insertMemberWithdraw(SqlSessionTemplate session,String memberId);
	
	//admin/member/membership.jsp
	List<Map<String,Object>> selectAllMemberShip(SqlSessionTemplate session, int cPage, int numPerPage);
	int selectAllMemberShipCount(SqlSessionTemplate session);
	int selectDefaultMileage(SqlSessionTemplate session);
	int updateDefaultMileage1(SqlSessionTemplate session,Mileage mi);
	int updateDefaultMileage2(SqlSessionTemplate session,Mileage mi);

	Grade selectOneMembership(SqlSessionTemplate session,String gradecode);
	int updateMembership(SqlSessionTemplate session,Grade g);
	
	List<WithBoard> selectAllWithBoard(SqlSessionTemplate session,WithSearch ws);
	int selectAllWithBoardCount(SqlSessionTemplate session, WithSearch ws);
	
	List<WithComment> selectAllWithComment(SqlSessionTemplate session,MemberSearch ms);
	int selectAllWithCommentCount(SqlSessionTemplate session, MemberSearch ms);
	
	List<Map<String,Object>> selectAllWithReport(SqlSessionTemplate session,WithSearch ws);
	int selectAllWithReportCount(SqlSessionTemplate session, WithSearch ws);
}
