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
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
  <%-- <link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css"> --%>
  <link rel="stylesheet" href="${path }/resources/css/style.css">
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
							<a class="btn" data-fancybox-close="" id="enrollCate">카테고리<br>등록</a>
                            <a class="btn hvr-hover" data-fancybox-close="" id="moveCate">카테고리<br>수정</a><!--하단 박스로 이동 -->
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
									<td><a class="color" href="#">전체 카테고리</a><br><span class="badge">${total}</span></td>
									<td><a class="color" href="#">대분류</a><br><span class="badge">${largeCount}</span></td>
									<td><a class="color" href="#">중분류</a><br><span class="badge">${mediCount}</span></td>
									<td><a class="color" href="#">신규카테고리</a><br><span class="badge">${todayCount}</span></td>
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
                  	<option value="lgcate">대분류별 검색</option>
                  	<option value="mdcate">중분류별 검색</option>
                  	<option value="date">등록기간별 검색</option>
                  </select>
                  <div id="search-lgcate">
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
                  		<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
                  	</form>
                  </div>
                  <div id="search-mdcate">
                  	<form action="${path}/admin/mypage/product/search.do">
                  		<input type="hidden" name="searchType" value="category">
                  		<select id="largeCate1" name="searchKeyword">
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
                  		<input type="date" id="datepicker" name="datepicker" size="20">
                  		<label>~</label>&nbsp;&nbsp;&nbsp;
                  		<input type="date" id="datepicker2" name="datepicker" size="20">
                  		<i class="fa fa-search" aria-hidden="true" id="searchdate"></i>
                  	</form>
                  </div>
                 </div>
                </div><!-- card-->
               </div>
             </div><br>
             
             
             <script>
            
             $(function(){
            	 
             	$("#searchdate").click(function(){
             		var first = $("#datepicker").val();
             		var second=$("#datepicker2").val();
             		$.ajax({
             			url:"${path}/admin/mypage/product/searchDate.do",
             			data:{one:first,two:second},
             			type:"post",
             			dataType:"json",
             			success:function(data){
             					$("#recent-purchases-listing tbody").empty();
             				var str="";
             				
             				$.each(data,function(i){
             				if(data!=null){
             					$("#grid-view").hide();
             					$("#list-view").show();
                                str+='<tr class="append">';
                                str+='<td>'+data[i].productNo+'</td>';
                                str+='<td><img src="${path}/resources/upload/product/'+data[i].productImg+'" style="width:50px;"></td>';
                                str+='<td width="10" style="text-overflow:ellipsis; overflow: hidden;"><span>'+data[i].productName+'</span></td>';
                                str+='<td>'+data[i].largeCate+'</td>';
                                str+='<td>'+data[i].mcName+'</td>';
                                str+='<td width="10" style="text-overflow:ellipsis; overflow: hidden;"><span>'+data[i].productSummary+'</span></td>';
                                str+='<td>'+data[i].productStatus+'</td>';
                                str+='<td>'+data[i].productStock+'</td>';
                                str+='<td>'+data[i].price+'</td>';
                                str+='<td>'+data[i].defCycle+'</td>';
                                str+='<td>'+data[i].productDate+'</td>';
                                str+='<td>'+data[i].enrollCate+'</td>';
                                str+='<td>';
                                str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">';
                                str+='</td>';
                                str+='</tr>';
             					}
             					});
            					$("#recent-purchases-listing").append(str);
            				
                         		
        					var offset = $("#list-view").offset(); 
        				     $('html').animate({scrollTop : offset.top}, 1000);
        				     $("#fath").parent().attr('class','');
        				     $("#fath").attr('class','nav-link');
        				     $("#listul").parent().attr('class','active');
        				     $("#listul").attr('class','nav-link active');
        				     
        				   //날짜설정
             		        var startDateArr = first.split('-');
             		        var endDateArr = second.split('-');
             		                 
             		        var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1]), startDateArr[2]);
             		        var endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1]), endDateArr[2]);
             		         
             		        if(startDateCompare.getTime() > endDateCompare.getTime()) {
             		            swal('',"시작날짜와 종료날짜를 확인해 주세요.");
             		            document.getElementById('datepicker').value= new Date().toISOString().slice(0, 10);
           		        		document.getElementById('datepicker2').value= new Date().toISOString().slice(0, 10);
             		            return;
             		        }
             			},
             			error:function(){
             				
             			}
             		})
             	})
             	
             })	
             </script>
             
         <!-- 여기서부터 작성 -->
          <div class="product-item-filter row">
          <div class="col-12 col-sm-8 text-center text-sm-left">
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
         <div  id="list-view">
         <div class="row">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">상품 리스트</p>
                  <div class="table-responsive">
                    <table id="recent-purchases-listing" class="table" style="text-align:center;">
            		<colgroup>
						<col width="7%">
						<col width="10%">
						<col width="15%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="15%">
						<col width="15%">
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
                            <th><small>카테고리<br>등록일</small></th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="list" items="${list}" varStatus="i">
                      	<tr class="append">
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
		                    <td>${list.enrollCate}</td>
		                    <td>
			                    <input type="hidden" name="pno" id="pno" value="${list.productNo}">
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
        	</div></div>
		<br><br>        
        <!--그리드형식 -->
        <div class="row" id="grid-view">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">카테고리 리스트</p>
                  	<div style="width:30%; height:100%;float:left;margin-right:20px;margin-left:10px;">
<!-- 카테고리붙이기 -->
                  		<div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Categories</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                            	<c:forEach var="largeCate" items="${largeCate}" varStatus="i">                  
                                <div class="list-group-collapse sub-men">
                                    <a class="list-group-item list-group-item-action" href="#sub-men${i.index }" data-toggle="collapse" aria-expanded="true" aria-controls="sub-men${i.index }">
                                  
                                    	${ largeCate.largeCate}
								</a>
                                   
                                    <div class="collapse <c:if test='${i.index eq 0}'>show</c:if> " id="sub-men${i.index }" data-parent="#list-group-men">
                                    <div class="list-group">
                                    <c:forEach var="mc" items="${mediCate}" varStatus="j">
                                      <!-- 중분류카테고리 검색조건으로 seq넘기기 -->
                                    <c:if test="${ i.current.largeCate  eq j.current.largeCate }">
                                        <a href="#"  id="${j.index+1}" name="cateSearch" class="list-group-item list-group-item-action<c:if test='${i.index eq 0}'>active</c:if>" value="${ j.current.mediumCate }">${ mc.mcName }</a>
                                     </c:if>
                                     </c:forEach>
                                    </div>
                                     </div>
                                </div>
                                 </c:forEach>
                                 <br>
	                        </div>
	                    </div>
                  	</div>
                  	<div style="width:65%; height:100%;float:left;margin-left:10px;" id="updateCateView">
                  		<!-- 카테고리관리설정 붙이기 -->
                  			
                  	</div>
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
			if($("#grid-view").show()){
			}
				var offset = $("#grid-view").offset();
		     $('html').animate({scrollTop : offset.top}, 1000);
		     $("#list-view").hide();
		     $("#fath").parent().attr('class','active');
		     $("#fath").attr('class','nav-link active');
		     $("#listul").parent().attr('class','');
		     $("#listul").attr('class','nav-link');
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
document.getElementById('datepicker').value= new Date().toISOString().slice(0, 10);
document.getElementById('datepicker2').value= new Date().toISOString().slice(0, 10);
	
	$("#list-view").hide();
	var tr = $("#recent-purchases-listing tbody tr");
	var td = $(".badge").parent();
	
	tr.click(function(e){
		var no = $(this).find('#pno').val();
		location.href="${path}/shop/shopDetail.do?no="+no;
	});
	
	//count클릭이벤트->ajax로 조건에 맞는 리스트 불러오기 
	td.click(function(e){
		     $("#list-view").hide();
		     $("#grid-view").show();
		     $("#fath").parent().attr('class','active');
		     $("#fath").attr('class','nav-link active');
		     $("#listul").parent().attr('class','');
		     $("#listul").attr('class','nav-link');
			var offset = $("#grid-view").offset(); 
		     $('html').animate({scrollTop : offset.top}, 1000);
	});
	
	$("#modibtn").click(function(){
		location.href="";
	});
	//searchType change
	$("#searchType").change(function(e){
		let lgcate=$("#search-lgcate");
		let mdcate=$("#search-mdcate");
		let date = $("#search-date");
		
		lgcate.css("display","none");
		mdcate.css("display","none");
		date.css("display","none");
		
		let value = $(e.target).val();
		$("#search-"+value).css("display","inline-block");
	});
	
	//카테고리 팝업
	$("#enrollCate").click(function(){
    			if(confirm("카테고리를 추가로 등록하시겠습니까?")){
    				window.open("${path}/admin/product/moveEnrollCate.do", "카테고리등록", "width=550, height=450, toolbar=no, menubar=no, scrollbars=no, resizable=no");
				}
 	});
	
	$("#largeCate").change(function(){
    	var value = $("#largeCate").val();
    	largeChange(value);
	});
	$("#largeCate1").change(function(){
    	var value = $("#largeCate1").val();
    	largeChange(value);
	});
	function largeChange(value){
    	$.ajax({
    		url:"${path}/admin/product/category.do",
    		type:"post",
    		data: {data: value},
    		dataType:"json",
    		success:function(data){
    			var mc = $("#mediCate");
    			//list로받음
    			
    			if(data.length>0){
    				mc.empty();
    				for(var i=0;i<data.length;i++){
    					 var option = $("<option value = '"+data[i].mcName + "'>"+data[i].mcName +"</option>");
    		               mc.append(option); 
    				}
    			}else{
    				mc.empty();
    				mc.append("<option value=' '>선택</option>");
    			}
    		}
    		 ,error:function(request,error){
    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		} 
    	});
	};
	//검색 mediCate change event => 해당하는 list받아오기
	$("[name=search]").click(function(){
		var medival = $("#mediCate").val();
		var largeval = $("#largeCate").val();
		$("#recent-purchases-listing tbody").empty();
		$.ajax({
			url:"${path}/admin/mypage/product/selectListInMedi.do",
			data:{medi:medival,large:largeval},
			type:"post",
			dataType:"json",
			success:function(data){
				var str="";
				var dataLeng=Object.keys(data).length;
				$("#grid-view").hide();
				$("#list-view").show();
				$.each(data,function(i){
					
				if(data!=null){
                    str+='<tr class="append">';
                    str+='<td>'+data[i].productNo+'</td>';
                    str+='<td><img src="${path}/resources/upload/product/'+data[i].productImg+'" style="width:50px;"></td>';
                    str+='<td><span>'+data[i].productName+'</span></td>';
                    str+='<td>'+data[i].largeCate+'</td>';
                    str+='<td>'+data[i].mcName+'</td>';
                    str+='<td><span>'+data[i].productSummary+'</span></td>';
                    str+='<td>'+data[i].productStatus+'</td>';
                    str+='<td>'+data[i].productStock+'</td>';
                    str+='<td>'+data[i].price+'</td>';
                    str+='<td>'+data[i].defCycle+'</td>';
                    str+='<td>'+data[i].productDate+'</td>';
                    str+='<td>'+data[i].enrollCate+'</td>';
                    str+='<td>';
                    str+='<input type="hidden" name="pno" id="pno" value="'+data[i].productNo+'">';
                    str+='</td>';
                    str+='</tr>';
				}
				})
					$("#recent-purchases-listing").append(str);
					$("#largeCate option:eq(0)").prop('selected','selected');
					$("#largeCate1 option:eq(0)").prop('selected','selected');
					$("#mediCate").empty();
					$("#mediCate").append("<option value=''>중분류</option>");
					var offset = $("#list-view").offset(); 
				     $('html').animate({scrollTop : offset.top}, 1000);
				     $("#fath").parent().attr('class','');
				     $("#fath").attr('class','nav-link');
				     $("#listul").parent().attr('class','active');
				     $("#listul").attr('class','nav-link active');
			},
			error:function(){
				
			}
		})
	});
	//mediView show + update버튼
	$("[name=cateSearch]").click(function(e){
		alert($(this).text());
		var value=$(this).attr('value');
		$.ajax({
			url:"${path}/admin/mypage/product/cateView.do",
			data:{value:value},
			type:"post",
			dataType:"json",
			success:function(data){
				
				var str="";
				$.each(data,function(i){
				str+='<h3>[카테고리 관리•수정]</h3><br><hr>';	
				str+='<label class="center">현재 선택하신 카테고리는 <span style="color:tomato;">'+data[i].mcName+'</span>입니다.</label><hr>'
				str+='<span id="selectCate"></span><br><br>'
				str+='<label>변경전 현재</label>'
				str+='<table class="col-4 col-sm-8 text-center" id="current">'
				str+='<tr><th><label>대분류</label><br></th>'
				str+='<th><label>중분류</label></th></tr><br>'
				str+='<tr><td><span id="largeChk" name="largeChk">'+data[i].largeCate+'</span></td>'
				str+='<td><span name="mediChk">'+data[i].mcName+'</span></td></tr></table>'
				str+='<br><br>'
				str+='<form action="" name="updateFrm">'
				str+='<label>대분류를 선택하세요</label>'
				str+='<button type="button" name="add">+추가</button><br>'
				str+='<select class="form-group" id="ajaxlargeCate" name="ajaxlargeCate" size="7" style="width:30%;margin-right:10%;position:relative;float:left;">'
            	str+='<option value="주방">주방</option>'	
            	str+='<option value="욕실">욕실</option>'
            	str+='<option value="세탁실">세탁실</option>'
            	str+='<option value="현관">현관</option>'
            	str+='<option value="창고">창고</option>'
            	str+='</select>'
      			str+='<select class="form-group" id="addMedi" name="addMedi" size="7" style="width:30%;position:relative;float:left;">'
				str+='<option value="">선택하세요</option>'
				str+='</select><br>'
           		str+='<div style="position:absolute"></div>'
				str+='<div id="modiCate"><label>수정할 중분류 이름<br>'
				str+='<input type="text" name="modiCate" size="50"></label>'
				str+='<input type="hidden" id="chkId" name="chkId" value="'+value+'"><br><br>'
				str+='<a class="btn hvr-hover" data-fancybox-close="" id="deleteCate">카테고리 삭제</a>'
				str+='<a class="btn hvr-hover" data-fancybox-close="" id="updateCate">카테고리 수정</a></div>'//mediumCate 번호 같이 넘기기
				str+='<div id="addCate"><label>추가할 중분류 이름<br><input type="text" name="addCate" size="50"></label><br>'
				str+='<span id="checkText"></span><br>'
				str+='<a class="btn hvr-hover" data-fancybox-close="" id="addCategory">카테고리 추가</a>'
				str+='</div></form><br>'
				});
				$("#updateCateView").empty();
				$("#updateCateView").append(str);
				var offset = $("#grid-view").offset();
			     $('html').animate({scrollTop : offset.top}, 1000);
			},
			error:function(){
				
			}
		})
	});
	
	//카테고리추가
	$(document).on("click","#addCategory",function(){
		if($("[name=ajaxlargeCate]").val()==null){
			swal("","대분류를 선택해주세요");
			return;
		}
		if($("[name=addCate]").val()==""){
			swal("","추가할 분류명을 입력해주세요.");
			return;
		}
		if($("#checkText").attr('style').split(":")[1]!=' green;'){
			swal("","같은 이름의 카테고리명이 있습니다.","info");
			return;
		};
		var large =$("#ajaxlargeCate").val();
		var mcName = $("[name=addCate]").val();
		$.ajax({
			url:"${path}/admin/mypage/product/insertCate.do",
			data:{large:large,mcName:mcName},
			type:"post",
			dataType:"json",
			success:function(data){
				
				swal("","카테고리 추가 성공","success");
				location.reload();
			},
			error:function(){
				
			}
		})
	})
	$(document).on("click","[name=add]",function(){//추가버튼
		
		$("#addCate").toggle();
		$("#modiCate").toggle();
	});
	
	//카테고리 수정 form 안에 중분류 불러와서 넣기
	$(document).on("change","#ajaxlargeCate",function(){
				  var url = "${path}/admin/product/category.do";
			    	var value = $("#ajaxlargeCate").val();
			    	$.ajax({
			    		url:url,
			    		type:"post",
			    		data: {data: value},
			    		dataType:"json",
			    		success:function(data){
			    			var mc = $("#addMedi");
			    			//list로받음
			    			
			    			if(data.length>0){
			    				mc.empty();
			    				for(var i=0;i<data.length;i++){
			    					 var option = $("<option value = '"+data[i].mcName + "'>"+data[i].mcName +"</option>");
			    		               mc.append(option); 
			    				}
			    			}else{
			    				mc.empty();
			    				mc.append("<option value=' '>선택</option>");
			    			}
			    		}
			    		 ,error:function(request,error){
			    			
			    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    		} 
			    	});
			});
	//update시키기 mcName랑 largeCate
	$(document).on("click","#updateCate",function(){
		if($("[name=ajaxlargeCate]").val()==null){
			swal("","대분류를 선택해주세요");
			return;
		}
		if($("[name=modiCate]").val()==""){
			swal("","수정할 분류명을 입력해주세요.");
			return;
		}

		var id=	$("#chkId").val();
		var large =$("#ajaxlargeCate").val();
		var mcName = $("[name=modiCate]").val();
		$.ajax({
			url:"${path}/admin/mypage/product/updateCate.do",
			data:{id:id,large:large,mcName:mcName},
			type:"post",
			dataType:"json",
			success:function(data){
				
				swal("","수정성공","success");
				location.reload();
			},
			error:function(){
				
			}
		})
	});
	
	
	//update 시 중복된 값 있으면 span에 띄우고 없으면 update시키기
	$(document).on("keyup","[name=addCate]",function(e){
		var name = $("[name=addCate]").val();
		$.ajax({
			url:"${path}/admin/mypage/product/cateCheck.do",
			data:{name:name},
			type:"post",
			dataType:"json",
			success:function(data){
				
				if(data!=null){
					$("#checkText").text("해당 카테고리는 현재 존재합니다.");
					$("#checkText").css('color','tomato');
				}
			},
			error:function(data){
				
				$("#checkText").text("현재 카테고리는 사용가능합니다.");
				$("#checkText").css('color','green');
			}
		});
	});
	
	//삭제
	$(document).on("click","#deleteCate",function(){
		var id = $("#chkId").val();
		
			$.ajax({
				url:"${path}/admin/mypage/product/deleteCate.do",
				data:{id:id},
				type:"post",
				dataType:"json",
				success:function(data){
					
					if(confirm("해당 카테고리를 삭제하시겠습니까?")){
						swal("","카테고리 삭제 성공","success");
					};
					location.reload();
				},
				error:function(){
					
				}
			})

	});
});
</script>
<style>
#recent-purchases-listing{border:1.5px solid #f3f3f3;}
#recent-purchases-listing tr:nth-child(2n) {
    background-color: #f3f3f3;
  }
#deleteCate{color:#F2BB9C;}
#updateCate{color:#F2BB9C;}
#addCategory{color:#F2BB9C;}
.rowbtn{
    	color:#F2BB9C;
    	text-align:center;
	}
.color{color:#000000;}
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger{cursor: pointer;}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker{cursor: pointer;}
.center{
	margin-left:25%;
}
#current th{
	padding:3px;
	background-color:#F2BB9C;
	color:#ffffff;
}
#modiCate{display:inline;}
#addCate{display:none;}
	#list-view{position:relative;}
	#grid-view{position:relative;top:-38px;}
	ul li{
		padding-bottom:20px;
	}
	/* default css */
	.fa-calendar{position:relative;left:-20px;}
	  #searchType{margin-left:17%;height:25px;}
	  #largeCate{height:25px;width:320px;}
	  #largeCate1{height:25px;width:170px;}
	  #mediCate{height:25px;width:170px;}
	  div#search-lgcate{display:inline-block;margin-left:5px;}
	  div#search-mdcate{display:none;margin-left:5px;}
	  div#search-date{display:none;margin-left:10px;}
	  
	  .btn{
	  	float:right;
	  }
	  
	#enrollCate{
   		background:#F2BB9C;
    	color:#000000;
    	border-radius: 5px;
    	width:130px;
    }
    #enrollCate:hover{
    	color:#ffffff;
    	border:0px;
    }
    #moveCate{
    	background:#FCF7E1;
    	color:#000000;
    	border-radius: 5px;
    	width:130px;
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
    #recent-purchases-listing tr td{
      width:200px;
      padding:0 5px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
      }
     
    th small{
    	/* writing-mode:tb-rl; */
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