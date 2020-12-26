<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>함께해요 댓글 수정</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path }/resources/admin/vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="${path }/resources/admin/vendors/base/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- plugin css for this page -->
  <link rel="stylesheet" href="${path }/resources/admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path }/resources/admin/css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path }/resources/admin/images/favicon.png" />
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<div class="container-scroller">
	<div class="main-panel">
		<div class="content-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<form name="commentUpdateFrm">
						<input type="hidden" name="wcNo" value="${withComment.wcNo }"/>
						<div class="form-group">
							<label for="memberId">댓글 작성자</label>
							<input type="text" class="form-control" id="memberId" name="memberId" value="${withComment.memberId }" readonly/>
						</div>
						<div class="form-group">
							<label for="wcContent">댓글 내용</label>
							<input type="text" id="wcContent" name="wcContent" class="form-control" value="${withComment.wcContent }"/>
						</div> 
						<button class="btn btn-primary" style="float:right;" type="button" id="commentBtn">수정하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
<script>
	$(function(){
		$("#commentBtn").on('click',function(){
			var insertData = $('[name=commentUpdateFrm]').serialize();
			commentUpdate(insertData);
		})
	})
	
	function commentUpdate(insertData){
		$.ajax({
			url:'${path }/admin/with/commentUpdateEnd.do',
			type:'post',
			data:insertData,
			success:function(data){
				if(data==1){
					swal("함께해요 댓글 수정을 성공했습니다.","함께해요 댓글 페이지를 다시 로드합니다.","success")
						.then((value=>{
							self.close();							
						}));

				}else{
					swal("함께해요 댓글 수정 실패!","다시 시도하신 후 관리자에게 문의해주세요.","error");
				}			
			}
		})
	}
</script>
</body>
</html>