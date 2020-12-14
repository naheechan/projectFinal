package com.kh.maison.common.captcha;

import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.captcha.Captcha;
import nl.captcha.audio.AudioCaptcha;
import nl.captcha.backgrounds.BackgroundProducer;
import nl.captcha.backgrounds.FlatColorBackgroundProducer;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.backgrounds.SquigglesBackgroundProducer;
import nl.captcha.backgrounds.TransparentBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.NumbersAnswerProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;

public class CaptchaUtil {
	
	// 보안문자 이미지 가로, 세로크기
	private static int width = 150;
	private static int height = 50;

	//Captcha image 생성
	public void getImgCaptCha(HttpServletRequest req, HttpServletResponse res) {
		//폰트 및 컬러 설정
		List<Font> fontList = new ArrayList<Font>(); 
		fontList.add(new Font("", Font.HANGING_BASELINE, 40)); 
		fontList.add(new Font("Courier", Font.ITALIC, 40)); 
		fontList.add(new Font("", Font.PLAIN, 40)); 
		List<Color> colorList = new ArrayList<Color>(); 
		colorList.add(Color.BLACK);
		colorList.add(Color.CYAN);
		colorList.add(Color.PINK);
		colorList.add(Color.RED);
		colorList.add(Color.ORANGE);
		colorList.add(Color.YELLOW);
		colorList.add(Color.GREEN);
		colorList.add(Color.BLUE);
		//배경 배열 설정 
		List<BackgroundProducer> backList = new ArrayList<BackgroundProducer>();
		backList.add(new TransparentBackgroundProducer());
		backList.add(new FlatColorBackgroundProducer());
		backList.add(new GradiatedBackgroundProducer());
		backList.add(new SquigglesBackgroundProducer());
		
		Captcha captcha = new Captcha.Builder(width, height)
				//.addText() 또는 아래와 같이 정의. 6자리 숫자와 폰트 및 컬러 설정
				.addText(new NumbersAnswerProducer(6),new DefaultWordRenderer(colorList,fontList))
				.addNoise().addBorder()
				.addBackground(backList.get((int)(Math.random()*(backList.size()))))
				.build();
		// JSP에서 Captcha 객체에 접근할 수 있도록 session에 저장
		req.getSession().setAttribute(Captcha.NAME, captcha);
		CaptchaServletUtil.writeImage(res, captcha.getImage());

	}
	
	//CaptCha Audio 생성
	public void getAudioCaptCha(HttpServletRequest req, HttpServletResponse res, String answer) throws IOException{
		HttpSession session = req.getSession();
		Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
		String getAnswer = answer;
		if(getAnswer == null || getAnswer.equals("")) getAnswer = captcha.getAnswer();
		AudioCaptcha audiocaptcha = new AudioCaptcha.Builder()
					.addAnswer(new SetTextProducer(getAnswer))
					.addNoise()
					.build();
		CaptchaServletUtil.writeAudio(res, audiocaptcha.getChallenge());
	}
}
