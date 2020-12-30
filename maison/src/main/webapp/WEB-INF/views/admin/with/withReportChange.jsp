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
  <title>함께해요 신고 상태변경</title>
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
						<form name="wrStatusFrm">
  							<div class="form-group">
    							<label for="memberId">신고 번호</label>
    							<input type="text" class="form-control" id="wrNo" name="wrNo" value="${withReport.wrNo }" readonly>
  							</div>  							
							<div class="form-group">
    							<label for="requestNo">신고 회원</label>
    							<input type="text" class="form-control" id="memberId" name="memberId" value="${withReport.memberId }" readonly>
  							</div>
  							<div class="form-group">
  								<label for="wrStatus">신고 진행상태</label>
								<select class="form-control" name="wrStatus" id="wrStatus">
									<c:choose>
										<c:when test="${withReport.wrStatus eq 'N' }">
											<option selected value="N">미처리</option>
											<option value="P">처리중</option>
											<option value="Y">처리완료</option>
										</c:when>
										<c:when test="${withReport.wrStatus eq 'P' }">
											<option selected value="P">처리중</option>
											<option value="N">미처리</option>
											<option value="Y">처리완료</option>												
										</c:when>
										<c:when test="${withReport.wrStatus eq 'Y' }">
											<option selected value="Y">처리완료</option>
											<option value="N">미처리</option>												
											<option value="P">처리중</option>
										</c:when>											
									</c:choose>									
								</select>
  							</div>
							<div class="form-group">
								<label for="wrContent">입고요청 내용</label>
								<textarea rows="3" class="form-control" name="wrContent" id="wrContent" resize="none">${withReport.wrContent }</textarea>
							</div>
							<div class="form-group">
		               		    <c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd" value="${withReport.wrDate }"/></c:set>
								<label for="wrDate">신고 날짜</label>
								<input type="text" class="form-control" name="wrDate" id="wrDate" value="${dateTempParse }" readonly/>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
<script>
	$(function(){
		$('#wrStatus').on('change',function(){
			var insertData = $('[name=wrStatusFrm]').serialize();
			reportStatusChange(insertData);
		})
	})
	
	//상태 변경하는 ajax 
	//그냥 submit으로 하면 self.close랑 swal을 자유자재로 쓸 수가 없음. 
	function reportStatusChange(insertData){
		$.ajax({
			url:'${path }/admin/reportChangeEnd.do',
			type:'post',
			data:insertData,
			success:function(data){
				if(data==1){
					swal("신고상태가 변경되었습니다.","신고상태 변경을 종료합니다.","success")
						.then((value=>{
							self.close();							
						}));

				}else{
					swal("신고상태 변경실패!","다시 시도하신 후 관리자에게 문의해주세요.","error");
				}
			}
			
		})
	}
</script>
</body>
</html>