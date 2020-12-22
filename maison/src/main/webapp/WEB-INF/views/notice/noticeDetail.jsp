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
	.light{
		font-weight:lighter;
	}
</style>
<section id="content" class="container">

<div class="row justify-content-center">

	<div class="col marl">
	소통해요> <a href="${path }/notice/noticeList.do">공지해요  </a>
	<br>
		<table class="table">
			<tr>
				<th style="width:10%" class="table-active">제목</th>
				<td>${n.noticeTitle}</td>
			</tr>
			<tr>
				<th class="table-active">작성자</th>
				<td>관리자</td>
			</tr>
			<tr>
				<th colspan="2">
				<fmt:formatDate value="${n.noticeDate }" pattern="yyyy-MM-dd" var="fmdate"/>
						
					&nbsp&nbsp&nbsp&nbsp 작성일 <span class="light"><c:out value="${fmdate}"/></span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 조회수 <span class="light">${n.noticeCount }</span>
				</th>
			</tr>
			<tr>
			<th></th>
			</tr>
			
			
		</table>
		
		<div>
			${n.noticeContent }
		
		</div>				
			
		
	
	</div>	

</div>
<c:if test="${loginMember.memberId eq 'admin' }">
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