package com.kh.maison.memberMypage.inquiry.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;

@Repository
public class InquiryMyMemberDaoImpl implements InquiryMyMemberDao {

	@Override
	public List<TotalInquiryList> selectTotalList(SqlSession session, int cPage, int numPerPage, Member id) {
		return session.selectList("myMemInquiry.selectTotalList",id,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectTotalCount(SqlSession session, Member id) {
		return session.selectOne("myMemInquiry.selectTotalCount",id);
	}

	@Override
	public int selectCheckCount(SqlSession session, Member id) {
		return session.selectOne("myMemInquiry.selectCheckCount",id);
	}

	@Override
	public int selectNoCheckCount(SqlSession session, Member id) {
		return  session.selectOne("myMemInquiry.selectNoCheckCount",id);
	}

	@Override
	public int selectDelCount(SqlSession session, Member id) {
		return  session.selectOne("myMemInquiry.selectDelCount",id);
	}

	@Override
	public List<TotalInquiryList> searchkeyword(SqlSession session, Map<String,Object> param) {
		return session.selectList("myMemInquiry.searchkeyword",param);
	}

	
}
