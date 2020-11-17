package com.kh.maison.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.notice.model.dao.NoticeDao;
import com.kh.maison.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao dao;

	@Override
	public List<Notice> selectNoticeList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
