package com.kh.maison.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeDao {
	
	List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage);
	int selectCount(SqlSessionTemplate session);
	int insertNotice(SqlSessionTemplate session,Map param);
	Notice selectNoticeOne(SqlSessionTemplate session,int noticeNo);
}
