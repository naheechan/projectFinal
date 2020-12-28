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
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<style>
select {
		width: 150px;
		height:40px;
		padding: 5px;
		border: 1px solid #999;
		font-family: inherit;
		border-radius: 0px;
		color:gray;
	}
#keyword {
		width: 250px;
		height:40px;
		padding: 5px;
		border: 1px solid #999;
		font-family: inherit;
		border-radius: 0px;
		color:gray;

}

</style>

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
                    <h2>관리자 질문 게시판 관리</h2>
                    <p class="mb-md-0" style="text-indent:10px;color:#F2BB9C;">메종 관리자 전용 페이지입니다.</p>
                  </div>
                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;게시판 관리&nbsp;&gt;&nbsp;질문관리&nbsp;&nbsp;</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
      

        <div class="card">
        <div class="card-body">
          <div class="container">
		<br>
		<br>
		</div>
	<div id="notice-container" class="row justify-content-center">
		<div class="col-12 align-self-center">
		<div class="table-main table-responsive">
			<div class="offset-md-4" id="search">
		<form action="${path }/admin/adminQnaSearch.do">
			<c:if test="${select eq null }">
				<select name="select">
					<option value="title" selected>제목</option>
					<option value="both">제목+내용</option>
					<option value="id">아이디</option>
				</select>
			</c:if>
			<c:if test="${select eq 'both' }">
				<select name="select">
					<option value="title">제목</option>
					<option value="both" selected>제목+내용</option>
					<option value="id">아이디</option>
				</select>
			</c:if>
				<c:if test="${select eq 'id' }">
				<select name="select">
					<option value="title">제목</option>
					<option value="both">제목+내용</option>
					<option value="id" selected>아이디</option>
				</select>
			</c:if>
			<c:if test="${not empty keyword }">
				<input type="text" placeholder="검색어를 입력하세요" value="${keyword }" name="keyword" id="keyword">
			</c:if>
			<c:if test="${empty keyword }">
				<input type="text" placeholder="검색어를 입력하세요"  name="keyword" id="keyword">
			</c:if>
			<input type="submit" value="검색" class="btn btn-secondary" style="height:35px">
		</form>
	</div>
			<div>
				<select style="float:right"class="selectpicker show-tick" id="sel">
					<option>보기 방식 변경</option>
					<option value="List">전체 보기</option>
					<option value="미답변">미답변 글보기</option>
				</select>
				<br>
			</div>
			
			<table class="table table-hover">
				<thead>
					<tr>
						<th style="width:20%">번호</th>
						<th style="width:42%">제목</th>
						<th style="width:20%">작성자</th>
						<th style="width:24%">작성일</th>
						
					</tr>
				</thead>
			<c:forEach var="q" items="${list }" varStatus="status">
			            		<c:set var="num" value="${totalData-((cPage-1)*10)-status.index}"/>
			            	<tr>
			            		<td>${num }</td>
			            		<c:if test="${q.qnaSecret eq 'secret'}">
				            		<td>
				            			<script>
				            				
				            			</script>
				            		<a href="${path}/qnaBoard/qnaBoardView.do?no=${q.qnaNO}" style="color:black"><c:out value="${q.qnaTitle }"/>
				            			
				            				<i class="fas fa-lock"></i>
				            				<c:if test="${q.qnaStatus eq '미답변'}">
				            				<span id="qnaStatus" style="color:red;">${q.qnaStatus}</span>
				            				</c:if>
				            				
				            				<c:if test="${q.qnaStatus eq '답변완료'}">
				            				<span id="qnaStatus" style="color:green;">${q.qnaStatus}</span>
				            				</c:if>
				            			</a>
				            		</td>
	
				            		        		
			            		</c:if>

			            		<c:if test="${q.qnaSecret eq 'open'}">
			            			<td>
			            				<a href="${path}/qnaBoard/qnaBoardView.do?no=${q.qnaNO}" style="color:black"><c:out value="${q.qnaTitle }"/>
			            					<c:if test="${q.qnaStatus eq '미답변'}">
				            					<span id="qnaStatus" style="color:red;">${q.qnaStatus}</span>
				            				</c:if>
				            				
				            				<c:if test="${q.qnaStatus eq '답변완료'}">
				            					<span id="qnaStatus" style="color:green;">${q.qnaStatus}</span>
				            				</c:if>
			            				</a>
			            			</td>
			            		</c:if>
			            		<td><c:out value="${q.memberId }"/></td>
			            		<td><c:out value="${q.qnaDate }"/></td>
			           
			            	</tr>
			            	
						<c:set var="num" value="${num-1 }"></c:set>
			
			            </c:forEach>			</table>
		</div>






<div id="page-bar">
	${pageBar }
	</div>
	<br>
        </div>
        </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
	</div>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
<script>
	$(function(){
		$("#sel").change(function(){
			var status=$(this).val();
			console.log(status);
			
			if(status=="List"){
				location.href="${path}/admin/adminQnaList.do";
			}else if(status=="미답변"){
				location.href="${path}/admin/adminQnacomment.do";
			}
			
			
		});
		
	})
</script>
</html>	