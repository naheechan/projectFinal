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
<title>취소관리 > 취소처리</title>
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
		                    <h2>취소 처리</h2>
		                    <br>
		                    <fmt:formatDate value="${order.orderDate }" pattern="yyyy-MM-dd" var="fmtorDate"/>
		                    <fmt:formatDate value="${order.cancelDate }" pattern="yyyy-MM-dd" var="fmtcanDate"/>
		                    <p class="mb-md-0">주문번호 : ${order.orderNo }</p>
		                    <p class="mb-md-0">주문일자 : ${fmtorDate }</p>
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
		                        	<th>신청일</th>
		                          	<th>주문자</th>
		                          	<th>상품명</th>
		                          	<th>수량</th>
		                          	<th>금액</th>
		                          	<th>주문상태</th>     
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty orderMap }">
		                      		<c:forEach items="${orderMap }" var="l" varStatus="vs">
		                      			<tr>	
		                      				<td><c:out value="${fmtcanDate }"/></td>
		                      				<td><c:out value="${l.MEMBERID }"/></td>
		                      				<td>
		                      					<img width="30" height="30" src="${path }/resources/upload/product/${l.PRODUCTIMG }">
		                      					<c:out value="${l.PRODUCTNAME }"/>
		                      				</td>
		                      				<td><c:out value="${l.ODAMOUNT }"/></td>
		                      				<c:set var="pri" value="${l.PRICE }"/>
		                      				<c:set var="amo" value="${l.ODAMOUNT }"/>
		                      				<td>${pri*amo }</td>
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
		                      			</tr>
		                      		</c:forEach>
		                      	</c:if>
	                      	  </tbody>
		                    </table>
		                  </div>	                  
		                  <br>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 네번째 row div 끝 -->
		          <br/>
		          <br/>
		          <div class="row">
		          	<div class="col-lg-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <h4 class="card-title">결제정보</h4>
		                  <p class="card-description">
		                    주문상세정보화면의 결제 최종정보입니다. 취소, 반품, 교환시 참고하여 환불금액을 계산 하시면 됩니다.
		                  </p>
		                  <div class="table-responsive pt-3">
		                    <table class="table table-bordered">
		                      <thead>
		                        <tr>
		                          <th>주문금액</th>
		                          <th>사용적립금</th>
		                          <th>적립혜택</th>
		                          <th>최종금액</th>
		                        </tr>
		                      </thead>
		                      <tbody>
								<c:if test="${not empty order }">
									<fmt:formatNumber value="${order.orderPrice }" pattern="#,###" var="oPrice"/>
									<fmt:formatNumber value="${order.useMile }" pattern="#,###" var="uMile"/>
									<fmt:formatNumber value="${order.stackMile }" pattern="#,###" var="sMile"/>
									<fmt:formatNumber value="${order.totalPrice }" pattern="#,###" var="tPrice"/>
									<td><c:out value="${oPrice }"/>&nbsp;원</td>
									<td>(-)&nbsp;<c:out value="${uMile }"/></td>
									<td>(+)&nbsp;<c:out value="${sMile }"/></td>
									<td><c:out value="${tPrice }"/>&nbsp;원</td>
								</c:if>
		                      </tbody>
		                    </table>
		                    <br/>
		                    <button class="btn btn-primary mt-2 mt-xl-0" style="float:right;" type="button" onclick="location.href='${path}/admin/order/cancelDetailEnd.do?orderNo=${order.orderNo }'">취소처리하기</button>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
			</div>
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>