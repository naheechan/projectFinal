package com.kh.maison.memberMypage.inquiry.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.maison.member.model.vo.Member;
import com.kh.maison.memberMypage.inquiry.vo.TotalInquiryList;
import com.kh.maison.shop.model.vo.InquiryReply;

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
	public int selectDellCount(SqlSession session, Member id) {
		return  session.selectOne("myMemInquiry.selectDelCount",id);
	}

	@Override
	public List<TotalInquiryList> searchkeyword(SqlSession session, Map<String,Object> param) {
		return session.selectList("myMemInquiry.searchkeyword",param);
	}

	@Override
	public List<TotalInquiryList> searchList(SqlSession session, String searchType, String keyword, String id,
			int cPage, int numPerPage) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		map.put("id",id);
		
		return session.selectList("myMemInquiry.searchList",map,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectListCount(SqlSession session, String id) {
		return session.selectOne("myMemInquiry.selectListCount",id);
	}

	@Override
	public int searchCount(SqlSession session, String searchType, String keyword, String id) {
		Map<String,Object> param = new HashMap<>();
		param.put("searchType",searchType);
		param.put("keyword",keyword);
		param.put("id",id);
		
		return session.selectOne("myMemInquiry.searchCount",param);
	}

	@Override
	public List<TotalInquiryList> selectMyList(SqlSession session, String id, int cPage, int numPerPage) {
		return session.selectList("myMemInquiry.selectMyList",id,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public List<TotalInquiryList> replySuccess(SqlSession session, String id, int cPage, int numPerPage) {
		return session.selectList("myMemInquiry.replySuccess",id,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectSuccessCount(SqlSession session, String id) {
		return session.selectOne("myMemInquiry.selectSuccessCount",id);
	}

	@Override
	public List<TotalInquiryList> replyYet(SqlSession session, String id, int cPage, int numPerPage) {
		return session.selectList("myMemInquiry.replyYet",id,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectYetCount(SqlSession session, String id) {
		return session.selectOne("myMemInquiry.selectYetCount",id);
	}

	@Override
	public List<TotalInquiryList> replydel(SqlSession session, String id, int cPage, int numPerPage) {
		return session.selectList("myMemInquiry.replydel",id,
				new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectDelCount(SqlSession session, String id) {
		return session.selectOne("myMemInquiry.selectDelCount",id);
	}

	@Override
	public int deleteIq(SqlSession session, String no,String id) {
		Map<String,Object> map = new HashMap<>();
		map.put("no",no);
		map.put("id",id);
		return session.update("myMemInquiry.deleteIq",map);
	}

	@Override
	public int deleteRep(SqlSession session, String no) {
		return session.delete("myMemInquiry.deleteRep",no);
	}

	@Override
	public int updateInq(SqlSession session, Map<String, Object> map) {
		return session.update("myMemInquiry.updateInq",map);
	}

	@Override
	public List<InquiryReply> selectReplyOne(SqlSession session,String no) {
		return session.selectList("myMemInquiry.selectReplyOne",no);
	}

	
	
	
}
