package com.kh.maison.common.email;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.kh.maison.shop.vo.Product;

@Service
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int size;
	private String path = "http://rclass.iptime.org:9999/20AM_MAISON_final";
	private String header1 = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n" + 
			"<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n" + 
			" <head>\r\n" + 
			"    <title>이메일 고지</title>\r\n" + 
			"    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n" + 
			"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n" + 
			"    \r\n" + 
			"  </head>\r\n" + 
			"  <body style=\"height: 100%; padding: 0; margin: 0; width: 100%;\">\r\n" + 
			"    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" id=\"container\" style=\"border-collapse: collapse; margin: auto; text-align: center; padding: 30px 0 30px 0; width: 100%; background-color: #F2BB9C; box-sizing: border-box;\" bgcolor=\"#F2BB9C\" align=\"center\">\r\n" + 
			"        <tr>\r\n" + 
			"            <td style=\"border-collapse: collapse;\">\r\n" + 
			"                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"800\" class=\"containerTable\" \"=\"\" style=\"border-collapse: collapse; margin: auto; text-align: center; background-color: white;\" align=\"center\" bgcolor=\"white\">\r\n" + 
			"                    <tr>\r\n" + 
			"                        <td style=\"border-collapse: collapse;\">\r\n" + 
			"                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"headTable\" \"=\"\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
			"                                <tr>\r\n" + 
			"                                    <td style=\"border-collapse: collapse;\">\r\n" + 
			"                                        <!-- 로고 이미지(글자이미지)-->\r\n" + 
			"                                        <a href=\"" +
			path +
			"\" target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n" + 
			"                                            <img src=\"https://postfiles.pstatic.net/MjAyMDEyMjRfMzEg/MDAxNjA4NzczNjEwOTQ0.F87B3NiNoH5aWi89GbtsleKT8mPBr0nUzW_maEtGxCcg.9VLhctvjNxpYpl2NcZI9OZLABBDSRaUnC8CKKFkZ2mYg.PNG.nhchihi/textLogo.PNG?type=w773\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n" + 
			"                                        </a>\r\n" + 
			"                                    </td>\r\n" + 
			"                                </tr>\r\n" + 
			"                                <tr>\r\n" + 
			"                                    <td class=\"subTitle\" style=\"border-collapse: collapse; font-size: 25px; font-weight: bold; padding: 0 0 20px 0;\">\r\n";
	
	private String header2 = "                                    </td>\r\n" + 
			"                                </tr>\r\n" + 
			"                            </table>\r\n";
	
	private String footer = "                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"footerTable\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
			"                                <tr>\r\n" + 
			"                                    <td class=\"footer\" style=\"border-collapse: collapse; padding: 100px 0 50px 0;\">\r\n" + 
			"                                        <a href=\""+
			path +
			"\" target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n" + 
			"                                            <img src=\"https://postfiles.pstatic.net/MjAyMDEyMTlfMzAg/MDAxNjA4Mzg3MDk5NzI3.aIIMwG_iLClsj6bO9_O_QQZKAyhC9msQHZfvP6FZJ0Ag.d0f-FKVaj5QAbRfOV5r92aAzmjWYysh22HNWbAdwQOgg.PNG.nhchihi/logo.png?type=w773\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n" + 
			"                                        </a>\r\n" + 
			"                                    </td>\r\n" + 
			"                                    <td style=\"border-collapse: collapse;\">\r\n" + 
			"                                        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"500\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
			"                                            <tr>\r\n" + 
			"                                                <td class=\"footerText\" style=\"border-collapse: collapse; font-size: 15px; color: #8C8C8C; text-align: start;\" align=\"start\">\r\n" + 
			"                                                    cal. 000-0000-0000\r\n" + 
			"                                                </td>\r\n" + 
			"                                            </tr>\r\n" + 
			"                                            <tr>\r\n" + 
			"                                                <td class=\"footerText\" style=\"border-collapse: collapse; font-size: 15px; color: #8C8C8C; text-align: start;\" align=\"start\">\r\n" + 
			"                                                    Copyright © MAISON 2020 All Rights Reserved.\r\n" + 
			"                                                </td>\r\n" + 
			"                                            </tr>\r\n" + 
			"                                        </table>\r\n" + 
			"                                    </td>\r\n" + 
			"                                </tr>\r\n" + 
			"                            </table>\r\n" + 
			"                        </td>\r\n" + 
			"                    </tr>\r\n" + 
			"                </table>\r\n" + 
			"            </td>\r\n" + 
			"        </tr>\r\n" + 
			"    </table>  \r\n" + 
			"  </body>\r\n" + 
			"</html>";
			
	private String getKey(int size) {
		this.size = size;
		return getAuthCode();
	}
	
	private String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length()<size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		return buffer.toString();
	}
	
	private String getProductImgPath(int productNo) {
		String imgPath = "";
		switch(productNo) {
		//case 1: imgPath=""; break;
		case 1: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfNzMg/MDAxNjA5Mjg3NzU4MjE3._ta0WX4ZDdLu-pk55Gquc6APOwcAA9Z6KxsoRtoHFrUg.849i10PULPNk2PN_hcDdw-IShsB_n-s3xCwjm1IJHuAg.PNG.nhchihi/a24.png?type=w773"; break;
		case 3: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfOTgg/MDAxNjA5MjYwNDkxNTIw.iINRi-mzeR6nwQq_uRaGaRRQy4bnlo-An-f7lNDCFOgg.MYmMYErqX8yTIQvsBDHyK-qKTrUqT7kf0creND37wi4g.PNG.nhchihi/zz1.png?type=w773"; break;
		case 4: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTQ0/MDAxNjA5Mjg3NzkxNjMw.-nD1tZkDMtFvxLBzd0yNmvUAI_1JgD3Dccg5_YnkjSAg.Om3qdQR6cZW7FZM_ggoljOD9qrtTR5Q662cSZZlL588g.PNG.nhchihi/a25.png?type=w773"; break;
		case 5: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjU2/MDAxNjA5Mjg3ODA5Njcx.d0JBXjY5wRsYkn_qlT3LBvSXyt7d_9fSqNy5R0jYsyog.EATt4TkFSYobVYWQVTu-yqk7gWYuorQqEhssnjz6OzIg.PNG.nhchihi/a26.png?type=w773"; break;
		case 6: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTM4/MDAxNjA5Mjg3ODIzMTEy.ZIg_chZOvnTrmT88_G2HV5DN5eMmO2__DksUmIZiAQAg.rP0BgkwvV4O5TbHeYuD-HrsWVZGGlgDLJpPP6KkRPiQg.PNG.nhchihi/a27.png?type=w773"; break;
		case 7: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTg5/MDAxNjA5MjYxMTI5Mzk1.bgz1vjfBCN5VYk4vJfAKkkGF-FqB2GFxFdk_uzQrKFIg.HYEebjmM_O77wWksgiTL5En79gcSU7cfR3n5Kpz9q58g.PNG.nhchihi/a11.png?type=w773"; break;
		case 8: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTYx/MDAxNjA5MjYxMTk4MjY4.fRqKGPnWSmvhDP-6-jABhC0H6_MV2vjd3IUErmOT1xUg.iPF31genQo-H2ggTs8O_ciVvOMmCiqEETEvx6HW1j4Ag.PNG.nhchihi/a12.png?type=w773"; break;
		case 18: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjcz/MDAxNjA5MjYxMjEyOTYy.HySww3yaM9hCvgKwlnB6pELRt-2vLyNTdDHBPANiDNEg.LeZ_EFe4H_vh-omSCexrSASXemfb0NQh-FCYCXFphXog.PNG.nhchihi/a13.png?type=w773"; break;
		case 19: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjEx/MDAxNjA5MjYxMjI1NTA3.cEdBFc80Nmt6ZUhHhmisMg1VZ4NEgkRfjVK5-faNobYg.S97Ndx42zhSBekmmHU-ZwAhT7ND1ZJysQaqM32F5bq0g.PNG.nhchihi/a14.png?type=w773"; break;
		case 20: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjMz/MDAxNjA5MjYxMjQ2MzU5.3GW00uJTow68oCG3cpQWgpNNzfQI5KGmSPntEFI_4_wg.MC-7z1LuVMAdjCZlE_uOxy50H3z6d4lzlFrZwK5Ljc8g.PNG.nhchihi/a15.png?type=w773"; break;
		case 21: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfOTIg/MDAxNjA5Mjg3ODMyMjUx.2QtJ2DbBaE_-B7MdlrVD_znvi8L_Bx7RuBgyj8_jcnAg.s4ap8BaXA58P4kXMYCnFkNKWc2HTkDhP2zcrTSSJgfMg.PNG.nhchihi/a28.png?type=w773"; break;
		case 22: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfNjYg/MDAxNjA5MjYxMjgwODI3.zNbcss6P7Om6hFQeWk99xGoc29e7oBXkefspLHHJKCwg.EEFAyjmNpX64twLuaPMxz4KWp6bS0OYYHsPNpmJ4GdEg.PNG.nhchihi/a16.png?type=w773"; break;
		case 24: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTEx/MDAxNjA5MjYxMzcwMzkw.AnKMXor5QYenoFwBUxwiAgM3oLLt7lqu9cWz4ToHQbkg.ba92yoN2WdA9HrPxPUZTaTDWAsGebQnj6rDzFVPpvwMg.PNG.nhchihi/a18.png?type=w773"; break;
		case 26: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTY5/MDAxNjA5MjYxMzk1NTU0.huzcltOXwM34_Y9uX8BhZpqaXXuoR3tsXuu3iGgFSEMg.ICSdtC1INW8PcM_kkSgOJKWWrRPcVn24fMTfuBnUPOUg.PNG.nhchihi/a20.png?type=w773"; break;
		case 27: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjc2/MDAxNjA5MjYxMzUxMjc3.oFSgrpTrBgCUTvOEq8va8cju6oTybSWFNEIY8i_y3Rwg.YUt5_2vWwHFmfZY6WOuyxCWNsObFhlok-EDxQdPto30g.PNG.nhchihi/a17.png?type=w773"; break;
		case 28: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjA5/MDAxNjA5MjYxMzg0MDM1.HQ-hFABBbX3EGe-1SShhM-DU70jKKy4okvjLYHj3Pigg.TTwRaZcGexg5dr8ah6ckcxYb3OjwdCtCXxFNidiguscg.PNG.nhchihi/a19.png?type=w773"; break;
		case 29: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTky/MDAxNjA5MjYxNDExMDM2.nU153AszgnLDGeLOeUXFk2fnJeC6yqRtiXYGhag2oekg.U5p64jEDyNqPOziH-dVYykDV9azmTMDyM9X_oetjFI4g.PNG.nhchihi/a21.png?type=w773"; break;
		case 30: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjE0/MDAxNjA5MjYxNDI3NzY5.S2mJaQH82X97Whjv8SsIqtaLEhY5X00DljOVf3pKegkg.RvXElQaKGb-wifQZISl3qyrz4efByIqBcMCdqPgbzIog.PNG.nhchihi/a22.png?type=w773"; break;
		case 31: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTkw/MDAxNjA5MjYxNDQzMTM4.mhdKVvNDWSi1xI8SoKqXBuqjnwuaeEXRgoM4UmDxVY8g.ar_dH-1aHKQ6-et3YcyPNXlfJmjP3ojHOql_Jh69YRwg.PNG.nhchihi/a23.png?type=w773"; break;
		case 32 : imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjM3/MDAxNjA5MjYwNjA4OTQ3.0iuvuSX_v_qV53dDR19gP7ewjgBMF9zaBHepqrjSqi8g.JThTLyjt16ymRzmiLrID92rA1hN_l2xsZn0cdujaNbAg.JPEG.nhchihi/k0.jpg?type=w773"; break;
		case 33: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTU3/MDAxNjA5MjYwNjMwMjE2.aVt-CR4bEjfpp7c7FbQSoLbHaiRlSSHWQhMi0DaL6Kwg.RlXSHUwBFyVqC5TCN16QO5KvJ6Sni8_fuJCxo8v15ygg.JPEG.nhchihi/pril1.jpg?type=w773"; break;
		case 34: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfODIg/MDAxNjA5MjYwNjU2ODU3.018loed00Nwxmfh13ehqwojSD56VjMKT1gEBwUMOD0sg.C0H8tn4GBhVWNHa6S80s-VIaIPs8vRlizJjbduLP0XQg.JPEG.nhchihi/p1.jpg?type=w773"; break;
		case 35: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfOTUg/MDAxNjA5MjYwNjcwNTY2.RoC9K1j-lk7QpwlAwKUijpKSUuWR3-dWeTfrSqW8It4g.v006qqZBgtEZ7ZywNhIdxRvmYhproXEERBsOT3Dj80Yg.JPEG.nhchihi/c1.jpg?type=w773"; break;
		case 36: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTA3/MDAxNjA5MjYwNjg1Njk4.EX_6tt_4X-HziHJNcg640UZSNdnyHoRpzRhgosKVaAAg.rvcyROZzMTc_mhKJkzA0feumdpyo58D_JzaYvYqwumcg.JPEG.nhchihi/c2.jpg?type=w773"; break;
		case 37: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTU2/MDAxNjA5MjYwNzAxOTU4.w_w9NW3XAMWvAl5sBs0zbRPcuugro_ifI6XV4eApH-Ug.1JSjG0NsIQla8I6OT3GH7MT6hFVHd-ifIv43_f8_CNgg.JPEG.nhchihi/z1.jpg?type=w773"; break;
		case 38: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTUy/MDAxNjA5MjYwNzIzODQz.bel3J8yX6x1GyQeIvkmJo-706-4lMc9RdUoAKtf3Zs0g.5rnkiCzVprnJS5vA7PhyxrvBtfvQsNKBwMNKGBG-0hgg.JPEG.nhchihi/z2.jpg?type=w773"; break;
		case 39: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMjk4/MDAxNjA5MjYwNzQwNDMz.oF7FfAUYaoilasZE8M7KFHLb_ThAjnRTh4WmqJNJ1Z0g.L-ed8bY5u8Ytod4AcmBSy38VoEk6mhbgFdsT43Oamfog.JPEG.nhchihi/z3.jpg?type=w773"; break;
		case 40: imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfNzQg/MDAxNjA5MjYwNzU0MDg5.dB-glqvYy7WwUWAAfm4DiI5EK0Ry8FhSAo63cISE6H0g.yvEwcTpFcZXVHVmAhIShkr6LXRkDXM7VQl6OexgZkRAg.JPEG.nhchihi/z4.jpg?type=w773"; break;
		
		default : imgPath="https://postfiles.pstatic.net/MjAyMDEyMzBfMTcw/MDAxNjA5MjYxNTczNjI5.7WPOqYF87MkuvMOOg4rWxw-lqXhQ7P57YYOBojj_wiMg.yyNKZ5yZNA8qTqbvieGBM9xb-iG9p0cAn675wQYkFWkg.PNG.nhchihi/a0.png?type=w773"; 
		}	
		return imgPath;
	}

	public String sendAuthMail(String email, String memberId, String memberName) {
		String authKey = getKey(6);
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("MAISON 회원가입 이메일 인증");

			sendMail.setText(new StringBuffer()
						//헤더
							.append(header1)
							//본문 제목
							.append("[MAISON 이메일 인증]") 
							.append(header2)
						
						//section
							.append("                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"sectionTable\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
									"                                <tr>\r\n" + 
									"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n")
							.append("환영합니다 ")
							//받는 사람 이름
							.append(memberName)
							.append("                                        님\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
							"                                        저희 MAISON을 이용해주셔서 감사합니다.\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
							"                                        아래 버튼를 클릭하셔서 이메일 인증을 해주세요.\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" +
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 15px 0 0 0;;\">\r\n" + 
							"                                        <a class=\"authBtn\" style=\"border: 0; outline: none; text-decoration: none; background-color: #202B3F; color: white; padding: 0 20px 0 20px; cursor: pointer;\" href='")
							.append(path+"/?authId=")
							.append(memberId)
							.append("&authKey=")
							.append(authKey)
							.append("'\">\r\n" + 
							"    										이메일 인증 확인\r\n" + 
							"										 </a>" +
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" +
							"                            </table>\r\n")
						
						//footer
							.append(footer)
					.toString());
					sendMail.setForm("maisonRclass@gmail.com", "MAISON");
					sendMail.setTo(email);
					sendMail.send();
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return authKey;
	}
	
	public int sendFindIdMail(String email, String memberId) {
		int suc=0;
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("[MAISON 아이디 찾기]");
			sendMail.setText(new StringBuffer()
				//헤더
					.append(header1)
					//본문 제목
					.append("MAISON 아이디 찾기") 
					.append(header2)
				
				//section
					.append("                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"sectionTable\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n")
					.append("환영합니다 고객님" + 
					"                                    </td>\r\n" + 
					"                                </tr>\r\n" + 
					"                                <tr>\r\n" + 
					"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
					"                                        회원님의 아이디는\r\n" + 
					"                                    </td>\r\n" + 
					"                                </tr>\r\n" + 
					"                                <tr>\r\n" + 
					"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n") 
					.append(memberId+"입니다"+
					"                                    </td>\r\n" + 
					"                                </tr>\r\n" +
					"                            </table>\r\n")
					
				//footer
					.append(footer)
					.toString());
					sendMail.setForm("maisonRclass@gmail.com", "MAISON");
					sendMail.setTo(email);
					sendMail.send();
					suc=1;
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return suc;
	}
	
	public int sendFindPwMail(String email,String pwCheck) {
		int suc=0;
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("[MAISON 비밀번호 재설정]");
			sendMail.setText(new StringBuffer()
				//헤더
					.append(header1)
					//본문 제목
					.append("MAISON 비밀번호 재설정") 
					.append(header2)
				
				//section
					.append("                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"sectionTable\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n")
					.append("환영합니다 고객님" + 
					"                                    </td>\r\n" + 
					"                                </tr>\r\n" + 
					"                                <tr>\r\n" + 
					"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n") 
					.append("인증번호는 "+pwCheck+"입니다"+
					"                                    </td>\r\n" + 
					"                                </tr>\r\n" +
					"                            </table>\r\n")
					
				//footer
					.append(footer)
					.toString());
					sendMail.setForm("maisonRclass@gmail.com", "MAISON");
					sendMail.setTo(email);
					sendMail.send();
					suc=2;
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return suc;
	}
	
	public int sendCycleEmail(String email, String memberName, int productNo, String productName, List<Product> recommendList) {
		int result = 0;		
		//String sampleImg = getProductImgPath(productNo);
		try {
			MailUtils sendMail = new MailUtils(mailSender);
			sendMail.setSubject("[MAISON 쇼핑몰] "+productName+" 재구매 알림");
			sendMail.setText(new StringBuffer()
					//헤더
						.append(header1)
						//본문 제목
						.append("MAISON 이메일 인증") 
						.append(header2)
				
					//section
						.append("                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"sectionTable\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" )
							//받는 사람 이름
							.append(memberName)
							.append("                                        님 반갑습니다.\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
							"                                        항상 저희 MAISON을 이용해주셔서 감사합니다.\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
							"                                        고객님께서 지난번에 주문하셨던 ")
							.append(productName)
							.append(								"을(를) 거의 다 사용하시지 않았나요?\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"nomalText\" style=\"border-collapse: collapse; font-size: 17px; padding: 0 0 5px 0;\">\r\n" + 
							"                                        아래 상품을 클릭하시면 해당 제품으로 연결됩니다.\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"cycleProductImg\" style=\"border-collapse: collapse; padding: 50px 0 0 0;\">\r\n")
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//재구매 상품 번호
							.append(productNo)
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"300px\" height=\"300px\" src=\"")
							//재구매 상품 사진주소
							.append(getProductImgPath(productNo))
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"productName\" style=\"border-collapse: collapse; padding: 5px 0 50px 0; font-weight: bold; font-size: 17px;\">\r\n")
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//재구매 상품 번호
							.append(productNo)
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//재구매 상품 이름
							.append(productName)
							.append("</a>")
							.append("                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td class=\"recommendText\" style=\"border-collapse: collapse; font-size: 20px; font-weight: bold; padding: 100px 0 20px 0;\">\r\n" + 
							"                                        회원님께 추천드리는 상품\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                                <tr>\r\n" + 
							"                                    <td style=\"border-collapse: collapse;\">\r\n" + 
							"\r\n" + 
							"                                        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\" class=\"recommend\" style=\"border-collapse: collapse; margin: auto; text-align: center;\" align=\"center\">\r\n" + 
							"                                            <tr>\r\n" + 
							"                                                <td style=\"border-collapse: collapse;\">\r\n") 
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 1번째 번호
							.append(recommendList.get(0).getProductNo())
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"200px\" height=\"200px\" src=\"")
							//추천상품 1번째 사진주소
							.append(getProductImgPath(recommendList.get(0).getProductNo()))
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" + 
							"                                                <td style=\"border-collapse: collapse;\">\r\n") 
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 2번째 번호
							.append(recommendList.get(1).getProductNo())
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"200px\" height=\"200px\" src=\"")
							//추천상품 2번째 사진주소
							.append(getProductImgPath(recommendList.get(1).getProductNo()))
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" +
							"                                                <td style=\"border-collapse: collapse;\">\r\n") 
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 3번째 번호
							.append(recommendList.get(2).getProductNo())
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"200px\" height=\"200px\" src=\"")
							//추천상품 3번째 사진주소
							.append(getProductImgPath(recommendList.get(2).getProductNo()))
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" +
							"                                            </tr>\r\n" + 
							"                                            <tr>\r\n" + 
							
							"                                    <td class=\"productName\" style=\"border-collapse: collapse; padding: 5px 0 50px 0; font-weight: bold; font-size: 15px;\">\r\n")							
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 1번째 번호
							.append(recommendList.get(0).getProductNo())
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//추천상품 1번째 이름
							.append(recommendList.get(0).getProductName())
							.append("</a>")
							.append("                                    </td>\r\n" + 
							
							"                                    <td class=\"productName\" style=\"border-collapse: collapse; padding: 5px 0 50px 0; font-weight: bold; font-size: 15px;\">\r\n")							
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 2번째 번호
							.append(recommendList.get(1).getProductNo())
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//추천상품 2번째 이름
							.append(recommendList.get(1).getProductName())
							.append("</a>")
							.append("                                    </td>\r\n" +
							
							"                                    <td class=\"productName\" style=\"border-collapse: collapse; padding: 5px 0 50px 0; font-weight: bold; font-size: 15px;\">\r\n")							
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 3번째 번호
							.append(recommendList.get(2).getProductNo())
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//추천상품 3번째 이름
							.append(recommendList.get(2).getProductName())
							.append("</a>")
							.append("                                    </td>\r\n" +
							
							"                                            </tr>\r\n" + 
							"                                        </table>\r\n" + 
							"                                    </td>\r\n" + 
							"                                </tr>\r\n" + 
							"                            </table>\r\n")
							
						//footer
							.append(footer)
					.toString());
			sendMail.setForm("maisonRclass@gmail.com", "MAISON");
			sendMail.setTo(email);
			sendMail.send();
			result = 1;
		}catch(MessagingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	
}
