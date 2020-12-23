<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<title>문의하기</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
	*{
		font-family:'Noto Sans KR';
	}
	#one{
		width:90%;
		background:#F2BB9C;
		text-align:center;
		border-radius:10px;
		margin:1px auto;
		
	}
	#message{
		margin:10px auto;
		resize:none;
		width:90%;
	}
	#chatarea{
		width:90%;
		height:580px;
		border:2px solid #F2BB9C;
		border-radius:10px;
		margin:10px auto;
	}
	#send{
		float:right;
		margin-right:30px;
	}
</style>
</head>
<body>
	<div id="one">
		<!-- ${withBoard.memberId }랑 ${loginMember.memberId}랑 같은 사람일때는
		float:left div 다른 사람일때는 float:right띄우기 
		nickname에 value를 ${loginMember.memberId }로 데이터 넣기 -->
		<input type="hidden" id="nickname" value="${loginMember.memberId }"/>
		<input type="hidden" id="writer" value="${withBoard.memberId }"/>
		<input type="hidden" id="wbNo" value="${withBoard.wbNo }"/>		
		<h2 style="margin-bottom:3px;padding-top:5px;"><c:out value="${withBoard.memberId }"/></h2>
		<h5 style="margin:5px;padding-bottom:10px;padding-top:5px;"><c:out value="${withBoard.wbTitle }"/></h5>
		
<!-- 		<input type="button" id="enter" value="입장"/> -->
	</div>
	<div id="two" style="display:none;">
		<div id="chatarea">
		
		</div>
	
		<textarea rows="3" id="message" class="form-control"><c:if test="${withBoard.memberId ne loginMember.memberId }">안녕하세요 [<c:out value="${withBoard.wbTitle }"/>]상품 문의드립니다.</c:if></textarea>
		<button class="btn" id="send">보내기</button>	
	</div>
	<script type="text/javascript">
	//게시글 번호
	var wbNo = document.getElementById("wbNo").value;
	
		one = document.getElementById("one");
		two = document.getElementById("two");
		
		$(document).ready(function(){
			//웹 소켓 연결해주는 함수 호출 
			connect();
			var nick = $("#nickname").val();
			var wri = $("#writer").val();
			
			$.ajax({
				url:'${path }/with/msgData.do',
				type:'post',
				data:{'wbNo':wbNo},
				success : function(data){
					console.log('SUCCESS');
				}
			})
		})
		
	
/* 		document.getElementById("exit").addEventListener("click",
			function(){
			//웹 소켓 연결 해제해주는 함수 호출
				disconnect();
		}); */
		//창 닫으면 웹소켓 연결 해제
		window.addEventListener("beforeunload",function(event){
			disconnect();
		})
		
		document.getElementById("send").addEventListener("click",
			function(){
			//메시지를 전송하는 함수 호출
				send();
		});
		var websocket;
		//입장버튼 눌렀을때 호출되는 함수. 
		function connect(){
			websocket = new WebSocket("ws://rclass.iptime.org:9999/20AM_MAISON_final/chat-ws");
			//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
			websocket.onopen = onOpen;
			websocket.onmessage = onMessage;
			websocket.onclise = onClose;
		}
		
		//퇴장 버튼 눌렀을때 호출되는 함수
		function disconnect(){
			msg = document.getElementById("nickname").value;
			websocket.send(msg+"님이 퇴장하셨습니다.");
			websocket.close();
		}
		
		//보내기 버튼을 눌렀을 때 호출될 함수
		function send(){
			nickname = document.getElementById("nickname").value;
			msg = document.getElementById("message").value;
			//websocket.send(nickname + " : "+msg);
			websocket.send(nickname+" : "+msg);
			document.getElementById("message").value="";
		}
		
		//웹소켓에 연결되었을 때 호출될 함수 
		function onOpen(){
			nickname = document.getElementById("nickname").value;
			two = document.getElementById("two");
			two.style.display='block';
			websocket.send(nickname+"님 입장하셨습니다.");
		}
		
		function onMessage(evt){
			writer = document.getElementById("writer").value;
			nickname = document.getElementById("nickname").value;
			data = evt.data;
			var nicknameChk = "";
			if(!data.includes(':')){
				console.log(data.indexOf('님'));
				console.log(data.substring(0,data.indexOf('님')));
				nicknameChk = data.substring(0,data.indexOf('님'));
			}else{
				console.log(data.indexOf(':'));
				console.log(data.substring(0,data.indexOf(':')));	
				nicknameChk = data.substring(0,data.indexOf(':')-1);
			}
			chatarea = document.getElementById("chatarea");
			if(nickname == nicknameChk){
				chatarea.innerHTML += "<div style='background:#FCF7E1;float:right;margin:2%;padding:2%;border-radius:5px;'>"+data+"</div>"+ "<br/><br/><br/><br/>";	
			}else{
				chatarea.innerHTML += "<div style='background:#F2BB9C;float:left;margin:2%;padding:2%;border-radius:5px;'>"+data+"</div>"+ "<br/><br/><br/><br/>";				
			}
		}
		
		function onClose(){
			
		}
	</script>
</body>
</html>