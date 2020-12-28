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
<title>등급혜택관리</title>
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
		                    <h2>등급 혜택 관리</h2>
		                    <br>
		                    <p class="mb-md-0">쇼핑몰 회원의 등급 조건/혜택을 관리할 수 있습니다.</p>
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
		                  <h4 class="card-title">신규회원 혜택</h4>
		                  <div class="table-responsive pt-3">
		                  	<form action="${path }/admin/membership/default.do">
			                    <table class="table table-bordered">
			                      <tbody>
								  	<tr>
								  		<th>웰컴적립금</th>
								  		<td>
								  			<div>
									  			<input type="text" name="welcomeMileage" class="form-control" value="${defaultMileage }"/>								  			
								  			</div>
								  		</td>								  		
								  	</tr>
			                      </tbody>
			                    </table>
			                    <br>
		                  	<button class="btn btn-primary mt-2 mt-xl-0" style="float:right;">수정하기 </button>
		                    </form>
		                  </div>
		                </div>
		              </div>
			      	</div>
		          </div>
		          <!-- 두번째 row div 끝 -->	
		          <!-- 세번째 row div 시작 -->
				  <div class="row">
		            <div class="col-md-12 stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <p class="card-title">회원정보</p>
			              <br/>
		                  <div class="table-responsive">
		                    <table id="recent-purchases-listing" class="table">
		                      <thead>
		                        <tr>
		                        	<th>등급명</th>
									<th>등록된 회원 수</th>
		                          	<th>등급조건</th>
		                          	<th>등급혜택</th>
		                          	<th>관리</th>
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      				<td>
		                      					<c:choose>
		                      						<c:when test="${l.GRADECODE eq 'ace' }">
		                      							<label class="badge badge-success">ACE</label>
		                      						</c:when>
		                      						<c:when test="${l.GRADECODE eq 'gold' }">
		                      							<label class="badge badge-warning">GOLD</label>
		                      						</c:when>
		                      						<c:when test="${l.GRADECODE eq 'vip' }">
		                      							<label class="badge badge-danger">VIP</label>
		                      						</c:when>
		                      						<c:when test="${l.GRADECODE eq 'mvg' }">
		                      							<label class="badge badge-primary">MVG</label>
		                      						</c:when>		                      						
		                      					</c:choose>
		                      				</td>
		                      				<td><c:out value="${l.AMOUNT }"/></td>
		                      				<td>지난 3개월 간, <c:out value="${l.GRADEBASE }"/>이상 구매</td>
		                      				<td><c:out value="${l.ACCRATE }"/></td>		                      				
											<td>
												<button class="btn btn-lignt" onclick="membershipUpdate('${l.GRADECODE}')">수정</button>
							
											</td>
		                      			</tr>
		                      		</c:forEach>
		                      	</c:if>
	                      	  </tbody>
		                    </table>
		                  </div>
		                  <br>
		                 <div id="pageBar">
		                  	${pageBar }
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 세번째 row div 끝 -->	
			</div>
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>
	</div>	
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
<script>
	function membershipUpdate(str){
		location.href='${path }/admin/membership/update.do?gradecode='+str;
	}
</script>
</body>
</html>