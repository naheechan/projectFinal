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
	private String path = "http://localhost:9090/maison";
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
		
		default : imgPath="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"; 
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
		String sampleImg = getProductImgPath(productNo);
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
							"                                        고객님께서 지난번에 주문하셨던 옵티프리을(를) 거의 다 사용하시지 않았나요?\r\n" + 
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
							.append(sampleImg)
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
							.append(sampleImg)
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" + 
							"                                                <td style=\"border-collapse: collapse;\">\r\n") 
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 2번째 번호
							.append(recommendList.get(0).getProductNo())
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"200px\" height=\"200px\" src=\"")
							//추천상품 2번째 사진주소
							.append(sampleImg)
							.append("\" alt=\"img\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                        </a>\r\n" + 
							"                                    </td>\r\n" +
							"                                                <td style=\"border-collapse: collapse;\">\r\n") 
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 3번째 번호
							.append(recommendList.get(0).getProductNo())
							.append("' target=\"_blenk\" style=\"border: 0; outline: none; text-decoration: none;\">\r\n"+
							"                                            <img width=\"200px\" height=\"200px\" src=\"")
							//추천상품 3번째 사진주소
							.append(sampleImg)
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
							.append(recommendList.get(0).getProductNo())
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//추천상품 2번째 이름
							.append(recommendList.get(0).getProductName())
							.append("</a>")
							.append("                                    </td>\r\n" +
							
							"                                    <td class=\"productName\" style=\"border-collapse: collapse; padding: 5px 0 50px 0; font-weight: bold; font-size: 15px;\">\r\n")							
							.append("<a href='"+path+"/shop/shopDetail.do/?no=")
							//추천상품 3번째 번호
							.append(recommendList.get(0).getProductNo())
							.append("' style=\"text-decoration: none; color: #000000;\">")
							//추천상품 3번째 이름
							.append(recommendList.get(0).getProductName())
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
