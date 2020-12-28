package com.kh.maison.shopCycle.comparator;

import java.util.Comparator;

import com.kh.maison.shopCycle.model.vo.CycleProduct;

public class CycleProductComparatorByDay implements Comparator<CycleProduct> {

	@Override
	public int compare(CycleProduct o1, CycleProduct o2) {
		
		Integer num1 = new Integer(o1.getDay());
		Integer num2 = new Integer(o2.getDay());
		
		return num1.compareTo(num2); 
	}

	
	

}
