<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Site Icons -->
<link rel="shortcut icon" href="${path }/resources/images/favicon.png" type="image/x-icon">
<link rel="apple-touch-icon" href="${path }/resources/images/apple-touch-icon.png">   
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="${path }/resources/css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="${path }/resources/css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${path }/resources/css/custom.css"> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
<title>신고하기</title>
<style>
	#reportFrm{
		margin:3%;
	}
</style>
</head>
<body>
<div class="container">

	<form id="reportFrm" method="post" name="reportFrm">
		<input type="hidden" name="wbNo" value="${withBoard.wbNo }">
		<!-- value에 loginMember.memberId session값 들어가야 함. -->
		<input type="hidden" name="memberId" value="user02">
		<div class="form-group">
			<label for="cInput1" class="control-label">제목</label>
			<input type="text" id="cInput1" class="form-control" readonly
			value="${withBoard.wbTitle }">
		</div>
		<div class="form-group">
			<label for="cInput2" class="control-label">작성자</label>
			<input type="text" class="form-control" id="cInput2" readonly
			value="${withBoard.memberId }">
		</div>
		<div class="form-group">
			<label class="control-label">사유선택</label>
			<br>
			<span style="color:#D2D2D2;">여러 사유에 해당되는 경우, 대표적인 사유 1개를 선택해주세요.</span>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="wrContent" id="wrContent1" value="부적절한 홍보 게시글" required>
				<label class="form-check-label" for="wrContent1">
					부적절한 홍보 게시글
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="wrContent" id="wrContent2" value="음란성 또는 청소년에게 부적합한 내용">
				<label class="form-check-label" for="wrContent2">
					음란성 또는 청소년에게 부적합한 내용
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="wrContent" id="wrContent3" value="명예훼손/사생활 침해 및 저작권침해 등">
				<label class="form-check-label" for="wrContent3">
					명예훼손/사생활 침해 및 저작권침해 등
				</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="wrContent" id="wrContent4" value="기타">
				<label class="form-check-label" for="wrContent4">
					기타
				</label>
			</div>
		</div>
		<hr/>
		<button style="float:right;margin-left:2%;" type="button" class="btn" id="reportSendBtn">신고하기</button>
		<button style="float:right;" type="button" class="btn" id="reportCleBtn">취소</button>
	</form>
</div>

  <!-- ALL JS FILES -->
	<script
  src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"
  integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk="
  crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath() %>/resources/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/jquery.superslides.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap-select.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/inewsticker.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootsnav.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/images-loded.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/isotope.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/baguetteBox.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/form-validator.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/contact-form-script.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/custom.js"></script>
	<script>
		$(function(){
			$("#reportCleBtn").click(function(){
				self.close();
			})
		})
		
		//신고하기 버튼 클릭시
		$("#reportSendBtn").click(function(){
			var insertData = $('[name=reportFrm]').serialize();
			reportInsert(insertData);
		})
		//신고하기 함수
		function reportInsert(insertData){
			$.ajax({
				url:'${path }/with/reportEnrollEnd.do',
				type:'post',
				data:insertData,
				success:function(data){
					if(data==1){
						alert("신고가 접수되었습니다. 신고하기 화면을 종료합니다.");
						self.close();
					}else{
						alert("신고 접수가 실패했습니다. 다시 시도해주세요.");
					}
				}
			})
		}

	</script>
</body>
</html>