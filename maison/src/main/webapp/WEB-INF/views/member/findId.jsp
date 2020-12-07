<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="아이디 찾기"/>
</jsp:include>
<style>
	.jumbotron .container{
		text-align:center;
	}
</style>
<section>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1>아이디 찾기</h1>
		</div>		
	</div>
	
	<div>
		아이디 찾기에 필요한 정보를 입력하세요
	</div>
		<form action="${path}/member/findIdSMTP">
		
			<span>이름 : <input type="text" name="name"></span><br>
			<div class="form-group">
				    <label for="datepicker">생년월일</label><br>
				    <input type="text" class="form-control" id="datepicker" name="birth" required  style="width:100px;">
				    <div id="checkBrith-container">
					    <p class="text-danger" id="notRegBrith" style="display:none">달력에서 생년월일을 선택해주세요</p>
				    </div>
				    <input type="hidden" id="brithCheck" name="brithCheck" value="0">
			</div>
			<input type="submit">				
		</form>

<script>
	$(function() {
		$("#datepicker").change(function(e) {
			$("#brithCheck").val("0");
			let checkBirth = $(e.target).val().trim();
			let regBirth = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
			if(regBirth.test(checkBirth)) {
				$("#checkBrith-container").children().css("display","none");
				$("#brithCheck").val("1");
			}else {
				$("#checkBrith-container").children().css("display","none");
				$("#notRegBrith").css("display","block");
			}
		});
		
		 $("#datepicker").datepicker({
	     	showOn:"both",
	     	buttonImage:"${path}/resources/images/calendarIcon.jpg",
	     	buttonImageOnly:true,
	     	changeMonth:true,
	     	changeYear:true,
	     	minDate:'-150y',
	     	nextText:'다음 달',
	     	prevText:'이전 달',
	     	yearRange:'c-150:c+0',
	     	dateFormat:'yy-mm-dd',
	     	showMonthAfterYear:true,
	     	dayNamesMin:['월','화','수','목','금','토','일'],
	     	monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	     });
	});
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		