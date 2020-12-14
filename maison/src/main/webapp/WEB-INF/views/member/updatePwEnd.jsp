<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="비밀번호 변경"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="마이페이지 / 비밀번호 변경"/>
</jsp:include>
<style>
	#data-div{
		border:1px solid lightgray;
		padding:2%;
	}
	#submit-container {
		display: flex;
		justify-content: center;
	}
</style>
<!-- Start pwUpdate -->
<section>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<br>
	            <div class="title-all text-center">
	                <h1>비밀번호 변경</h1>
	                <p>변경하실 비밀번호를 입력해주세요.</p>
	                <p>다른 아이디나 사이트에서 사용한 적 없는 안전한 비밀번호로 변경해주세요.</p>
	            </div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<form action="${path }/member/updatePwEndEnd.do" method="post" onsubmit="return checkSubmit();">
					<div id="data-div">
						<div class="form-group">
							<label for="memberId">아이디</label>
						    <input type="text" class="form-control" value="${loginMember.memberId }" id="memberId" name="memberId" required readonly>		
						</div>
						<div class="form-group">
							<label for="memberPw">비밀번호</label>
							<input type="password" class="form-control" placeholder="영문,숫자,특수기호 조합 6~15자리" id="memberPw" name="memberPw" required/>
						    <div id="checkPw-container">
							    <p class="text-danger" id="notEnoughPw" style="display:none">비밀번호를 6~15글자로 입력해주세요.</p>
							    <p class="text-danger" id="notRegPw" style="display:none">영어+숫자+특수기호 조합만 가능합니다.</p>
							    <p class="text-success" id="ablePw" style="display:none">사용가능한 비밀번호입니다.</p>
						    </div>
						    <input type="hidden" id="pwCheck" name="pwCheck" value="0">				
						</div>
					 	<div class="form-group">
						    <label for="memberRePw">비밀번호 확인</label>
						    <input type="password" class="form-control" placeholder="비밀번호 재입력" id="memberRePw" required>
						    <div id="checkRePw-container">
							    <p class="text-danger" id="notEnoughRePw" style="display:none">비밀번호가 일치하지 않습니다.</p>
							    <p class="text-success" id="ableRePw" style="display:none">비밀번호가 일치합니다.</p>
						    </div>
						    <input type="hidden" id="rePwCheck" name="rePwCheck" value="0">
					 	</div>

					 	<div class="form-group">
					 		<label for="captcha" style="display:block">자동 로그인 방지</label> 
						 	<div style="overflow:hidden" class="form-row"> 
						 		&nbsp;
						 		<div style="float:left" class="form-group"> 
						 			<img title="캡차이미지" src="${path }/captchaImg.do" alt="캡차이미지" id="captchaImg"/> 
						 			<div id="ccaudio" style="display:none">
						 			</div> 
						 		</div> 
							 	<div style="padding:3px" class="form-group"> 
							 		<button type="button" id="reload" class="btn" onclick="javaScript:getImage()">
							 			<i class="fas fa-redo-alt"></i>
							 		</button>
									<button id="soundOn" type="button" class="btn" onclick="javaScript:audio()">
										<i class="fa fa-volume-up" aria-hidden="true"></i>
									</button>
							 	</div> 
						 	</div> 
						 	<div style="padding:3px" class="form-row">
						 		<div class="form-group">
							 		<input id="answer" type="text" value="" class="form-control"> 	
							 		<input type="hidden" id="captchaChk" name="captchaChk" value="0">		 		
						 		</div> 
						 		&nbsp;
						 		<div class="form-group">
							 		<input id="checkBtn" type="button" value="확인" class="btn"/>  		
						 		</div>
						 	</div>
					 	</div>				 	
					</div>
					<br>
					<div id="submit-container">
					 	<button type="button" class="btn btn-danger" onclick="location.href='${path }/member/mypage.do'">취소하기</button>
					 	&nbsp;&nbsp;
					 	<button type="submit" class="btn btn-primary">변경하기</button>
					</div>
				</form>
				<br>
			</div>
		</div>
	</div>
</section>
<script>
//비밀번호 유효성검사 함수
function regPw(str) {
	let reg1 = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]+$/;
	let reg2 = /[a-zA-Z]/g;
	let reg3 = /[0-9]/g;
	let reg4 = /[~!@#$%^&*()_+|<>?:{}]/g;
	return (reg1.test(str) && reg2.test(str) && reg3.test(str) && reg4.test(str));
}

$(function(){
	//비밀번호 유효성체크
	$("#memberPw").keyup(function(e) {
		$("#pwCheck").val("0");
		let checkPw = $(e.target).val().trim();
		if(checkPw.length<6 || checkPw.length>15) {
			//길이 짧음
			$("#checkPw-container").children().css("display","none");
			$("#notEnoughPw").css("display","block");
		}else {
			if(regPw(checkPw)) {
				//정규식 만족함
				$("#checkPw-container").children().css("display","none");
				$("#ablePw").css("display","block");
				$("#pwCheck").val("1");
			}else {
				//정규식 만족안됨
				$("#checkPw-container").children().css("display","none");
				$("#notRegPw").css("display","block");
			}
		}
	});
	
	//비밀번호 재입력 체크
	$("#memberRePw").keyup(function(e) {
		$("#rePwCheck").val("0");
		let checkRePw = $(e.target).val().trim();
		let checkPw = $("#memberPw").val().trim();
		if(checkPw.length!=0 && checkRePw==checkPw) {
			$("#checkRePw-container").children().css("display","none");
			$("#ableRePw").css("display","block");
			$("#rePwCheck").val("1");
		}else {
			$("#checkRePw-container").children().css("display","none");
			$("#notEnoughRePw").css("display","block");
		}
	});
	
})

//submit 유효성검사
function checkSubmit(){
	if($("#pwCheck").val()=="0") alert("비밀번호를 정확히 입력해주세요");
	else if($("#rePwCheck").val()=="0") alert("비밀번호 확인을 해주세요");
	else if($("#captchaChk").val()=="0") alert("비밀번호 자동 변경 방지 검사를 해주세요.");
	else return true;
	
	return false;
}

//심플캡챠 관련 함수 
// audio 생성
function audio(){
	var rand = Math.random();
	var uAgent = navigator.userAgent;
	var soundUrl = '<%=request.getContextPath()%>/captchaAudio.do?rand='+rand;
	if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){
		audioPlayer(soundUrl);
	}else if(!!document.createElement('audio').canPlayType){
		try{
			new Audio(soundUrl).play();
		}catch(e){
			audioPlayer(soundUrl);
		}
	}else{
		window.open(soundUrl,'','width=1,height=1');
	}
}
//이미지 생성
function getImage(){
	var rand = Math.random();
	var url = '<%=request.getContextPath()%>/captchaImg.do?rand='+rand;
	$("#captchaImg").attr('src',url);
}
function audioPlayer(objUrl){
	document.querySelector('#ccaudio').innerHTML = '<bgsoun src="' +objUrl +'">';
}
// 화면 켜지면 이미지 로드하고, checkBtn 눌렀을때 ajax로 유효성 검사해서, 검사 확인 되면 확인용 hidden value 1로 바꾸기
$(document).ready(function(){
	getImage();
	$("#checkBtn").click(function(){
		var inputCapt = $('#answer').val();
		$.ajax({
			url: '<%=request.getContextPath()%>/member/captchaCheck.do?target='+inputCapt,
			type : 'post',
			success : function(data){
				if(data == 1){
					alert('확인되었습니다.\n비밀번호를 변경하시려면 변경하기 버튼을 클릭해주세요.');
					$("#captchaChk").val("1");
				}else{
					alert('입력하신 문구가 일치하지 않습니다.\n다시 입력해주세요.');
					$("[name=answer]").val("");
				} 
			}
		});
	})
})




</script>
<!-- End pwUpdate -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	