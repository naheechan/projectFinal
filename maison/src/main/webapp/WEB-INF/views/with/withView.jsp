<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 상세화면"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>
<style>
	.with-view-box{
		margin-top:2%;
		margin-bottom:2%;
	}
	#data-div{
		border:1px solid lightgray;
		padding:2%;
	}
</style>
<!-- Start WithView Detail -->
<div class="with-view-box">
	<div class="container">
		<div class="row">
			<div class="col-lg-12" style="text-align:left;">
	            	<h5 style="color:#F2BB9C;">함께해요 > <c:out value="${withBoard.wbNo }"/>번 게시물</h5>	
	                <h2><c:out value="${withBoard.wbTitle }"/></h2>
	                <h4><c:out value="${withBoard.memberId }"/></h4>
					<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${withBoard.wbDate }"/></c:set>
	                <h5><c:out value="${dateTempParse }"/></h5>
        	</div>
        	<div class="col-lg-12" style="text-align:right;">
        		<h5>댓글 갯수 몇개 </h5>
        	</div>		
		</div>  
		<     	
	</div>
</div>
<script>
	$(document).ready(function(){
		$("#imgShow").html($("#imgContent").val());
	})
</script>
<!-- End WithView Detail -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	