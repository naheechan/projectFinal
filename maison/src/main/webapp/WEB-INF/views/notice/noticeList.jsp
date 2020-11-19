<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소통해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>

<!-- Start With -->
		<button class="btn btn-success" onclick="location.href='${path}/notice/noticeAdd.do'">글쓰기</button>
		<br>
		<br>
	<div id="notice-container" class="row justify-content-center">
		<div class="col-md-9 align-self-center">
		<table class="table table-hover">
			<tr>
				<td style="width:10%">번호</td>
				<td style="width:50%">제목</td>
				<td style="width:10%">작성자</td>
				<td style="width:15%">날짜</td>
				<td style="width:15%">조회 수</td>
				
			</tr>
			<c:forEach var="n" items="${list }">
				<tr>
					<td>${n.noticeNo }</td>
					<td><a href="${path }/notice/noticeOne.do?noticeNo=${n.noticeNo }">${n.noticeTitle }</a></td>
					<td>관리자</td>
					<td>${n.noticeDate }</td>
					<td>${n.noticeCount }</td>
				</tr>
			
			</c:forEach>
		</table>
	</div>
	</div>
	<div id="page-bar">
	${pageBar }
	</div>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		