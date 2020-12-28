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
  <title>관리자 페이지</title>
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
		<!-- Start MainPanel 여기가 페이지별로 바뀌는 부분  -->
		      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-md-12 grid-margin">
              <div class="d-flex justify-content-between flex-wrap">
                <div class="d-flex align-items-end flex-wrap">
                  <div class="mr-md-3 mr-xl-5">
                    <h2>결제관리 전용 페이지</h2>
                    <p class="mb-md-0">메종 결제관리 전용 페이지입니다.</p>
                  </div>

                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;&nbsp;</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
          
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">Recent Purchases</p>
                  <div class="table-responsive">
                    <table id="recent-purchases-listing" class="table">
                      <thead>
                        <tr>
                            <th>주문번호</th>
                            <th>아이디</th>
                            <th>수령인</th>
                            <th>핸드폰</th>
                            <th>주소</th>
                            <th>주문금액</th>
                            <th>주문날짜</th>
                            <th>결제상태</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${list }" var="o">
                        <tr>
                            <td>${o.orderNo }</td>
                            <td>${o.memberId }</td>
                            <td>${o.receiver }</td>
                            <td>${o.orPhone }</td>
                            <td>
                            	${o.orZipcode }<br>
                            	${o.orAddress }
                            </td>
                            <td>
                            	<fmt:formatNumber value="${o.totalPrice }"/> 원
                            	
                            </td>
                            <td>
                            	<fmt:formatDate var="sysTime" value="${o.orderDate }" pattern="yyyy-MM-dd"/>
                            	<c:out value="${sysTime }"/>
                            </td>
                            <td>
                            	<c:choose>
	           						<c:when test="${o.orderStatus eq 'a' }">
	           							<label class="badge badge-success">주문완료</label>
	           						</c:when>
	           						<c:when test="${o.orderStatus eq 'b' }">
	           							<label class="badge badge-warning">배송완료</label>
	           						</c:when>
	           						<c:when test="${o.orderStatus eq 'c' }">
	           							<label class="badge badge-danger">취소신청</label>
	           						</c:when>
	           						<c:when test="${o.orderStatus eq 'd' }">
	           							<label class="badge badge-primary">취소완료</label>
	           						</c:when>	
           						</c:choose>
                            	
                            </td>
                        </tr>
                       </c:forEach>
                      </tbody>
                    </table>
                  </div><br>
                  
                  	<div>
              			${pageBar }
	                </div>
                  
                </div>
              </div>
              
              
            </div>
        <!-- content-wrapper ends -->
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
	<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>