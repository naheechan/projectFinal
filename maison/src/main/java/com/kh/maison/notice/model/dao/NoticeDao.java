package com.kh.maison.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeDao {
	
	List<Notice> selectNoticeList(SqlSessionTemplate session, int cPage, int numPerPage);
	int selectCount(SqlSessionTemplate session);
	int insertNotice(SqlSessionTemplate session,Map<String,String> param);
	Notice selectNoticeOne(SqlSessionTemplate session,int noticeNo);
	int deleteNotice(SqlSessionTemplate session,int noticeNo);
	int updateNotice(SqlSessionTemplate session,Map<String,String> param);
}
