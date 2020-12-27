<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>  
<%@page import="java.util.Date,java.util.Calendar"%>
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
<title>취소관리</title>
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
		                    <h2>취소 관리</h2>
		                    <br>
		                    <p class="mb-md-0">회원이 취소 신청한 주문을 검색,취소 완료 처리하여 관리할 수 있으며, </p>
		                    <p class="mb-md-0">취소 처리가 완료된 주문을 확인하실 수 있습니다. </p> 
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;주문관리/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">취소 관리</p>
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
		                  <h4 class="card-title">취소 검색</h4>
		                  <div class="table-responsive pt-3">
		                  	<form action="${path }/admin/order/cancelList.do">
			                    <table class="table table-bordered">
			                      <tbody>
								  	<tr>
								  		<th>검색어</th>
								  		<td>
								  			<div class="form-row">
	    									<div class="col">		
									  			<select class="form-control" name="type">
									  				<option value="" selected>선택하기</option>
									  				<option value="memberId">주문자</option>
									  				<option value="orderNo">주문번호</option>
									  			</select>
								  			</div>
								  			<div class="col">
									  			<input type="text" name="keyword" class="form-control"/>
								  			</div>
								  			</div>
								  		</td>
								  		<th>진행상태</th>
								  		<td>
								  			<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="orderStatus" value="">전체
											  </label>
											</div>							  		
								  			<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="orderStatus" value="c">취소신청
											  </label>
											</div>
						  					<div class="form-check-inline">
											  <label class="form-check-label">
											    <input type="radio" class="form-check-input" name="orderStatus" value="d">취소완료
											  </label>
											</div>										
								  		</td>
								  	</tr>
								  	<tr >
								  		<th>취소신청일(취소접수일)</th>
								  		<td colspan="3">
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
		                  	<button class="btn btn-primary mt-2 mt-xl-0" type="submit" style="float:right;">검색하기</button>
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
		                  <p class="card-title">취소내역</p>
			              <br/>
		                  <div class="table-responsive">
		                    <table id="recent-purchases-listing" class="table">
		                      <thead>
		                        <tr>
		                        	<th>취소일자</th>
									<th>주문번호</th>
		                          	<th>주문자</th>
		                          	<th>주문액</th>
		                          	<th>주문상태</th>
		                          	<th>취소처리</th>
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      			<fmt:formatDate value="${l.CANCELDATE}" pattern="yyyy-MM-dd" var="fmtDate"/>
		                      				<td><c:out value="${fmtDate }"/></td>
		                      				<td><c:out value="${l.ORDERNO }"/></td>
		                      				<td><c:out value="${l.MEMBERID }"/></td>
											<td><c:out value="${l.TOTALPRICE }"/></td>
		                      				<td>
		                      					<c:choose>
		                      						<c:when test="${l.ORDERSTATUS eq 'c' }">
		                      							<label class="badge badge-warning">취소신청</label>
		                      						</c:when>
		                      						<c:when test="${l.ORDERSTATUS eq 'd' }">
		                      							<label class="badge badge-danger">취소완료</label>
		                      						</c:when>                      						
		                      					</c:choose>
		                      				</td>
											<td>
												<c:choose>
													<c:when test="${l.ORDERSTATUS eq 'c' }">
														<button class="btn btn-secondary" onclick="location.href='${path }/admin/order/cancelDetail.do?orderNo=${l.ORDERNO }'" type="button">처리</button>
													</c:when>
													<c:when test="${l.ORDERSTATUS eq 'd'}">
														처리완료
													</c:when>
												</c:choose>
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
</body>
</html>