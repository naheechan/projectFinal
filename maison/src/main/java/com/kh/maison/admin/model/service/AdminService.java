package com.kh.maison.admin.model.service;

public interface AdminService {
	
	//productStock.jsp 첫번째 div에 들어갈 값들 가져오는 메소드
	int selectFirstTotal(int numDate);
	int selectFirstChange(int numDate);
	int selectFirstIn(int numDate);
	int selectFirstOut(int numDate);
	
	//productStock.jsp 두번째 div에 들어갈 값들 가져오는 메소드 
	int selectSecondChange(int sendNum);
	int selectSecondIn(int sendNum);
	int selectSecondOut(int sendNum);
}
