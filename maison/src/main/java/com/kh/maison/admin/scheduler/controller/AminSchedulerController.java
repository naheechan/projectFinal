package com.kh.maison.admin.scheduler.controller;

import org.springframework.scheduling.annotation.Scheduled;

public class AminSchedulerController {

	@Scheduled(cron="0 24 22 * * *")
	public void autoUpdate() {
		System.out.println("오후 9시 46분에 호출됩니다.");
	}
}
