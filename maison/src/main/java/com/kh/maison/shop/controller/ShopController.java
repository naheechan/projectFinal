package com.kh.maison.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShopController {

	@RequestMapping("/shop/shopView.do")
	public String moveShopView() {
		return "shop/shopView";
	}
}
