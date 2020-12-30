<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=""/>
</jsp:include>
<style>
	.error-container {
		height: 100vh;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
</style>
<section>
	<div class="error-container">
		<img src="${path}/resources/images/errorImg.png" height="250px" width="150">
		<p class="display-2 text-black-50">${requestScope['javax.servlet.error.status_code']}</p>
		<p class="text-black-50" style="font-size: 20px">페이지 처리중 오류가 발생했습니다.</p>
		<p class="text-black-50" style="font-size: 20px">관리자에게 문의해 주세요.</p>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		