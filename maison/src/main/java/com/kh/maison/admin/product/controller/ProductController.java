package com.kh.maison.admin.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductController {

	@RequestMapping("/admin/product/productEnroll.do")
	public String moveEnroll() {
		return "admin/product/productEnroll";
	}
	
}
