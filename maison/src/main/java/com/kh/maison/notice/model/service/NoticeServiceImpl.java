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
		Notice n=dao.selectNoticeOne(session,noticeNo);
		/*
		 * if(!hasRead&&n!=null) { int result=dao.updateCount(session,noticeNo);
		 * if(result==0) {
		 * 
		 * } }
		 */
		
		return n;
	}

	
	@Override
	public int updateCount(int noticeNo) {
		// TODO Auto-generated method stub
		return dao.updateCount(session, noticeNo);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		// TODO Auto-generated method stub
		return dao.deleteNotice(session,noticeNo);
	}

	@Override
	public int updateNotice(Map<String, String> param) {
		// TODO Auto-generated method stub
		return dao.updateNotice(session,param);
	}

	
	
	
}
