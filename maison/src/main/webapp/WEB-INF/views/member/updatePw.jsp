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
	#naver-div{
		border:1px solid lightgray;
		padding:4%;
	}
</style>
<!-- Start mypage / updatePw -->
<section>
	<div class="container">
		<div class="row">
			<!-- Start sideMenu -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<!-- End sideMenu -->
			<div class="col-lg-9 col-md-7">
				<div class="updatePwAsk-div">
					<br/>
					<h2>비밀번호 변경</h2>
					<hr>
					<form action="${path }/member/updatePwCheck.do" method="post">
						<div style="text-align:center;">
							<span>회원님의 정보를 안전하게 보호하기 위해서 비밀번호를 재입력해주세요.</span>
							<br/>
							<br/>
								<div id="naver-div">
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">아이디&nbsp;&nbsp; </span>
										</div>
										<input type="text" class="form-control" readonly value="${loginMember.memberId }" name="memberId"/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">비밀번호</span>
										</div>
										<input type="password" class="form-control" id="password" name="memberPw"/>
										<div class="input-group-append">
											<button class="btn" type="button" id="togglePassword">				
												<i class="fas fa-eye-slash" id="eye"></i>
											</button>
										</div>
									</div>								
								</div>
								<br>
								<button class="btn" type="button" style="background:#FCF7E1;" onclick="location.href='${path }/member/mypage.do'">취소</button>
								<button class="btn" type="submit" style="background:#F2BB9C;">인증하기</button>			
						<br>
						<br>									
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- End mypage / updatePw -->
<script>
	/* 눈 감았다 떴다 하기 */
	$("#togglePassword").click(function(){
		if(($("#password").attr("type"))=="password"){
			 $("#password").prop("type","text");
			 $("#eye").prop("class","fas fa-eye");				
		}else{
			$("#password").prop("type","password");
			$("#eye").prop("class","fas fa-eye-slash");
		}
	})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	