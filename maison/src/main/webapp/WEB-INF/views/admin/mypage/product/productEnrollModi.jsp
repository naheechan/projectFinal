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
                    <h2>관리자 상품관리</h2>
                    <p class="mb-md-0" style="text-indent:10px;color:#F2BB9C;">메종 관리자 전용 페이지입니다.</p>
                  </div>
                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;상품관리&nbsp;&gt;&nbsp;상품등록, 수정&nbsp;&nbsp;</p>
                  </div>
                </div>
              </div>
            </div>
          </div><!-- 상단 meta -->
          <div class="row">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">현황</p>
					<!-- 관리자일경우에만 상품등록버튼 보이게 -->
                    <c:if test="${loginMember.memberId ne null && loginMember.memberId eq 'admin' }">
                        <div class="btn">
                            <a class="btn hvr-hover" data-fancybox-close=""  id="enrollbtn" href="${ path }/admin/product/productEnroll.do">상품등록</a>
							<a class="btn hvr-hover" data-fancybox-close="" id="movemodi">상품수정</a>
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
										<i class="fa fa-eye-slash"></i>
									</td>
									<td>
										<i class="fa fa-cubes"></i>
									</td>
									<td>
										<i class="fa fa-line-chart"></i>
									</td>
									
										<!-- <i class="fa fa-list-alt"></i> -->
								</tr>
								<tr style="text-align:center;">
									<td><a class="color" id="all" href="#recent-purchases-listing">전체 상품</a><br><span class="badge">${totalCount}</span></td>
									<td><a class="color" id="show" href="#recent-purchases-listing">진열 상품</a><br><span class="badge">${showCount}</span></td>
									<td><a class="color" id="stock" href="#recent-purchases-listing">재고 수량(<small>5개↓</small>)</a><br><span class="badge">${stockCount}</span></td>
									<td><a class="color" id="today" href="#recent-purchases-listing">오늘등록상품</a><br><span class="badge">${todayCount}</span></td>
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
                  	<option value="productName">상품명으로 검색</option>
                  	<option value="popular">Top3 검색</option>
                  	<option value="productDate">기간별 검색</option>
                  </select>
                  <div id="search-productName" >
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="productName">
                  		<input type="text" name="searchKeyword" id="searchName" size="50" placeholder="검색하실 상품이름을 입력해주세요">
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                  <div id="search-popular">
                  	<form action="" id="pop">
                  		<input type="hidden" name="searchType" value="popular">
                  		<label for="3"><input type="radio"  id="3" name="searchKeyword" >&nbsp;전체</label>
                  		<c:forEach var="p" items="${popular}" varStatus="i" begin="0" end="2">
                  		<label for="${i.index}"><input type="radio"  id="${i.index}" name="searchKeyword" ><strong>&nbsp;${i.index+1}위.</strong>&nbsp;${p.productName}</label>
                  		<input type="hidden" name="name" value="${p.productName}">
                  		</c:forEach>
                  	</form>
                  </div>
                  <script>
                  $(function(){
		                  	$("#0, #1, #2").click(function(){
		                  		var val = $(this).parents().next().val();
		                  		var table=$("[name=searchList]");
		                		table.children('tbody').empty();
	                  		$.ajax({
	                  			url:"${path}/admin/mypage/product/searchTop3.do",
	                  			data:{val:val},
	                  			type:"post",
	                  			dataType:"json",
	                  			success:function(data){
	                  				console.log("searchtop3 ajax통신성공");
	                  				var str="";
	                  				$.each(data,function(i){
	                  					str+='<tr>'
	                	                str+='<td>'+data[i].productNo+'</td>'
	                	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                	                str+='<td>'+data[i].largeCate+'</td>'
	                	                str+='<td>'+data[i].mcName+'</td>'
	                	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                	                str+='<td>'+data[i].productStatus+'</td>'
	                	                str+='<td>'+data[i].productStock+'</td>'
	                	                str+='<td>'+data[i].price+'</td>'
	                	                str+='<td>'+data[i].defCycle+'</td>'
	                	                str+='<td>'+data[i].productDate+'</td>'
	                	                str+='<td onclick="event.cancelBubble=true">'
	                	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                	                str+='</td>'
	                	                str+='</tr>'
	                  				});
	                  				$("th:first-child").replaceWith("<th><small>상품<br>번호</small></th>");
	                	                	table.append(str);
	                  			},
	                  			error:function(){
	                  				console.log("searchtop3 ajax통신실패");
	                  			}
	                  		});	
                	  })
                	  $("#3").click(function(){
	                  		var valFrm=$(this).parents().children().find('[name=name]').serializeArray();
	                  		console.log(valFrm);
	                  		var table=$("[name=searchList]");
	                		table.children('tbody').empty();
	                  		$.ajax({
	                  			url:"${path}/admin/mypage/product/searchTopAll.do",
	                  			data:valFrm,
	                  			type:"post",
	                  			dataType:"json",
	                  			success:function(data){
	                  				console.log("searchtop3전체 ajax통신성공");
	                  				var str="";
	                  				$.each(data,function(i){
	                  					str+='<tr>'
	                	                str+='<td>'+[i+1]+'</td>'
	                	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                	                str+='<td>'+data[i].largeCate+'</td>'
	                	                str+='<td>'+data[i].mcName+'</td>'
	                	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                	                str+='<td>'+data[i].productStatus+'</td>'
	                	                str+='<td>'+data[i].productStock+'</td>'
	                	                str+='<td>'+data[i].price+'</td>'
	                	                str+='<td>'+data[i].defCycle+'</td>'
	                	                str+='<td>'+data[i].productDate+'</td>'
	                	                str+='<td onclick="event.cancelBubble=true">'
	                	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                	                str+='</td>'
	                	                str+='</tr>'
	                  				});
	                  				$("th:first-child").replaceWith("<th><small>판매<br>순위</small></th>");
	                	                	table.append(str);
	                  			},
	                  			error:function(){
	                  				console.log("searchtop3전체 ajax통신실패");
	                  			}
	                  		});	
                	  })
              });
                  </script>
                  <div id="search-productDate">
                  	<form action="${path}/admin/mypage/product/search.do" id="pddate">
                  		<input type="hidden" name="searchType" value="productDate">
                  		<input type="date" id="datepicker" name="datepicker" size="20">
                  		<label>~</label>&nbsp;
                  		<input type="date" id="datepicker2" name="datepicker2" size="20">&nbsp;
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                 </div>
                </div><!-- card-->
               </div>
             </div>
             <br><br>
         <!-- 여기서부터 작성 -->
         <div class="row" id="product-list">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">전체 상품 리스트</p>
                  <div class="table-responsive">
                    <table id="recent-purchases-listing" class="table" style="text-align:center;" name="searchList">
                    <colgroup>
						<col width="7%">
						<col width="10%">
						<col width="18%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="15%">
						<col width="12%">
					</colgroup>
                      <thead>
                        <tr>
                            <th><small>상품<br>번호</small></th>
                            <th colspan="2"><small>상품<br>정보</small></th>
                            <th><small>대분류</small></th>
                            <th><small>중분류</small></th>
                            <th><small>상품<br>요약</small></th>
                            <th><small>상품<br>노출</small></th>
                            <th><small>재고<br>수량</small></th>
                            <th><small>가격</small></th>
                            <th><small>주기</small></th>
                            <th><small>상품<br>등록일</small></th>
                            <th><small>상품<br>편집</small></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${product}" varStatus="i">
                        <tr>
                            <td>${list.productNo}</td>
                            <td><img src="${path}/resources/upload/product/${list.productImg}" style="width:50px;"></td>
                            <td><span>${list.productName}</span></td>
                            <td>${list.largeCate}</td>
                            <td>${list.mcName}</td>
                            <td><span>${list.productSummary}</span></td>
                            <td>${list.productStatus}</td>
                            <td>${list.productStock}</td>
                            <td>${list.price}</td>
                            <td>${list.defCycle}</td>
                            <td>${list.productDate}</td>
                            <td onclick="event.cancelBubble=true">
                            	<input type="hidden" name="pno" id="pno" value="${list.productNo}">
                            	<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no=${list.productNo}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>수정</a>
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
        </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
</div>
<script>
$(document).ready(function(){
	$("#movemodi").click(function(){
			var offset = $("#product-list").offset(); 
	     $('html').animate({scrollTop : offset.top}, 1000);
		});
});
	function productView(){
		var tr = $("#recent-purchases-listing tbody tr");
		tr.click(function(e){
			var no = $(this).find("[type=hidden]").val();
			console.log(no);
			location.href="${ path }/admin/product/productView.do?no="+no;
		});
	};
$(function(){
	document.getElementById('datepicker').value= new Date().toISOString().slice(0, 10);
	document.getElementById('datepicker2').value= new Date().toISOString().slice(0, 10);
	
	productView();
	
	var td = $(".badge").parent();
	td.click(function(e){
		var offset = $("#recent-purchases-listing_wrapper").offset(); 
	     $('html').animate({scrollTop : offset.top}, 1000);
	});
	
	//searchType change
	$("#searchType").change(function(e){
		let name=$("#search-productName");
		let popular = $("#search-popular");
		let date = $("#search-productDate");
		
		name.css("display","none");
		popular.css("display","none");
		date.css("display","none");
		
		let value = $(e.target).val();
		$("#search-"+value).css("display","inline-block");
	});
	
	/* function searchNameProduct(nameFrm){
		$.ajax({
			url:"${path}/admin/mypage/product/search.do",
			data:nameFrm,
			type:"post",
			dataType:"json",
			success:function(data){
				console.log("ajax통신성공"+data);
				
			},
			error:function(){
				console.log("ajax통신실패");
			}
		})
	}; */
	
	/* $(document).on("click",$("[name=search]"),function(e){
		var nameFrm = $("form[name='search-name']").serializeArray();
		searchNameProduct(nameFrm);
		console.log(nameFrm);
	}) */

	
	//all show stock today
	$("#all").click(function(){
		
		var table=$("[name=searchList]");
		table.children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/allPdList.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("AllProductList ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].largeCate+'</td>'
	                str+='<td>'+data[i].mcName+'</td>'
	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                str+='<td>'+data[i].productStatus+'</td>'
	                str+='<td>'+data[i].productStock+'</td>'
	                str+='<td>'+data[i].price+'</td>'
	                str+='<td>'+data[i].defCycle+'</td>'
	                str+='<td>'+data[i].productDate+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
					productView();
			},
			error:function(){
				console.log("AllProductList ajax 통신실패");
			}
		});
	});
	
	$("#today").click(function(){
		var table=$("[name=searchList]");
		table.children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/todayPdEnroll.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("today ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].largeCate+'</td>'
	                str+='<td>'+data[i].mcName+'</td>'
	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                str+='<td>'+data[i].productStatus+'</td>'
	                str+='<td>'+data[i].productStock+'</td>'
	                str+='<td>'+data[i].price+'</td>'
	                str+='<td>'+data[i].defCycle+'</td>'
	                str+='<td>'+data[i].productDate+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
					productView();
			},
			error:function(){
				console.log("today ajax 통신실패");
			}
		});
	});
	
	$("#show").click(function(){
		var table=$("[name=searchList]");
		table.children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/pdStatus.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("today ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].largeCate+'</td>'
	                str+='<td>'+data[i].mcName+'</td>'
	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                str+='<td>'+data[i].productStatus+'</td>'
	                str+='<td>'+data[i].productStock+'</td>'
	                str+='<td>'+data[i].price+'</td>'
	                str+='<td>'+data[i].defCycle+'</td>'
	                str+='<td>'+data[i].productDate+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
					productView();
			},
			error:function(){
				console.log("today ajax 통신실패");
			}
		});
	});
	$("#stock").click(function(){
		var table=$("[name=searchList]");
		table.children('tbody').empty();
			$.ajax({
			url:"${path}/admin/mypage/product/pdStock.do",
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				console.log("today ajax 통신성공"+data);
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].largeCate+'</td>'
	                str+='<td>'+data[i].mcName+'</td>'
	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                str+='<td>'+data[i].productStatus+'</td>'
	                str+='<td>'+data[i].productStock+'</td>'
	                str+='<td>'+data[i].price+'</td>'
	                str+='<td>'+data[i].defCycle+'</td>'
	                str+='<td>'+data[i].productDate+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
					productView();
			},
			error:function(){
				console.log("today ajax 통신실패");
			}
		});
	});
	
	$("#searchName").val("");
	$("[name=searchKeyword]").val("");
	$(document).on("click","#search",function(e){
		var table = $("[name=searchList]").children('tbody').empty();
		var frm = $(e.target).parent();
		var searchfrm= frm.serializeArray();
		console.log(searchfrm);
		var offset = $("[name=searchList").offset(); 
	     $('html').animate({scrollTop : offset.top}, 1000);
		$.ajax({
			url:"${path}/admin/mypage/product/Enrollsearch.do",
			data:searchfrm,
			type:"post",
			dataType:"json",
			success:function(data){
				console.log("search ajax통신 성공"+data);
				var str="";
				$.each(data,function(i){
					str+='<tr>'
	                str+='<td>'+data[i].productNo+'</td>'
	                str+='<td colspan="2"><img src="${path}/resources/upload/product/'+data[i].productImg+'">&nbsp;&nbsp;'+data[i].productName+'</td>'
	                str+='<td>'+data[i].largeCate+'</td>'
	                str+='<td>'+data[i].mcName+'</td>'
	                str+='<td><span>'+data[i].productSummary+'</span></td>'
	                str+='<td>'+data[i].productStatus+'</td>'
	                str+='<td>'+data[i].productStock+'</td>'
	                str+='<td>'+data[i].price+'</td>'
	                str+='<td>'+data[i].defCycle+'</td>'
	                str+='<td>'+data[i].productDate+'</td>'
	                str+='<td onclick="event.cancelBubble=true">'
	                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">'
	                str+='<a class="hvr-hover" data-fancybox-close=""  id="modibtn" href="${ path }/admin/product/update.do?no='+data[i].productNo+'"><i class="fa fa-pencil-square-o" aria-hidden="true">수정</a>'
	                str+='</td>'
	                str+='</tr>'
					})
					table.append(str);
				$("#searchName").val("");
				$("[name=searchKeyword]").val("");
				//날짜설정
				var startDate = $( "input[name='datepicker']" ).val();
		        var startDateArr = startDate.split('-');
		         
		        var endDate = $( "input[name='datepicker2']" ).val();
		        var endDateArr = endDate.split('-');
		                 
		        var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);
		        var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);
		         
		        if(startDateCompare.getTime() > endDateCompare.getTime()) {
		             
		            swal('',"시작날짜와 종료날짜를 확인해 주세요.");
		             
		            return;
		        }
				productView();
				
			},
			error:function(){
				console.log("search ajax통신 실패");
			}
		})
	});
	
})
</script>
  <style>
  #pddate{width:500px;}
  #pop{width:700px;position:absolute;top:70px;}
  label{margin:0 3% 0 3%;}
  [name=searchList] tr td{
    width:200px;
    padding:0 5px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
    }
  .color{
		color:#000000;
	}
  .fa-calendar{position:relative;left:-20px;}
  #searchType{margin-left:20%;height:25px;}
  #largeCate{height:25px;width:170px;}
  #mediCate{height:25px;width:170px;}
  div#search-productName{display:inline-block; margin-left:10px;}
  div#search-popular{display:none;margin-left:10px;;}
  div#search-productDate{display:none;margin-left:10px;}
    .btn{
    	float:right;
    }
    #enrollbtn{
   		background:#F2BB9C;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #enrollbtn:hover{
    	color:#ffffff;
    	border:0px;
    }
    #movemodi{
    	background:#FCF7E1;
    	color:#000000;
    	border-radius: 5px;
    	width:110px;
    }
    #movemodi:hover{
    	color:#ffffff;
    	border:0px;
    }
    #modibtn{
    	color:#F2BB9C;
    	text-align:center;
    }
    #modibtn:hover{
    	color:#202B3F;
    	font-weight:bold;
    }
    #detailbtn{
   		color:#F2BB9C;
    	text-align:center;
    }
    #detailbtn:hover{
    	color:#202B3F;
    	font-weight:bold;
    }
    table tr td:hover{
    	background-color:#FCF7E1;
    }
    table{
    	table-layout:fixed;
    }
    th small{
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