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

<script src = "${path}/ckeditor/ckeditor.js"></script>
<!-- Start With -->
<section>
<div class="row justify-content-center">
<form action="${path }/notice/noticeUpdateEnd.do" method="post" id="noticeFrm">
	<table class="col-md-12 table">
		<tr>
			<th>제목</th>
			<td><input type="text" name="noticeTitle" value="${n.noticeTitle }" required></td>
			<input type="hidden" name="noticeNo" value="${n.noticeNo }">
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="noticeContent" id="noticeContent">${n.noticeContent }</textarea>
			
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" id="savebutton" value="수정하기" />
			</td>
		</tr>	
		
	
	
	</table>


</form>
</div>
</section>
<!-- End With -->
<script>


CKEDITOR.replace("noticeContent",{
	filebrowserUploadUrl : "${path }/notice/imageUpload.do"
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		