package com.kh.maison.shop.model.service;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.shop.model.dao.ShopDao;
import com.kh.maison.shop.model.vo.Request;
@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDao dao; 
	@Autowired
	private SqlSession session;
	
	
	@Override
	public List<Product> selectProduct(int cPage, int numPerPage) {
		return dao.selectProduct(session,cPage,numPerPage);
	}

	
	@Override
	public int selectCount() {
		return dao.selectCount(session);
	}


	@Override
	public List<Category> selectCategory() {
		return dao.selectCategory(session);
	}

	@Override
	public List<Category> selectMediCate() {
		return dao.selectMediCate(session);
	}

	@Override
	public int insertRequestProduct(String requestContent) {
		int result = dao.insertRequestProduct(session,requestContent);
		return result;
	}

}
