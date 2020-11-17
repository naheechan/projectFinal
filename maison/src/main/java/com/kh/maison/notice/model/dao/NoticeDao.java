package com.kh.maison.notice.model.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.maison.notice.model.vo.Notice;

public interface NoticeDao {

	
	
	public List<Notice> selectNoticeList();
}
