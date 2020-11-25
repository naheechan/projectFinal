<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 수정"/>
</jsp:include>
<script src = "${path }/ckeditor/ckeditor.js"></script>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>
<style>
	#update-div{
		border:1px solid lightgray;
		padding:2%;
	}
	.form-group.required .control-label:after{
	   color: #d00;
	   content: "*";
	   position: absolute;
	   margin-left: 6px;
	}
</style>
<!-- Start With Update -->
<div class="with-list-box">
	<div class="container">
		<form action="${path }/with/withUpdateEnd.do" method="post">
			<!-- 희찬이랑 합치게 되면 여기 value에 ${loginMember.memberId }들어가야함. -->
			<input type="hidden" value="user01" name="memberId">
			<div id="update-div">
				<div class="form-group required">
					<label for="wbTitle" style="font-weight:bold;" class="control-label">상품명</label>
					<input type="text" id="wbTitle" class="form-control" name="wbTitle" value="${withBoard.wbTitle }"required>
				</div>	
				<div class="form-row">
					<div class="form-group required col-md-4">
						<label for="wbType" style="font-weight:bold;" class="control-label">분류선택</label>
						<select id="wbType" class="form-control" name="wbType" required>
							<c:choose>
								
							</c:choose>
							<option selected>선택하기</option>
							<option value="free">나눔하기</option>
							<option value="sell">중고거래</option>
						</select>
					</div>
					<div class="form-group required col-md-8">
						<label for="wbPrice" style="font-weight:bold;" class="control-label">판매 가격</label>
						<input type="text" readonly id="wbPrice" placeholder="₩(원)" class="form-control" name="wbPrice" style="text-align:right;" required>
					</div>
				</div>		
			</div>			
		</form>
	</div>
</div>

<!-- End With Update -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	