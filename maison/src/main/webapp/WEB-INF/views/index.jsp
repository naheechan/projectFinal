<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="첫화면"/>
</jsp:include>
<a href="${path }/shop/insertReview.do?productNo=3">리뷰쓰러가기</a>
<script>
	if(${auth ne null || !empty auth}) {
		alert("${auth}");
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		