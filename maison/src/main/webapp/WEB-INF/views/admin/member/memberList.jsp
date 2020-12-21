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
<title>회원목록</title>
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
		                    <h2>회원 목록</h2>
		                    <br>
		                    <p class="mb-md-0">쇼핑몰에 가입한 회원의 연락처, 가입일 등의 정보를 확인, 수정, 관리할 수 있으며, </p>
		                    <p class="mb-md-0">특정회원을 검색하시려면 상단의 검색박스에서 검색어를 입력하고 회원구분/이메일 수신 여부/회원등급 중</p> 
							<p class="mb-md-0">하나 혹은 다중으로 정보를 선택한 후 하단의 검색버튼을 클릭하시면 됩니다.</p>
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">회원 목록</p>
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
		                  	<form action="${path }/admin/memberList.do">
			                    <table class="table table-bordered">
			                      <tbody>
								  	<tr>
								  		<th>검색어</th>
								  		<td>
								  			<div class="form-row">
	    									<div class="col">		
									  			<select class="form-control" name="type">
									  				<option value="" selected>선택하기</option>
									  				<option value="memberId">아이디</option>
									  				<option value="memberName">이름</option>
									  				<option value="both">아이디+이름</option>
									  			</select>
								  			</div>
								  			<div class="col">
									  			<input type="text" name="keyword" class="form-control"/>
								  			</div>
								  			</div>
								  		</td>
								  		<th>회원구분</th>
								  		<td>
								  			<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="memberSocial" value="">전체
											  </label>
											</div>							  		
								  			<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="memberSocial" value="normal">일반 회원
											  </label>
											</div>
						  					<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="memberSocial" value="social">소셜 회원
											  </label>
											</div>										
								  		</td>
								  	</tr>
								  	<tr>
								  		<th>이메일 수신 여부</th>
								  		<td>
								  			<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="emailStatus" value="">전체
											  </label>
											</div>
						  					<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="emailStatus" value="accept">수신허용
											  </label>
											</div>	
						  					<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="emailStatus" value="deny">수신거부
											  </label>
											</div>																			
								  		</td>
								  		<th>회원등급</th>
								  		<td>
								  			<select class="form-control" name="memberLevel">
								  				<option value="" selected>선택하기</option>
								  				<option value="ace">ACE</option>
								  				<option value="gold">GOLD</option>
								  				<option value="vip">VIP</option>
								  				<option value="mvg">MVG</option>
								  			</select>							  		
								  		</td>
								  	</tr>
			                      </tbody>
			                    </table>
			                    <br>
		                  	<button class="btn btn-primary mt-2 mt-xl-0" style="float:right;">검색하기</button>
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
		                        	<th>회원등급</th>
									<th>아이디</th>
		                          	<th>성명</th>
		                          	<th>이메일</th>
		                          	<th>전화번호</th>
		                          	<th>관리</th>
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      				<td>
		                      					<c:choose>
		                      						<c:when test="${l.gradeCode eq 'ace' }">
		                      							<label class="badge badge-success">ACE</label>
		                      						</c:when>
		                      						<c:when test="${l.gradeCode eq 'gold' }">
		                      							<label class="badge badge-warning">GOLD</label>
		                      						</c:when>
		                      						<c:when test="${l.gradeCode eq 'vip' }">
		                      							<label class="badge badge-primary">VIP</label>
		                      						</c:when>
		                      						<c:when test="${l.gradeCode eq 'mvg' }">
		                      							<label class="badge badge-danger">MVG</label>
		                      						</c:when>		                      						
		                      					</c:choose>
		                      				</td>
		                      				<td><c:out value="${l.memberId }"/></td>
		                      				<td><c:out value="${l.memberName }"/></td>
		                      				<td><c:out value="${l.email }"/></td>		                      				
		                      				<td><c:out value="${l.phone }"/></td>
											<td>
												<button class="btn btn-lignt">수정</button>
												<button class="btn btn-secondary" onclick="memberDelete('${l.memberId}')">탈퇴</button>
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
		          <!-- 네번째 row div 끝 -->
			</div>
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
<script>
	function memberDelete(str){
		location.href='${path }/admin/memberDelete.do?memberId='+str;
	}
</script>
</body>
</html>