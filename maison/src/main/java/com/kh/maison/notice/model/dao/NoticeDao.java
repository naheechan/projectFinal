package com.kh.maison.notice.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeDao {

	
	
	public List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage);
}
