package com.kh.maison.notice.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.notice.model.dao.NoticeDao;
import com.kh.maison.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private NoticeDao dao;

	@Override
	public List<Notice> selectNoticeList(int cPage,int numPerPage) {

		List<Notice> list=dao.selectNoticeList(session,cPage,numPerPage);
		
		return list;
	}

	@Override
	public int selectCount() {

		int count=dao.selectCount(session);
		
		return count;
	}

	@Override
	public int insertNotice(Map param) {
		// TODO Auto-generated method stub
		return dao.insertNotice(session,param);
	}

	@Override
	public Notice selectNoticeOne(int noticeNo) {
		// TODO Auto-generated method stub
		return dao.selectNoticeOne(session,noticeNo);
	}
	
	
}
