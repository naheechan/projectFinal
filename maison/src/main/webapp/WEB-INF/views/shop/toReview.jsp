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
<section>
<form name="reviewFrm" id="reviewFrm">
<input type="number" name="reviewNo" >
<input type="button" value="리뷰 찾기" id="reviewBtn">
</form>

<div id="pop"></div>
</section>
<script>
$(function(){
	$("#reviewBtn").click(function(){
		$("#pop").show();
		$.ajax({
			url: "${path}/shop/updateReview.do",
			data : $("#reviewFrm").serialize(),
			dataType:"html",
			success: function(data){
				$("#pop").html("");
				$("#pop").html(data);
			},
			error : function(){
				console.log("ajax 통신 실패");
			}
		});
	});
	
	
})

</script>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		