<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="쇼핑해요"/>
</jsp:include>
<style>
	div#shop-container{width:60%; margin:0 auto;}
</style>

<section>
	<div id="shop-container">
		<table>
			<c:forEach items="${list }" var="s">
				<tr>
					<td>
						<a href="${path }/shop/shopView.do?no=${s.PRODUCTNO}">
						<c:out value="${s.PRODUCTNO }"/>
						</a>
					</td>
					<td><c:out value="${s.PRODUCTNAME }"/></td>
					<td><c:out value="${s.PRODUCTSUMMARY }"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		