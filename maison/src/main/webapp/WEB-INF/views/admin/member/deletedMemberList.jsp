<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date,java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%
	//한달전 날짜 구하기
		Calendar mon = Calendar.getInstance();
		mon.add(Calendar.MONTH , -1);
		String beforeMonth = new java.text.SimpleDateFormat("yyyy-MM-dd").format(mon.getTime());
%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>탈퇴 회원 관리</title>
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
<!-- datepicker -->
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
			                    <h2>탈퇴 회원 관리</h2>
			                    <br>
			                    <p class="mb-md-0">쇼핑몰 회원탈퇴 페이지에서 직접 탈퇴하거나 회원관리 > 회원관리 목록에서 관리자가 탈퇴 처리 한 회원들의 목록을 관리 할 수 있으며, </p>
			                    <p class="mb-md-0">아이디/탈퇴일을 입력하여 검색할 수 있습니다.</p> 
			                  </div>
	
			                </div>
			                <div class="d-flex justify-content-between align-items-end flex-wrap">
			                  <div class="d-flex">
			                    <i class="mdi mdi-home text-muted hover-cursor"></i>
			                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;</p>
			                    <p class="text-primary mb-0 hover-cursor">탈퇴 회원 관리</p>
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
			                  <h4 class="card-title">탈퇴회원검색</h4>
			                  <div class="table-responsive pt-3">
			                  	<form action="${path }/admin/deletedMemberList.do">
				                    <table class="table table-bordered">
				                      <tbody>
									  	<tr>
									  		<th>아이디</th>
									  		<td>
									  			<div class="form-group" style="margin:0;">									 	
										  			<input type="text" name="keyword" class="form-control"/>									  			
									  			</div>
									  		</td>
									  		<th>탈퇴일</th>
									  		<td>
												<div class="form-row">
													<div class="form-group" style="margin:0;">
														<c:set var="today" value="<%=new Date()%>"/>									
														<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today"/>
														<input class="form-control" type="date" id="startDate" name="startDate" value="<%=beforeMonth%>">
														&nbsp;
													</div>	
													&nbsp;~&nbsp;
													<div class="form-group" style="margin:0;">
														<input class="form-control" type="date" id="endDate" name="endDate" value="${today }">																								
													</div>
												</div>										
									  		</td>
									  	</tr>
				                      </tbody>
				                    </table>
				                    <br>
			                  	<button class="btn btn-primary mt-2 mt-xl-0" style="float:right;" type="submit">검색하기</button>
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
			                  <p class="card-title">탈퇴 회원 정보</p>
				              <br/>
			                  <div class="table-responsive">
			                    <table id="recent-purchases-listing" class="table">
			                      <thead>
			                        <tr>
			                        	<th>아이디</th>
										<th>탈퇴사유</th>
			                          	<th>탈퇴일</th>	                       
			                        </tr>
			                      </thead>
			                      <tbody id="recent-purchases-tbody">
			                      	<c:if test="${not empty list }">
			                      		<c:forEach items="${list }" var="l" varStatus="vs">
			                      			<tr>
			                      				<td><c:out value="${l.memberId }"/></td>
			                      				<td>			                   					
			                      					<c:if test="${empty l.mwReason }">
			                      						(없음)
			                      					</c:if>
			                      					<c:if test="${not empty l.mwReason}">
			                      						<c:out value="${l.mwReason }"/>
			                      					</c:if>
			                      				</td>
			                      				<fmt:formatDate value="${l.mvDate}" pattern="yyyy-MM-dd" var="fmtMvDate"/>
			                      				<td><c:out value="${fmtMvDate }"/></td>			                      			

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

</body>
</html>