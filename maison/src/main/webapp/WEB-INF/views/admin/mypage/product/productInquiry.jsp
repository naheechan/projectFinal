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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="${path}/resources/js/datepickerSettings.js"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
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
                    <h2>관리자 상품 문의 관리</h2>
                    <p class="mb-md-0" style="text-indent:10px;color:#F2BB9C;">메종 관리자 전용 페이지입니다.</p>
                  </div>
                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;상품관리&nbsp;&gt;&nbsp;상품문의&nbsp;&nbsp;</p>
                  </div>
                </div>
              </div>
            </div>
          </div><!-- 상단 meta -->
         <!-- 여기서부터 작성 -->
         <div class="row">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">현황</p>
					<!-- 관리자일경우에만 상품등록버튼 보이게 -->
                    <c:if test="${loginMember.memberId ne null && loginMember.memberId eq 'admin' }">
                        <div class="btn">
							<a class="btn hvr-hover" data-fancybox-close="" id="moveInq">문의 수정</a>
                            <a class="btn hvr-hover" data-fancybox-close=""  id="detailInq" href="${ path }/shop/shopView.do">답글 작성</a>
                         </div><!-- 1. tr클릭하면 해당 productNo로 답글작성바로 이동하게끔, 2.user문의삭제 3.내가쓴답변 수정삭제 -->
					</c:if>
                  <div class="col-lg-8">
                  <!-- 상단현황 -->
					<div class="table-main table-responseive">
						<table class="table table-bordered" id="status-list">
							<tbody>
								<tr style="text-align:center;">
									<td>
										<i class="fa fa-list-ul"></i>
										<!-- <i class="fa fa-list -->
									</td>
									<td>
										<i class="fa fa-question"></i>
									</td>
									<td>
										<i class="fa fa-check"></i>
									</td>
									<td>
										<i class="fa fa-trash-o"></i>
									</td>
									<td>
										<i class="fa fa-envelope-o"></i>
									</td>
										<!-- <i class="fa fa-list-alt"></i> -->
								</tr>
								<tr style="text-align:center;">
									<td><a class="color" id="all" name="iqshow" href="#inquiry-list">전체 문의</a><br><span class="badge">${totalCount}</span></td>
									<td><a class="color" id="no" name="iqshow" href="#inquiry-list">미답변</a><br><span class="badge">${noRepData}</span></td>
									<td><a class="color" id="yes" name="repshow" href="#reply-list">답변완료</a><br><span class="badge">${yesRepData}</span></td>
									<td><a class="color" id="del" name="iqshow" href="#inquiry-list">삭제된 문의</a><br><span class="badge">${delRepData}</span></td>
									<td><a class="color" id="today" name="iqshow" href="#inquiry-list">신규등록문의(오늘)</a><br><span class="badge">${todayCount}</span></td>
								</tr>
							</tbody>
						</table>
					 </div>
                  </div>
               </div>
            </div>
          </div>
       </div>
<br><br>
             
           <div class="row">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">검색</p>
                  <select id="searchType">
                  	<option value="name" <c:out value="${map.searchType eq 'name'?'selected':''}"/>>아이디로 검색</option>
                  	<option value="piContent" <c:out value="${map.searchType eq 'content'?'selected':''}"/>>내용별 검색</option>
                  	<option value="productName" <c:out value="${map.searchType eq 'pdName'?'selected':''}"/>>상품별 검색</option>
                  	<option value="piDate" <c:out value="${map.searchType eq 'date'?'selected':''}"/>>기간별 검색</option>
                  </select>
                  <div id="search-name" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="name">
                  		<select id="cateInq" name="selectCate" value="${map.selectKey}">
                  			<option value="">선택하세요</option>
			            	<option value="상품문의">상품문의</option>
			            	<option value="배송문의">배송문의</option>
                  		</select>
                  		<input type="text" name="searchKeyword" id="searchName" size="35" placeholder="검색하실 회원 아이디를 입력해주세요"
                  		value="${map.keyword}">
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                  <div id="search-piContent" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="piContent">
                  		<input type="text" name="searchKeyword" size="50" placeholder="검색하실 문의 내용을 입력해주세요" value="${map.keyword}">
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                   <div id="search-productName" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="productName">
                  		<input type="text" name="searchKeyword" size="50" placeholder="검색하실 상품명을 입력해주세요" value="${map.keyword}">
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                  <div id="search-piDate" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="piDate">
                  		<input type="date" name="datepicker" size="20" placeholder="yyyy-mm-dd" >
                  		<label>~</label>&nbsp;&nbsp;&nbsp;
                  		<input type="date" name="datepicker2" size="20" placeholder="yyyy-mm-dd">
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                 </div>
                </div><!-- card-->
               </div>
             </div>
             <br><br>
         <!-- 여기서부터 작성 -->
         <a href="#" class="color" name="iqshow">문의</a><a class="color">&nbsp;&nbsp;|&nbsp;&nbsp;</a><a href="#" class="color" name="repshow">답글</a>
		<div class="row" id="inquiry-list">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title"><span id="ReplistName">문의리스트</span></p>
                  <div class="table-responsive">
                    <table id="inquiry-list-table" class="table" style="text-align:center;" name="inquiry-list-table">
                   <colgroup>
						<col width="5%">
						<col width="5%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="10%">
						<col width="5%">
						<col width="5%">
						<col width="15%">
						<col width="5%">
						<col width="10%">
					</colgroup>
                      <thead>
                        <tr>
                            <th><small>문의<br>번호</small></th>
                            <th><small>상품<br>번호</small></th>
                            <th colspan="2"><small>상품<br>정보</small></th>
                            <th><small>문의<br>분류</small></th>
                            <th><small>문의<br>내용</small></th>
                            <th><small>작성자</small></th>
                            <th><small>답변<br>여부</small></th>
                            <th><small>존재<br>여부</small></th>
                            <th><small>문의<br>등록일</small></th>
                            <th><small>회원<br>탈퇴여부</small></th>
                            <th><small>문의<br>편집</small></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${list}" varStatus="i">
                        <tr>
                        	<td>${list.piNo}</td>
                            <td>${list.productNo}</td>
                            <td colspan="2"><img src="${path}/resources/upload/product/${list.productImg}">&nbsp;&nbsp;${list.productName}</td>
                            <td>${list.piCate}</td>
                            <td><span>${list.piContent}</span></td>
                            <td>${list.memberId}</td>
                            <td>${list.piStatus}</td>
                            <td>${list.piDel}</td>
                            <td>${list.piDate}</td>
                            <td>${list.memberStatus}</td>
                            <td onclick="event.cancelBubble=true">
                            	<input type="hidden" name="pino" id="pino" value="${list.piNo}">
                            	<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>
                            	<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no=${list.productNo}">이동</a>
                           	</td>
                        </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div id="pageBar">
	        		${pageBar }	        
        	</div>
          </div>
        
        <!-- 문의+답글 리스트 -->
         <div class="row" id="reply-list">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title"><span id="IQlistName">답글리스트</span></p>
                  <div class="table-responsive">
                    <table id="reply-list-table" class="table" style="text-align:center;" name="reply-list-table">
                   	<colgroup>
						<col width="5%">
						<col width="5%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="10%">
						<col width="5%">
						<col width="5%">
						<col width="15%">
						<col width="5%">
						<col width="20%">
						<col width="15%">
						<col width="5%">
						<col width="10%">
					</colgroup>
                      <thead>
                        <tr>
                            <th><small>문의<br>번호</small></th>
                            <th><small>상품<br>번호</small></th>
                            <th colspan="2"><small>상품<br>정보</small></th>
                            <th><small>문의<br>분류</small></th>
                            <th><small>문의<br>내용</small></th>
                            <th><small>작성자</small></th>
                            <th><small>답변<br>여부</small></th>
                            <th><small>존재<br>여부</small></th>
                            <th><small>문의<br>등록일</small></th>
                            <th><small>답글<br>번호</small></th>
                            <th><small>답글<br>내용</small></th>
                            <th><small>답글<br>등록일</small></th>
                            <th><small>회원<br>탈퇴여부</small></th>
                            <th><small>답글<br>편집</small></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${RepList}" varStatus="r">
                        <tr>
                        	<td>${list.piNo}</td>
                            <td>${list.productNo}</td>
                            <td colspan="2"><img src="${path}/resources/upload/product/${list.productImg}">&nbsp;&nbsp;${list.productName}</td>
                            <td>${list.piCate}</td>
                            <td><span>${list.piContent}</span></td>
                            <td>${list.memberId}</td>
                            <td>${list.piStatus}</td>
                            <td>${list.piDel}</td>
                            <td>${list.piDate}</td>
                            <td>${list.pirNo}</td>
                            <td><span>${list.pirContent}</span></td>
                            <td>${list.pirDate}</td>
                            <td>${list.memberStatus}</td>
                            <td onclick="event.cancelBubble=true">
                            	<input type="hidden" name="pino" id="piNo" value="${list.piNo}">
                            	<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="repbtn" href="${ path }/admin/product/update.do?no=${list.piNo}">답글<br>달기</a>
                            	<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no=${list.piNo}">수정<br>하기</a>
                           	</td>
                        </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div id="pageBar2">
	        		${pageBar2 }	        
        	</div>  
          </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
</div>
<script>
	$(document).ready(function(){
		$("#moveInq").click(function(){
				var offset = $("#inquiry-list").offset(); 
		     $('html').animate({scrollTop : offset.top}, 1000);
		});
	});
	$(function(){
	
	var tr = $("#recent-purchases-listing tbody tr");
	
	tr.click(function(e){
		var no = $(this).find("[type=hidden]").val();
		console.log(no);
		//토글로 내용띄우고 
	});
	
	//searchType change
	$("#searchType").change(function(e){
		let name=$("#search-name");
		let content = $("#search-piContent");
		let pdName = $("#search-productName");
		let date = $("#search-piDate");
		
		name.css("display","none");
		content.css("display","none");
		pdName.css("display","none");
		date.css("display","none");
		
		let value = $(e.target).val();
		$("#search-"+value).css("display","inline-block");
	});
	
	$("[name=iqshow]").click(function(){
		$("#inquiry-list").show();
		$("#reply-list").hide();
	});
	$("[name=repshow]").click(function(){
		$("#inquiry-list").hide();
		$("#reply-list").show();
	})
	
	
	//status-list no/yes/del ajax
	$("#all").click(function(){
		$("#inquiry-list").show();
		var table=$("[name=inquiry-list-table]");
		$("[name=inquiry-list-table]").children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/allList.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("AllList ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
			},
			error:function(){
				console.log("AllList ajax 통신실패");
			}
		});
	});
	$("#today").click(function(){
		$("#inquiry-list").show();
		var table=$("[name=inquiry-list-table]");
		$("[name=inquiry-list-table]").children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/todayEnroll.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("today ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
			},
			error:function(){
				console.log("today ajax 통신실패");
			}
		});
	});
	
	
	
	
	$("#no").click(function(){
		$("#inquiry-list").show();
		var table=$("[name=inquiry-list-table]");
		$("[name=inquiry-list-table]").children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/noreply.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("statusNo ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
			},
			error:function(){
				console.log("statusNo ajax 통신실패");
			}
		});
	});
	
	$("#yes").click(function(){
		$("#reply-list").show();
		var table=$("[name=reply-list-table]");
		$("[name=reply-list-table]").children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/yesreply.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("statusYes ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].pirNo+'</td>'
	                str+='<td>'+data[i].pirContent+'</td>'
	                str+='<td>'+data[i].pirDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
			},
			error:function(){
				console.log("statusYes ajax 통신실패");
			}
		});
	});
	//문의가 삭제되면 답글도 삭제됨->inquiry테이블에 보여주기
	$("#del").click(function(){
		$("#inquiry-list").show();
		var table=$("[name=inquiry-list-table]");
		$("[name=inquiry-list-table]").children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/delreply.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("statusDel ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                if(data[i].piDel=='Y'){
		                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                }
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
			},
			error:function(){
				console.log("statusDel ajax 통신실패");
			}
		});
	});
	
	
	
	
	$("#searchName").val("");
	$("[name=searchKeyword]").val("");
		
	$(document).on("click","#search",function(e){
		$("#inquiry-list").show();
		var table=$("[name=inquiry-list-table]");
		$("[name=inquiry-list-table]").children('tbody').empty();
		var frm = $(e.target).parent();
		var searchfrm= frm.serializeArray();
		console.log(searchfrm);
		$.ajax({
			url:"${path}/admin/mypage/product/search.do",
			data:searchfrm,
			type:"post",
			dataType:"json",
			success:function(data){
		/* frm.submit(); */
				console.log("search ajax통신 성공"+data);
				var str="";
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].piNo+'</td>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].piCate+'</td>'
	                str+='<td><span>'+data[i].piContent+'</span></td>'
	                str+='<td>'+data[i].memberId+'</td>'
	                str+='<td>'+data[i].piStatus+'</td>'
	                str+='<td>'+data[i].piDel+'</td>'
	                str+='<td>'+data[i].piDate+'</td>'
	                str+='<td>'+data[i].memberStatus+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pino" id="pino" value="'+data[i].piNo+'">'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="delbtn" href="javascript:void(0)">삭제</a>'
	                str+='<a class="btn hvr-hover rowbtn" data-fancybox-close=""  id="modibtn" href="${ path }/shop/shopDetail.do?no='+data[i].productNo+'">이동</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
				$("#searchName").val("");
				$("[name=searchKeyword]").val("");
				$("#cateInq").find('option:eq(0)').prop("selected",true);
			},
			error:function(){
				console.log("search ajax통신 실패");
			}
		})
	})
});
</script>
<style>

	#inquiry-list{display:inline-block;}
	#reply-list{display:none;}
	.color{
		color:#000000;
	}
	.rowbtn{
    	color:#F2BB9C;
    	text-align:center;
	}
	#moveInq{
   		background:#F2BB9C;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #moveInq:hover{
    	color:#ffffff;
    	border:0px;
    }
    #detailInq{
    	background:#FCF7E1;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #detailInq:hover{
    	color:#ffffff;
    	border:0px;
    }
	/* default css */
	  .fa-calendar{position:relative;left:-20px;}
	  #searchType{margin-left:17%;height:25px;}
	  #cateInq{height:25px;width:120px;}
	  div#search-name{display:inline-block;}
	  div#search-piContent{display:none;margin-left:10px;}
	  div#search-productName{display:none;margin-left:10px;}
	  div#search-piDate{display:none;margin-left:10px;}
	  .btn{
	  	float:right;
	  }
	 table tr td:hover{
    	background-color:#FCF7E1;
    }
    table{
    	table-layout:fixed;
    }
    #inquiry-list-table tr td{
    width:200px;
    padding:0 5px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
    }
    #reply-list-table tr td{
    width:200px;
    padding:0 5px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
    }
    th small{
    	padding-top:0px;
    }
    .badge{
    	font-weight:bold;
    }
    #inquiry-list-table tr:hover{
    	background-color:#FCF7E1;
    }
    #reply-list-table tr:hover{
    	background-color:#FCF7E1;
    }
    .page-item.active .page-link{
    	background:#F2BB9C;
    	border-color:#F2BB9C;
    	color:#ffffff;
    }
    .page-link{
    	color:#F2BB9C;
    }
    .page-link:hover{
    	color:#F2BB9C; 
    }
    .list-group-item {
 		border:none;
 		color:#000000;
	}
	.text-center p{
		 float:left;
		 margin-left:10px;
	}
	.product-item-filter {
	    border:none;
    }
</style>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>