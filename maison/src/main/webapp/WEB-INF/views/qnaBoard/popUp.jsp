<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
<style>
input:focus { outline: none; }
#checkMsg:hover { cursor:default; }
</style>
<body>
	현재 비밀번호
	<c:out value="${qnaPw}"/><br>

	<form action="">
		<div style="text-align:center">
		
			<p><h5>비밀번호 입력</h5></p>
			<input type="password" maxlength='4' id="password" class="form-control" style="width:200px;height:35px;margin-left:55px">
			<input type="text" value="" id="checkMsg"  style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;width:230px"readonly>
		</div>
			<input type='button' id="pwCh" value='확인' class="btn" style="background:#FCF7E1;margin-left:135px">
		
	</form>

	<script>
	var count=0;
		$("#pwCh").click(function() {
			
			
			if(($("#password").val())==(${qnaPw})){
				opener.parent.location.replace("${path}/qnaBoard/qnaBoardView.do?no=${qnaNo}");
				self.close();
			}else if(!($("#password").val())){
				$("#checkMsg").val("값을 입력해주세요");
				$("#checkMsg").css("color","red");
			}else if(($("#password").val()) && ($("#password").val())!=(${qnaPw})){
				$("#checkMsg").val("비밀번호가 일치하지 않습니다");
				$("#checkMsg").css("color","red");
				$("#password").val(null);
				count++;
				console.log(count);
				if(count==3){
					self.close();
				}
			}
			
				
		});
	</script>

</body>
</html>