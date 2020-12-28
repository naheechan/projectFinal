<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="로그인"/>
</jsp:include>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	//아이디랑 비밀번호 적었나 확인
	function checkSubmit() {
		if($("#memberId").val().trim().length==0) {
			swal("아아디를 입력하세요");
		}else if($("#memberPw").val().trim().length==0) {
			swal("비밀번호를 입력하세요");
		}else {
			return true;
		}
		return false;
	}
	
	//쿠키 저장하기
	function setCookie(cookie_name, value, days) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate()+days);
		
		var cookie_value = escape(value)+((days==null)?"":"; expires="+exdate.toUTCString());
		document.cookie = cookie_name+"="+cookie_value;
	}
	
	//아이디 저장 해제
	$(function() {
		$("#saveId").click(function(e) {
			if($(e.target).is(":checked")==false) {
				setCookie("saveId","","0");
			}
		});
	});
	
</script>
<style>
	p{display:inline}
	.btn-primary {
		height: 90px;
	}
	div#login-container {
		display: flex;
		height: 100vh;
		/* justify-content: center; */
		align-items: center;
		flex-direction: column;
	}
	.jumbotron .container{
		text-align: center;
	}
	
</style>

<section>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1>로그인</h1>
		</div>		
	</div>
	<div class="container" id="login-container">
		<form action="${path }/member/loginEnd" method="POST" onsubmit="return checkSubmit();">
			<table class="table.borderless">
				<tr>
					<td>
						<div class="form-group">
					   		<input type="text" tabindex="1" class="form-control" placeholder="아이디" id="memberId" name="memberId" value="${cookie.saveId.value}">
						</div>
					</td>
					<td rowspan="2">
						<button type="submit" tabindex="3" class="btn btn-primary">로그인</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
					   		<input type="password" tabindex="2" class="form-control" placeholder="비밀번호" id="memberPw" name="memberPw">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group form-check">
						    <label class="form-check-label">
						      <input class="form-check-input" type="checkbox" name="saveId" id="saveId" value="1" ${cookie.saveId.value eq null || cookie.saveId.value eq ""?"":"checked"}>아이디 저장하기
						    </label>
						</div>
					</td>
				</tr>
			</table>
		</form>
		
		<table>
			<tr>
				<td colspan="2">
					<p><a href="${path}/member/findId">아이디 찾기</a></p>
					<p>|</p>
					<p><a href="${path}/member/findPw ">비밀번호 찾기</a></p>
					<p>|</p>
					<p><a href="${path }/member/enroll">회원가입</a></p>
				</td>
			</tr>
			<tr>
				<td>
					<br><p class="text-muted">소셜계정으로 메종서비스 이용하기</p>			
				</td>
			</tr>
			<tr>
				<td>
					<!-- 소셜 로그인 -->
					<a href="${path}/member/naver/login"><img height="50" width="200px;" src="${path}/resources/images/naverBtn.PNG"></a><br><br>
					<%--로컬 
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=818a08c8e17c0dda3c071f31ea989c44&redirect_uri=http://localhost:9090/maison/auth/kakao/callback&response_type=code"> <img height="50" src="${path}/resources/images/kakao.png" /></a>
                                               서버--%>
                    <a href="https://kauth.kakao.com/oauth/authorize?client_id=818a08c8e17c0dda3c071f31ea989c44&redirect_uri=http://rclass.iptime.org:9999/20AM_MAISON_final/auth/kakao/callback&response_type=code"> <img height="50" src="${path}/resources/images/kakao.png" /></a>			
 
  
  
  <p id="token-result"></p>
				</td>
			</tr>
		</table>
	</div>	
</section>
<script type="text/javascript">
	function loginWithKakao() {
	    $.ajax({
	        url: '${path}/member/getKakaoAuthUrl',
	        type: 'get',
	        async: false,
	        dataType: 'text',
	        success: function (res) {
	            location.href = res;
	        }
	    });
	
	}
      Kakao.init( "098b7d9a74ac05ea06aeef5f825ec6ae" );
        // @breif 카카오 로그인 버튼을 생성합니다.

	 Kakao.Auth.createLoginButton({
	    container: '#kakao-login-btn',
	    success: function(authObj) {
	      Kakao.API.request({
	        url: '/v2/user/me',
	        success: function(res) {
	          alert(JSON.stringify(res)+"성공");
	        },
	        fail: function(error) {
	          alert(
	            'login success, but failed to request user information: ' +
	              JSON.stringify(error)
	          )
	        },
	      })
	    },
	    fail: function(err) {
	      alert('failed to login: ' + JSON.stringify(err))
	    },
	  });
 


    
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		