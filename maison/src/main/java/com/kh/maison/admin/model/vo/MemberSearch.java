package com.kh.maison.admin.model.vo;

import lombok.Data;

@Data
public class MemberSearch {
	private String type;
	private String keyword;
	private String memberSocial;
	private String emailStatus;
	private String memberLevel;
}
