package com.kh.maison.with.model.service;

import java.util.List;

import com.kh.maison.with.model.vo.WithBoard;

public interface WithBoardService {
	
	int insertWith(WithBoard wb);
	
	List<WithBoard> selectAllWith(int cPage,int numPerPage);

	int selectWithCount();
}
