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
<title>${grade.gradeCode }혜택 변경하기</title>
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
	${grade }
<div class="container-scroller">
	<!-- Start nav -->
	<jsp:include page="/WEB-INF/views/admin/navbar.jsp"/>
	<!-- End nav -->
	<div class="container-fluid page-body-wrapper">
		<!-- Start sidebar -->
		<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
		<!-- End sidebar -->
		<div class="main-panel">
			<div class="content-wrapper">
				<!-- 첫번째 row div 시작 -->
				<div class="row">
		            <div class="col-md-12 grid-margin">
		              <div class="d-flex justify-content-between flex-wrap">
		                <div class="d-flex align-items-end flex-wrap">
		                  <div class="mr-md-3 mr-xl-5">
		                    <h2>${grade.gradeCode }의 혜택 변경하기</h2>
		                    <br>
		                    <p class="mb-md-0">${grade.gradeCode }의 혜택을 변경하실 수 있습니다.</p>
		                  	<p class="mb-md-0">등급조건은 다음달 1일 건부터, 등급혜택은 변경하신 직후 발생한 결제내역부터 반영됩니다.</p>
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">회원 등급 관리</p>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 첫번째 row div 끝 -->
		           <!-- 두번째 row div 시작 -->
		          <div class="row">
		          	<div class="col-lg-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <h4 class="card-title">회원검색</h4>
		                  <div class="table-responsive pt-3">
		                  	<form action="${path }/admin/membership/updateEnd.do">
			                    <table class="table table-bordered">
			                      <tbody>
								  	<tr>
								  		<th>등급명</th>
								  		<td>
								  			<input type="text" name="gradeCode" class="form-control" value="${grade.gradeCode }" readonly/>
								  		</td>							
								  	</tr>
								  	<tr>
								  		<th>적립률</th>
								  		<td>
								  			<input type="number" step="0.01" name="accRate" class="form-control" value="${grade.accRate }"/>
								  		</td>							
								  	</tr>	
								  	<tr>
								  		<th>등급기준</th>
								  		<td>
								  			<input type="text" name="gradeBase" class="form-control" value="${grade.gradeBase }"/>
								  		</td>							
								  	</tr>								  								  	
			                      </tbody>
			                    </table>
			                    <br>
		                  	<button class="btn btn-primary mt-2 mt-xl-0" style="float:right;" type="submit">수정하기</button>
		                    </form>
		                  </div>
		                </div>
		              </div>
			      	</div>
			      	
		          </div>
		          <!-- 두번째 row div 끝 -->			
			</div>
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>	
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>