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
	<jsp:param name="menuTitle" value="소통해요"/>
</jsp:include>

<!-- Start With -->
<style>
	.marginl{
		margin-left:200px;
	}
	.marl{
		margin:20px;
	}
</style>
<section id="content" class="container">

<div class="row justify-content-center">

	<div class="col marl">
	소통해요> <a href="${path }/notice/noticeList.do">공지해요 > </a>
		<table class="table">
			<tr>
				<th style="width:10%">제목</th>
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
<c:if test="${loginMember eq 'admin' }">
	<div class="row justify-content-end">
		<button class="btn btn-info" onclick="location.href='${path}/notice/noticeUpdate.do?noticeNo=${n.noticeNo }'"><i class="far fa-edit"></i> 수정</button>
		&nbsp&nbsp
		<button class="btn btn-danger" onclick="deleteNotice()"><i class="far fa-trash-alt"></i> 삭제</button>
	</div>
</c:if>
<br>

</section>
<script>
	function deleteNotice(){
		var del=confirm("삭제하시겠습니까 ? ");
		if(del==true){
			location.href='${path}/notice/noticeDelete.do?noticeNo=${n.noticeNo }';
		}
	}

</script>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		