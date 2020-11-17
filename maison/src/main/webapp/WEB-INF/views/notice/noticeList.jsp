<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>

<!-- Start With -->
	<div id="notice-container">
		<button onclick="location.href='${path}/notice/noticeAdd.do'">글쓰기</button>
		<table class="table table-hover">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>날짜</td>
				<td>조회 수</td>
				
			</tr>
		</table>
	
	</div>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		