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
          <div class="container">
	
		<br>
		<br>
	<div id="notice-container" class="row justify-content-center">
		<div class="col-10 align-self-center">
		<div class="table-main table-responsive">
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width:10%">번호</th>
						<th style="width:55%">제목</th>
						<th style="width:10%">작성자</th>
						<th style="width:14%">날짜</th>
						<th style="width:11%">조회 수</th>
						
					</tr>
				</thead>
				<c:forEach var="n" items="${list }">
					<tbody>
						<tr>
						
							<td>${n.noticeNo }</td>
							<td><a href="${path }/notice/noticeOne.do?noticeNo=${n.noticeNo }">${n.noticeTitle }</a></td>
							<td>관리자</td>
								<!-- 오늘 날짜를 구하기 -->
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<c:set var="sysCal">
									<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" />
								</c:set>
								<c:set var="dateTempParse">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${n.noticeDate }" />
								</c:set>
								<c:if test="${sysCal eq dateTempParse }">
									<fmt:formatDate var="sysTime" value="${n.noticeDate }" pattern="HH:mm" />
									<td><c:out value="${sysTime }" /></td>
									
								</c:if>
								<c:if test="${sysCal ne dateTempParse }">
									<td><c:out value="${dateTempParse }" /></td>
								</c:if>
								<td class="text-center">${n.noticeCount }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
	</div>
	<div class="row justify-content-end">
		<c:if test="${loginMember.memberId eq 'admin' }">
			<button class="btn" onclick="location.href='${path}/notice/noticeAdd.do'"><i class="fas fa-pencil-alt"></i> 글쓰기</button>
		</c:if>
	</div>
	</div>

	<div class="offset-md-7" id="search">
		<input type="text" placeholder="검색어를 입력하세요" name="keyword">
		<input type="submit" value="검색">
	</div>
	<br>




<div id="page-bar">
	${pageBar }
	</div>
	<br>
        </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>	