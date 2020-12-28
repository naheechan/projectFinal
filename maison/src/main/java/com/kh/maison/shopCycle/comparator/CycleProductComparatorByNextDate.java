package com.kh.maison.shopCycle.comparator;

import java.util.Comparator;

import com.kh.maison.shopCycle.model.vo.CycleProduct;

public class CycleProductComparatorByNextDate implements Comparator<CycleProduct> {

	@Override
	public int compare(CycleProduct o1, CycleProduct o2) {
		
		Long num1 = new Long(o1.getNextDate());
		Long num2 = new Long(o2.getNextDate());
		
		return num1.compareTo(num2); 
	}

	
	

}
