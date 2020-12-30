package com.kh.maison.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.admin.model.vo.MemberSearch;
import com.kh.maison.admin.model.vo.MemberWithdraw;
import com.kh.maison.admin.model.vo.ProductStock;
import com.kh.maison.admin.model.vo.WithSearch;
import com.kh.maison.member.model.vo.Grade;
import com.kh.maison.member.model.vo.Member;

import com.kh.maison.mileage.model.vo.Mileage;

import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.shop.model.vo.Request;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public int selectFirstTotal(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectFirstTotal",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectFirstTotal",numDate);
		}
	}

	@Override
	public int selectFirstChange(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectFirstChange",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectFirstChange",numDate);
		}
	}

	@Override
	public int selectFirstIn(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectFirstIn",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectFirstIn",numDate);
		}
	}

	@Override
	public int selectFirstOut(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectFirstOut",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectFirstOut",numDate);
		}
	}

	@Override
	public int selectSecondChange(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondChange",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondChange",sendNum);		
		}
	}

	@Override
	public int selectSecondIn(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondIn",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondIn",sendNum);			
		}
	}

	@Override
	public int selectSecondOut(SqlSessionTemplate session, int sendNum) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectSecondOut",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectSecondOut",sendNum);
		}
	}

	@Override
	public List<ProductStock> bringThirdList(SqlSessionTemplate session, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectThirdList",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int bringThirdCount(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectThirdCount");
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectThirdCount");		
		}
	}

	@Override
	public List<Request> selectAllRequest(SqlSessionTemplate session, int cPage, int numPerPage, String requestStatus) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllRequest",requestStatus,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectAllRequestCount(SqlSessionTemplate session, String requestStatus) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllRequestCount",requestStatus);
	}

	@Override
	public Request selectOneRequest(SqlSessionTemplate session, int no) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOneRequest",no);
	}

	@Override
	public int requestStatusUpdate(SqlSessionTemplate session, Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.update("admin.requestStatusUpdate",map);
	}

	@Override
	public List<Member> selectAllMember(SqlSessionTemplate session, int cPage, int numPerPage,
			MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllMember",ms,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectAllMemberCount(SqlSessionTemplate session, MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllMemberCount",ms);
	}

	@Override
	public int updateMemberStatus(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.update("admin.updateMemberStatus",memberId);
	}

	@Override
	public List<MemberWithdraw> deletedMemberList(SqlSessionTemplate session, int cPage, int numPerPage,MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectList("admin.deletedMemberList",ms,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int deletedMemberListCount(SqlSessionTemplate session,MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.deletedMemberListCount",ms);
	}

	@Override
	public List<Map<String, Object>> selectAllMemberShip(SqlSessionTemplate session,int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllMemberShip",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int insertMemberWithdraw(SqlSessionTemplate session, String memberId) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertMemberWithdraw",memberId);
	}

	@Override
	public int selectDefaultMileage(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectDefaultMileage");
	}

	@Override
	public int selectAllMemberShipCount(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllMembershipCount");
	}

	@Override
	public int updateDefaultMileage1(SqlSessionTemplate session, Mileage mi) {
		// TODO Auto-generated method stub
		return session.update("admin.updateDefaultMileageOne",mi);
	}

	@Override
	public int updateDefaultMileage2(SqlSessionTemplate session, Mileage mi) {
		// TODO Auto-generated method stub
		return session.update("admin.updateDefaultMileageTwo",mi);
	}

	@Override
	public Grade selectOneMembership(SqlSessionTemplate session, String gradecode) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOneMembership",gradecode);
	}

	@Override
	public int updateMembership(SqlSessionTemplate session, Grade g) {
		// TODO Auto-generated method stub
		return session.update("admin.updateMembership",g);
	}

	@Override
	public List<WithBoard> selectAllWithBoard(SqlSessionTemplate session, WithSearch ws) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllWithBoard",ws);
	}

	@Override
	public int selectAllWithBoardCount(SqlSessionTemplate session, WithSearch ws) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllWithBoardCount",ws);
	}

	@Override
	public List<WithComment> selectAllWithComment(SqlSessionTemplate session, MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllWithComment",ms);
	}

	@Override
	public int selectAllWithCommentCount(SqlSessionTemplate session, MemberSearch ms) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllWithCommentCount",ms);
	}

	@Override
	public List<Map<String,Object>> selectAllWithReport(SqlSessionTemplate session, WithSearch ws) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectAllWithReport",ws);
	}

	@Override
	public int selectAllWithReportCount(SqlSessionTemplate session, WithSearch ws) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectAllWithReportCount",ws);
	}

	public int selectTotalPrice(SqlSessionTemplate session, int numDate) {
		// TODO Auto-generated method stub
		Integer result = session.selectOne("admin.selectTotalPrice",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectTotalPrice",numDate);
		}
	}

	@Override
	public int selectPriceChange(SqlSessionTemplate session, int numDate) {
		Integer result = session.selectOne("admin.selectPriceChange",numDate);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectPriceChange",numDate);
		}
	}

	@Override
	public int selectDayTotal(SqlSessionTemplate session, int sendNum) {
		Integer result = session.selectOne("admin.selectDayTotal",sendNum);
		if(result==null) {
			return 0;
		}else {
			return session.selectOne("admin.selectDayTotal",sendNum);
		}
	}

	@Override
	public List<OrderDetail> selectSalesList(SqlSessionTemplate session, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectSalesList",null,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectTotalCount(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectTotalCount");
	}

	@Override
	public int countMyRequest(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.countMyRequest",param);
	}
	
	

}
