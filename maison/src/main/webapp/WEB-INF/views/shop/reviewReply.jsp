<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:if test="${not empty rlist}">
	<c:forEach var="rr" items="${rlist}">

		<p>admin</p>
<div class="row">
	<div class="col">
		<div class="reviewReply">
			${rr.rrContent }
		</div>
	</div>
</div>
</c:forEach>
</c:if>
<div class="row">
	<div class="col">

		<textarea class="col-6" style="resize: none;" name="rrContent"
			rows="5" required></textarea>
	</div>
</div>
<input type="hidden" name="reviewNo" value="${r.reviewNo }">
<button class="btn btn-success reply">답글 달기</button>