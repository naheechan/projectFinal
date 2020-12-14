<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원가입"/>
</jsp:include>
<style>
	#announce-container {
		height: 100vh;
		display: flex;
		justify-content: center;
		margin: 10vh;
	}	
	#announce>img{
		width: 150px;
	}
	
</style>
<section>
	<div id="announce-container">
 		<div id="announce">
 			<img src="${path }/resources/images/email01.png" class="mx-auto d-block" alt="email.png">
 			<h1 class="display-4">이메일을 인증해주세요.</h1><br>
 			<h2>고객님의 회원가입을 축하합니다.</h2>
 			<p>회원가입시 입력해주신 이메일 [<b>${param.email}</b>]로 인증메일을 발송했습니다.<br>
 			해당 메일을 통해 회원가입을 완료해 주세요.</p><br>
 			<p>- 참고사항 -</p>
 			<p>메일이 도착하는데까지 어느정도 시간이 소요될수있으니 참고해주세요.</p><br><br>
 			<button class="btn btn-success mx-auto d-block" onclick="location.replace(${path}/)">홈으로</button>
 		</div>
 		
 	</div>

</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		