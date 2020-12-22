<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
</head>
<body>

<!-- 토큰값 url에 노출안되게 하기위한 jsp -->

<section>
	<form id="frm" name="frm" action="${pageContext.request.contextPath}/member/naver/loginEnd" method="POST">
		<input type="hidden" id="res" name="res" value='${res}'>
	</form>
</section>

<script>
$(function() {
	$("#frm").submit();
});
</script>

</body>
</html>