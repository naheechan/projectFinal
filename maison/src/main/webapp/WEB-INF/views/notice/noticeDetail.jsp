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
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>

<!-- Start With -->
<style>
	.marginl{
		margin-left:200px;
	}

</style>
<section id="content">
	
<div class="row justify-content-center">
	<div class="col">
		<table class="table">
			<tr>
				<th>제목</th>
				<td>${n.noticeTitle}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${n.noticeDate}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${n.noticeCount}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					${n.noticeContent }
				
				</td>
			</tr>
		
	
		</table>
	</div>	
</div>

<div class="row justify-content-end">
	<div class="col align-self-end">
		<button class="btn btn-info" onclick="location.href='${path}/notice/noticeUpdate.do?noticeNo=${n.noticeNo }'">수정하기</button>
		<button class="btn btn-danger" onclick="location.href='${path}/notice/noticeDelete.do?noticeNo=${n.noticeNo }'">삭제하기</button>
	</div>
	</div>
</section>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		