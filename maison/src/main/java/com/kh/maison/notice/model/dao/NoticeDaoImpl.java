package com.kh.maison.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.maison.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Override
	public List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return session.selectList("notice.selectNoticeList",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectCount(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectOne("notice.selectCount");
	}

	@Override
	public int insertNotice(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.insert("notice.insertNotice",param);
	}

	@Override
	public Notice selectNoticeOne(SqlSessionTemplate session, int noticeNo) {
		// TODO Auto-generated method stub
		return session.selectOne("notice.selectNoticeOne",noticeNo);
	}

	@Override
	public int deleteNotice(SqlSessionTemplate session, int noticeNo) {
		// TODO Auto-generated method stub
		return session.update("notice.deleteNotice",noticeNo);
	}

	@Override
	public int updateNotice(SqlSessionTemplate session, Map<String, String> param) {
		// TODO Auto-generated method stub
		return session.update("notice.updateNotice",param);
	}

	@Override
	public int updateCount(SqlSessionTemplate session, int noticeNo) {
		// TODO Auto-generated method stub
		return session.update("notice.updateCount",noticeNo);
	}

	@Override
	public List<Notice> selectNoticeListSearch(SqlSessionTemplate session, int cPage, int numPerPage, Map param) {
		// TODO Auto-generated method stub
		return session.selectList("notice.selectNoticeListSearch",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int countSearch(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("notice.countSearch",param);
	}

	
	
	
}
