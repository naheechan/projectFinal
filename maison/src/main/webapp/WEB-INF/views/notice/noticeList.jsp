<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.kh.maison.member.model.vo.Member" %> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소통해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");

%>

<!-- Start With -->
<div class="container">
	
		<br>
		<br>
	<div id="notice-container" class="row justify-content-center">
		<div class="col-10 align-self-center">
		<div class="table-main table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width:10%">번호</th>
						<th style="width:55%">제목</th>
						<th style="width:10%">작성자</th>
						<th style="width:15%">날짜</th>
						<th style="width:10%">조회 수</th>
						
					</tr>
				</thead>
				<c:forEach var="n" items="${list }">
					<tbody>
						<tr>
						
							<td>${n.noticeNo }</td>
							<td><a href="${path }/notice/noticeOne.do?noticeNo=${n.noticeNo }">${n.noticeTitle }</a></td>
							<td>관리자</td>
								<!-- 오늘 날짜를 구하기 -->
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<c:set var="sysCal">
									<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" />
								</c:set>
								<c:set var="dateTempParse">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${n.noticeDate }" />
								</c:set>
								<c:if test="${sysCal eq dateTempParse }">
									<fmt:formatDate var="sysTime" value="${n.noticeDate }" pattern="HH:mm" />
									<td><c:out value="${sysTime }" /></td>
									
								</c:if>
								<c:if test="${sysCal ne dateTempParse }">
									<td><c:out value="${dateTempParse }" /></td>
								</c:if>
								<td class="text-center">${n.noticeCount }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
	</div>
	<div class="row justify-content-end">
		<c:if test="${loginMember.memberId eq 'admin' }">
			<button class="btn" onclick="location.href='${path}/notice/noticeAdd.do'"><i class="fas fa-pencil-alt"></i> 글쓰기</button>
		</c:if>
	</div>
	</div>



<div id="page-bar">
	${pageBar }
	</div>
	<br>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		