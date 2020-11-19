package com.kh.maison.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeService {

	
	public List<Notice> selectNoticeList(int cPage,int numPerPage);
	public int selectCount();
	public int insertNotice(Map param);
	Notice selectNoticeOne(int noticeNo);
}
