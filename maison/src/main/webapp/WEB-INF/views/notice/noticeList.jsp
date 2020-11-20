<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- <%@ page import="com.kh.maison.member.vo.Member" %> --%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소통해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>

<%
/* Member logginedMember = (Member)session.getAttribute("logginedMember"); */
	String loginMember=(String)session.getAttribute("loginMember");


%>

<!-- Start With -->
<div class="container">
	
		<br>
		<br>
	<div id="notice-container" class="row justify-content-center">
		<div class="col-10 align-self-center">
		<table class="table table-hover">
			<tr class="table-active">
				<td style="width:10%">번호</td>
				<td style="width:55%">제목</td>
				<td style="width:10%">작성자</td>
				<td style="width:15%">날짜</td>
				<td style="width:10%">조회 수</td>
				
			</tr>
			<c:forEach var="n" items="${list }">
				<tr>
					<td>${n.noticeNo }</td>
					<td><a href="${path }/notice/noticeOne.do?noticeNo=${n.noticeNo }">${n.noticeTitle }</a></td>
					<td>관리자</td>
					<td>${n.noticeDate }</td>
					<td class="text-center">${n.noticeCount }</td>
				</tr>
			
			</c:forEach>
		</table>
	</div>
	</div>
	<div class="row justify-content-end">
		<c:if test="${loginMember==null }">
			<button class="btn btn-success" onclick="location.href='${path}/notice/noticeLogin.do'">로그인</button>
		</c:if>
		<c:if test="${loginMember eq 'admin' }">
			<button class="btn" onclick="location.href='${path}/notice/noticeAdd.do'"><i class="fas fa-pencil-alt"></i> 글쓰기</button>
			<button class="btn btn-success" onclick="location.href='${path}/notice/noticeLogout.do'">로그아웃</button>
		</c:if>
	</div>
	</div>
	
	
	
	<div id="page-bar">
	${pageBar }
	</div>
	<br>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		