package com.kh.maison.notice.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeService {

	
	List<Notice> selectNoticeList(int cPage,int numPerPage);
	int selectCount();
	int insertNotice(Map<String,String> param);
	Notice selectNoticeOne(int noticeNo);
	int deleteNotice(int noticeNo);
	int updateNotice(Map<String,String> param);
	int updateCount(int noticeNo);
	List<Notice> selectNoticeListSearch(int cPage,int numPerPage,Map param);
	int countSearch(Map param);
}
