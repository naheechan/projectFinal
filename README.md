<!-- 관리자아이디 admin
     관리자비밀번호 qwe123!

    유저아이디 qwer1234
    유저비밀번호 qwer1234! 
    
    프로젝트관련 구글 아이디 maisonRclass@google.com
                     비밀번호 maison123!
    
    상품들의 사진 저장한 곳 : nhchihi의 네이버블로그
    -->

# MAISON STORE

가정에서 사용되는 물품들을 판매하는 쇼핑몰로, 구입한 상품에 한해 재구매를 유도하도록 메일 서비스를 제공하고 있습니다.
![index](https://user-images.githubusercontent.com/33804909/109511298-3da19b00-7ae6-11eb-8917-cbd4e45481df.PNG)

## About The Project

[MAISON STORE 사이트 바로가기](http://rclass.iptime.org:9999/20AM_MAISON_final/) : 배포용 사이트로 연결  
[AWS EC2서버에 배포](http://54.180.118.180:8080/maisonHeechan/) : 이 프로젝트를 AWS의 EC2서버(Ubuntu 18.04)에 배포만 한 버전

[DB테이블(ERDCloud)](https://www.erdcloud.com/d/xXG7BEH2ykMKEKYHz) : ERD 클라우드로 이동

## Built With

### Back-end/Server

- Spring
- JDK 8
- Mybatis
- Oracle DB
- Apache Tomcat 8.5

### Front-end
 
- Bootstrap
- Javascript
- AJAX
- JQuery
- HTML/CSS   

## Contributors

- [나희찬](https://github.com/naheechan)
  - 회원가입, 로그인, 네이버아이디로 로그인
  - '쇼핑시계'게시판
  - 메일 알림 서비스
- 경은지
- 김가남
- 박정연
- 이성준
- 장대은

## Explanation

- **회원가입**
![회원가입1](https://user-images.githubusercontent.com/33804909/111795884-f8190680-890a-11eb-809d-9061bf997e44.PNG)
![회원가입2](https://user-images.githubusercontent.com/33804909/111796465-8bead280-890b-11eb-99c0-f25b52e3a72d.PNG)
![회원가입3](https://user-images.githubusercontent.com/33804909/111796499-94dba400-890b-11eb-9f34-a0e8809b0d20.PNG)

-정규식 : 정규식을 이용하여 아이디, 이름, 비밀번호 등의 유효성 검사.    
-AJAX : 아이디 중복검사시 사용.    
-BCryptPasswordEncoder : 비밀번호는 모두 소문자로 변환 후 단방향 암호화    
-AES 암호화 : 나머지 개인정보들은 AES양방향 암호화를 통해 암호화.    
-다음 지도 API : 주소를 입력할때 사용.    
-DatePicker API : 생년월일을 입력할때 사용.<br><br><br>

![회원가입4](https://user-images.githubusercontent.com/33804909/111803345-4f6ea500-8912-11eb-843f-e631193bcfcd.PNG)

-E-mail 전송 : 회원가입 완료시 입력했던 e-mail로 인증메일이 전송됨<br><br><br><br>
   
![회원가입5](https://user-images.githubusercontent.com/33804909/111805235-2fd87c00-8914-11eb-9d60-19b9a85a7937.PNG)

-E-mail 미인증 시 로그인 불가능<br><br><br>

![회원가입6](https://user-images.githubusercontent.com/33804909/111805377-4c74b400-8914-11eb-838a-9f3ffe7c6946.PNG)

-E-mail로 인증메일이 도착한 모습<br><br><br>

![회원가입7](https://user-images.githubusercontent.com/33804909/111805523-729a5400-8914-11eb-9e60-4d3441ef1173.PNG)

-E-mail 인증 시 홈페이지로 이동하며 메일인증 완료<br><br><br><br>

- **네이버 아이디로 로그인 API**
![네아로](https://user-images.githubusercontent.com/33804909/111809442-54365780-8918-11eb-94d5-fc56a1eefa7b.PNG)

-네이버 아이디로 로그인 API : 네이버의 API를 이용하여 회원가입과 로그인 구현

- **로그인**
![로그인1](https://user-images.githubusercontent.com/33804909/111808190-1c7ae000-8917-11eb-9427-ffc93ba1fae9.PNG)

-아이디 저장하기 : Cookie를 이용하여 구현
-비밀번호 인증 : 소문자로 바꾼뒤 암호화하여 DB의 비밀번호와 비교<br><br><br>










