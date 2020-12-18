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
                    <h2>관리자 분류 관리</h2>
                    <p class="mb-md-0" style="text-indent:10px;color:#F2BB9C;">메종 관리자 전용 페이지입니다.</p>
                  </div>
                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;상품관리&nbsp;&gt;&nbsp;카테고리 분류&nbsp;&nbsp;</p>
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
							<a class="btn hvr-hover" data-fancybox-close="" id="enrollCate">카테고리 등록</a>
                            <a class="btn hvr-hover" data-fancybox-close="" id="moveCate">카테고리 수정</a><!--하단 박스로 이동 -->
                         </div>
					</c:if>
                  <div class="col-lg-8">
                  <!-- 상단현황 -->
					<div class="table-main table-responseive">
						<table class="table table-bordered">
							<tbody>
								<tr style="text-align:center;">
									<td>
										<i class="fa fa-list-ul"></i>
										<!-- <i class="fa fa-list -->
									</td>
									<td>
										<i class="fa fa-folder-o"></i>
									</td>
									<td>
										<i class="fa fa-folder-open-o"></i>
									</td>
									<td>
										<i class="fa fa-handshake-o"></i>
									</td>
									
										<!-- <i class="fa fa-list-alt"></i> -->
								</tr>
								<tr style="text-align:center;">
									<td>전체 카테고리<br><span class="badge">${totalCount}</span></td>
									<td>대분류<br><span class="badge">${showCount}</span></td>
									<td>중분류<br><span class="badge">${stockCount}</span></td>
									<td>신규카테고리<br><span class="badge">${todayCount}</span></td>
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
                  	<option value="cate">카테고리별 상품검색</option>
                  	<option value="date">기간별 검색</option>
                  </select>
                  <div id="search-cate">
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="category">
                  		<select id="largeCate" name="searchKeyword">
                  			<option value="">대분류</option>
                  			<option value="주방">주방</option>
			            	<option value="욕실">욕실</option>
			            	<option value="세탁실">세탁실</option>
			            	<option value="현관">현관</option>
			            	<option value="창고">창고</option>
                  		</select>
                  		<select id="mediCate" name="searchKeyword">
                  			<option value="">중분류</option>
                  		</select>
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                  <div id="search-date" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="date">
                  		<input type="text" name="searchKeyword" size="20" placeholder="yyyy-mm-dd"><i class="fa fa-calendar" aria-hidden="true"></i>
                  		<label>~</label>&nbsp;&nbsp;&nbsp;
                  		<input type="text" name="searchKeyword" size="20" placeholder="yyyy-mm-dd"><i class="fa fa-calendar" aria-hidden="true"></i>
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                 </div>
                </div><!-- card-->
               </div>
             </div>
             <br><br>
         <!-- 여기서부터 작성 -->
          <div class="product-item-filter row">
                            <div class="col-12 col-sm-8 text-center text-sm-left">
                                <p>Showing all 7 results</p>
                            </div>
                            <div class="col-12 col-sm-4 text-center text-sm-right">
                                <ul class="nav nav-tabs ml-auto" style="float:right;">
                                    <li>
                                        <a class="nav-link active" id="fath" href="#grid-view" data-toggle="tab"> <i class="fa fa-th" aria-hidden="true"></i> </a>
                                    </li>
                                    <li>
                                        <a class="nav-link" id="listul" href="#list-view" data-toggle="tab"> <i class="fa fa-list-ul" aria-hidden="true"></i> </a>
                                    </li>
                                </ul>
                            </div>
                        </div> 
         <div class="row" id="list-view">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">상품 리스트</p>
                  <div class="table-responsive">
                    <table id="recent-purchases-listing" class="table" style="text-align:center;">
                    <colgroup>
						<col width="5%">
						<col width="12%">
						<col width="20%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="15%">
						<col width="13%">
					</colgroup>
                      <thead>
                        <tr>
                            <th><small>상품번호</small></th>
                            <th colspan="2"><small>상품이름</small></th>
                            <th><small>대분류</small></th>
                            <th><small>중분류</small></th>
                            <th><small>상품요약</small></th>
                            <th><small>상품노출</small></th>
                            <th><small>재고수량</small></th>
                            <th><small>가격</small></th>
                            <th><small>주기</small></th>
                            <th><small>상품등록일</small></th>
                            <th><small>상품수정</small></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${product}" varStatus="i">
                        <tr>
                            <td>${list.productNo}</td>
                            <td><img src="${path}/resources/upload/product/${list.productImg}" style="width:50px;"></td>
                            <td width="10" style="text-overflow:ellipsis; overflow: hidden;"><span>${list.productName}</span></td>
                            <td>${list.largeCate}</td>
                            <td>${list.mcName}</td>
                            <td width="10" style="text-overflow:ellipsis; overflow: hidden;"><span>${list.productSummary}</span></td>
                            <td>${list.productStatus}</td>
                            <td>${list.productStock}</td>
                            <td>${list.price}</td>
                            <td>${list.defCycle}</td>
                            <td>${list.productDate}</td>
                            <td>
                            	<input type="hidden" name="pno" id="pno" value="${list.productNo}">
                            	<a class="btn hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no=${list.productNo}">답글달기</a>
                            	<br><br>
                            	<a class="btn hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no=${list.productNo}">수정하기</a>
                           	</td>
                        </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
            <div id="pageBar">
	        		${pageBar }	        
        	</div>
		<br><br>        
        <!--그리드형식 -->
        <div class="row" id="grid-view">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">카테고리 수정</p>
                  
                  
                </div>
              </div>
           </div>       
        </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
</div>
</div>
<script>
	$(document).ready(function(){
		
		$("#moveCate").click(function(){
				var offset = $("#grid-view").offset(); 
		     $('html').animate({scrollTop : offset.top}, 1000);
		});
		$("#fath").click(function(){
				$("#list-view").hide();
				$("#grid-view").show();
		});
		$("#listul").click(function(){
				$("#grid-view").hide();
				$("#list-view").show();
		})
	});
$(function(){
	$("#list-view").hide();
	var tr = $("#recent-purchases-listing tbody tr");
	
	tr.click(function(e){
		location.href="#";
	});
	
	//searchType change
	$("#searchType").change(function(e){
		let cate=$("#search-cate");
		let date = $("#search-date");
		
		cate.css("display","none");
		date.css("display","none");
		
		let value = $(e.target).val();
		$("#search-"+value).css("display","inline-block");
	});
	
	//카테고리 팝업
	$("#enrollCate").click(function(){
    			if(confirm("카테고리를 추가로 등록하시겠습니까?")){
    				window.open("${path}/admin/product/moveEnrollCate.do", "카테고리등록", "width=550, height=450, toolbar=no, menubar=no, scrollbars=no, resizable=no");
				}
    		})
});
</script>
<style>
	#list-view{position:relative;}
	#grid-view{position:relative;top:-40px;}
	ul li{
		padding-bottom:20px;
	}
	/* default css */
	.fa-calendar{position:relative;left:-20px;}
	  #searchType{margin-left:17%;height:25px;}
	  #largeCate{height:25px;width:170px;}
	  #mediCate{height:25px;width:170px;}
	  div#search-cate{display:inline-block;margin-left:5px;}
	  div#search-date{display:none;margin-left:10px;}
	  .btn{
	  	float:right;
	  }
	#enrollCate{
   		background:#F2BB9C;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #enrollCate:hover{
    	color:#ffffff;
    	border:0px;
    }
    #moveCate{
    	background:#FCF7E1;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #moveCate:hover{
    	color:#ffffff;
    	border:0px;
    }
	 table tr td:hover{
    	background-color:#FCF7E1;
    }
    table{
    	table-layout:fixed;
    }
    th small{
    	writing-mode:tb-rl;
    	padding-top:0px;
    }
    .badge{
    	font-weight:bold;
    }
    #recent-purchases-listing tr:hover{
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
</style>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
</html>