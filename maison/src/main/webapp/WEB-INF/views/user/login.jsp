<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="로그인"/>
</jsp:include>
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
		<form action="" method="">
			<table class="table.borderless">
				<tr>
					<td>
						<div class="form-group">
					   		<input type="text" class="form-control" placeholder="아이디" id="userId" name="userId">
						</div>
					</td>
					<td rowspan="2">
						<button type="submit" class="btn btn-primary">로그인</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
					   		<input type="text" class="form-control" placeholder="비밀번호" id="userPw" name="userPw">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group form-check">
						    <label class="form-check-label">
						      <input class="form-check-input" type="checkbox" name="saveId">아이디 저장하기
						    </label>
						</div>
					</td>
				</tr>
			</table>
		</form>
		
		<table>
			<tr>
				<td colspan="2">
					<p><a href="#">아이디 찾기</a></p>
					<p>|</p>
					<p><a href="#">비밀번호 찾기</a></p>
					<p>|</p>
					<p><a href="${path }/user/enroll">회원가입</a></p>
				</td>
			</tr>
			<tr>
				<td>
					<br><p class="text-muted">소셜계정으로 메종서비스 이용하기</p>			
				</td>
			</tr>
			<tr>
				<div>
				
				</div>
			</tr>
		</table>
	</div>	
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		