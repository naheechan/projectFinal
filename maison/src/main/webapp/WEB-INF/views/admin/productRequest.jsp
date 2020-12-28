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
		 <div class="main-panel">
		 	<div class="content-wrapper">
		 		<div class="row">
				 	<div class="col-lg-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <h4 class="card-title">입고 요청 목록(<c:out value="${totalContents }"/>)</h4>	
		                        
		                  <p class="card-description">
		                    <%-- Add class <code>.table-hover</code> --%>
		                  </p>
			               <form name="checkStatusFrm" action="${path }/admin/productRequest.do">
								<div class="form-group" style="float:right;">
									<select class="form-control" name="requestStatus" id="requestStatus">
									<c:choose>
										<c:when test="${requestStatus eq 'N' }">
											<option selected value="N">미처리</option>
											<option value="">전체보기</option>
											<option value="P">처리중</option>
											<option value="Y">처리완료</option>
										</c:when>
										<c:when test="${requestStatus eq 'P' }">
											<option selected value="P">처리중</option>
											<option value="">전체보기</option>
											<option value="N">미처리</option>
											<option value="Y">처리완료</option>												
										</c:when>
										<c:when test="${requestStatus eq 'Y' }">
											<option selected value="Y">처리완료</option>
											<option value="">전체보기</option>
											<option value="N">미처리</option>												
											<option value="P">처리중</option>
										</c:when>	
										<c:otherwise>
											<option selected value="">전체보기</option>
											<option value="N">미처리</option>												
											<option value="P">처리중</option>
											<option value="Y">처리완료</option>	
										</c:otherwise>										
									</c:choose>	
									</select>						
								</div>
							</form>
		                  <div class="table-responsive">
		                    <table class="table table-hover" id="tbl-requestList">
		                      <thead>
		                        <tr>
		                          <th>입고요청 번호</th>
		                          <th>입고요청 회원</th>
		                          <th>입고요청 내용</th>
		                          <th>입고 진행상태</th>
		                          <th>입고요청 날짜</th>
		                        </tr>
		                      </thead>
		                      <tbody>
	                      		<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      				<td>${l.requestNo }</td>
		                      				<td>${l.memberId }</td>
		                      				<td>
	       							            <c:choose>
											        <c:when test="${fn:length(l.requestContent) gt 26}">
											        <c:out value="${fn:substring(l.requestContent, 0, 25)}">...
											        </c:out></c:when>
											        <c:otherwise>
											        <c:out value="${l.requestContent}">
											        </c:out></c:otherwise>
												</c:choose>
		                      				</td>
		                      				<td>
		               
		                      					<c:choose>
		                      						<c:when test="${l.requestStatus eq 'N' }">
		                      							<label class="badge badge-danger">미처리</label>
		                      						</c:when>
		                      						<c:when test="${l.requestStatus eq 'P' }">
		                      							<label class="badge badge-warning">처리중</label>
		                      						</c:when>
		                      						<c:when test="${l.requestStatus eq 'Y' }">
		                      							<label class="badge badge-success">처리완료</label>
		                      						</c:when>
		                      					</c:choose>
		                      				</td>
		                      				<td>
		               		                	<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd" value="${l.requestDate }"/></c:set>
												<c:out value="${dateTempParse }"/>
		                      				</td>
		                      			</tr>
		                      		</c:forEach>
		                      	</c:if>
		                      </tbody>
		                    </table>
		                    <br/>
		                    <h5>※ 입고 진행상태를 변경하시려면 해당 요청의 행을 클릭하세요.</h5>  
		                  </div>
		                  <br/>
		                  <div id="pageBar">
		                  	${pageBar }
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
<script>
$(function(){
	$("#tbl-requestList tr").click(function(){
		var str="";
		var tdArr = new Array();
		var tr = $(this);
		var td = tr.children();
		var no = td.eq(0).text();
		window.name="parentForm";
		openWin= window.open('${path }/admin/requestView?no='+no,'입고요청 세부내용','width=440,height=320,scrollbars=no,left=200,top=50,resizable=no');
	})
	
	$("#requestStatus").on('change',function(){
		$(this).closest('form[name=checkStatusFrm]').submit();
	})
})
</script>
</body>
</html>