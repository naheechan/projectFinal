package com.kh.maison.notice.model.dao;

import java.util.List;

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

}
