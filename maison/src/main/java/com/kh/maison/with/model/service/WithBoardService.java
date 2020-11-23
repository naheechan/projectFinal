package com.kh.maison.with.model.service;

import java.util.List;

import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;

public interface WithBoardService {
	
	int insertWith(WithBoard wb);
	
	List<WithBoard> selectAllWith(int cPage,int numPerPage);

	int selectWithCount();
	
	WithBoard selectOneWith(int no);
	
	int insertWithReply(WithComment comment);
	
	List<WithComment> selectAllWithReply(int bno);
	
	int insertWithReplySecond(WithComment comment);
}
