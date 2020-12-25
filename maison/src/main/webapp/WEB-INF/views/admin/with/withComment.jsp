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
<title>함께해요 댓글 관리</title>
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
		                    <h2>함께해요 댓글 관리</h2>
		                    <br>
		                    <p class="mb-md-0">함께해요 게시판 댓글을 검색/수정/삭제 등의 관리를 할 수 있으며,</p>
		                    <p class="mb-md-0">댓글 목록에서 [게시글 바로가기]버튼을 클릭하면 해당 게시글로 바로 이동합니다. </p> 
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;함께해요 게시판/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">댓글 관리</p>
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
		                  <h4 class="card-title">함께해요 게시판 검색</h4>
		                  <div class="table-responsive pt-3">
		                  	<form action="${path }/admin/with/comment.do">
			                    <table class="table table-bordered">
			                      <tbody>
								  	<tr>
								  		<th>검색어</th>
								  		<td>
								  			<div class="form-row">
	    									<div class="col">		
									  			<select class="form-control" name="type">
									  				<option value="" selected>선택하기</option>
									  				<option value="memberId">작성자</option>
									  				<option value="wcContent">내용</option>
									  			</select>
								  			</div>
								  			<div class="col">
									  			<input type="text" name="keyword" class="form-control"/>
								  			</div>
								  			</div>
								  		</td>
								  			<th>작성일</th>
									  		<td>
												<div class="form-row">
													<div class="form-group" style="margin:0;">
														<c:set var="today" value="<%=new Date()%>"/>									
														<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today"/>
														<input class="form-control" type="date" id="startDate" name="startDate" value="">
														&nbsp;
													</div>	
													&nbsp;~&nbsp;
													<div class="form-group" style="margin:0;">
														<input class="form-control" type="date" id="endDate" name="endDate" value="">																								
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
		                  <p class="card-title">회원정보</p>
			              <br/>
		                  <div class="table-responsive">
		                    <table id="recent-purchases-listing" class="table">
		                      <thead>
		                        <tr>
		                       		<th>등록일</th>
		                        	<th>작성자</th>
									<th>내용</th>		                         
		                          	<th>관련게시글</th>
		                          	<th>관리</th>
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      			<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd" value="${l.wcAddDate }"/></c:set>
		                      				<td>
		                      					<c:out value="${dateTempParse }"/>
		                      				</td>
		                      				<td><c:out value="${l.memberId }"/></td>
		                      				<td><c:out value="${l.wcContent }"/></td>	
		                      				<%-- "${path }/with/withView.do?no="+no --%>	
		                      				<td><a href="${path }/with/withView.do?no=${l.wbNo}" style="color:gray;">게시글 바로가기</a></td>                      				          			
											<td>
												<button class="btn btn-lignt" type="button" onclick="updateBtn(${l.wcNo })">수정</button>
												<button class="btn btn-secondary" type="button" onclick="location.href='${path }/admin/withCommentRemove.do?wcNo=${l.wcNo }'">삭제</button>
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
function updateBtn(num){
	window.name="parentForm";
	openWin= window.open('${path }/admin/withCommentUpdate.do?wcNo='+num,'댓글 수정하기','width=440,height=320,scrollbars=no,left=200,top=50,resizable=no');	
}
</script>
</body>
</html>