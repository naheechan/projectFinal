<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="결제완료"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="결제완료"/>
</jsp:include>
<style>
	.circle{
		width: 100px;height: 100px;border-radius: 50%;border: 5px solid black;
		left: 50%;
	}
</style>
<section>
	<div class="container" style="height: 500px;">
		<!-- <table class="table">
			<tr>
				<th>주문번호</th>
				<th>상품번호</th>
				<th>수량</th>
				<th>리뷰쓰기</th>
			</tr>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>
					<button class="btn btn-hover">review</button>
				</td>
			</tr>
		</table> -->
	
		<p class="text-center text-success" style="font-size: 50px;">결제가 완료되었습니다. <i class="far fa-check-circle"></i></p>
			
		<div class="container">
			<table class="table">
				<tr>
					<th>주문번호</th>
					<th>주문상세번호</th>
					<th>상품번호</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>수량</th>
					<th>가격</th>
					<th>리뷰</th>
				</tr>
				<c:forEach items="${list }" var="o">
				<tr>
					<td>${o.orderNo }</td>
					<td>${o.orderDetailNo }</td>
					<td>${o.productNo }</td>
					<td><img src="${path }/resources/upload/product/${o.productImg }" style="width: 50px;height: 50px;"></td>
					<td>세제</td>
					<td>${o.odAmount }</td>
					<td>${o.odAmount*o.price }</td>
					<td><i class="fas fa-user-edit fa-2x"></i></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	