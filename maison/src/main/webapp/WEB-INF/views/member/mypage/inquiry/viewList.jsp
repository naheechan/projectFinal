<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="마이페이지 상품문의리스트"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="나의 문의 내역"/>
</jsp:include>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	#searchDiv{
		padding:0 0 0 40px;
	}
	select{
		height:33px;
	}
	#search{
	    color: #F2BB9C;
	    font-size: 18px;
	    position:absolute;
	    top: 60px;
	    left:320px;
	    padding: 0px;
	    margin:0px;
	    border: none;
	    cursor: pointer;
	    height: 30px;
    }
    #pageBar{
    	display:block;
    	text-align:center;
    	margin-bottom:5%;
    }
</style>
<!-- Start -->
<section>
	<div class="container">
		<div class="row">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<!-- Right Data page  -->
			<div class="col-lg-9 col-md-7">
				<div class="data-div">

					<hr style="background-color:rgba(242,187,156,0.5);"/> 
					<div class="row">
						<div class="col-lg-5" id="searchDiv">
							<br>
	
						 <h5>나의 문의 내역 조회</h5>
						 <form action="${path }/member/mypage/inquiry/search.do" method="post" name="submitFrm">
							 <select id="searchType" name="searchType">
							 	<option value="name" <c:if test="${map.searchType eq 'name'}">selected</c:if>>상품별검색</option><!-- 상품이름별검색 -->
							 	<option value="title" <c:if test="${map.searchType eq 'title'}">selected</c:if>>제목별검색</option><!--내용별검색-->
							 	<%-- <option value="date" <c:if test="${map.searchType eq name}">selected</c:if>>기간별검색</option> --%>
							 	<%-- <option value="cate" <c:if test="${map.searchType eq cate}">selected</c:if>>분류별검색</option><!-- 문의분류별검색 --> --%>
							 </select>
							 	<input type="text" name="keyword" id="keyword" value="${map.keyword}">
								<i class="fa fa-search" aria-hidden="true" id="search" name="search"></i>
							 	<input type="hidden" name="memberId" id="memberId" value="${loginMember.memberId }">
						 </form>
						</div>
						<div class="col-lg-7">
							<div class="table-main table-responseive">
								<table class="table table-bordered" id="status-list">
									<tbody>
										<tr style="text-align:center;">
											<td>
												<i class="fa fa-pencil-square-o"></i>
											</td>
											<td>
												<i class="fa fa-check-circle-o"></i>
											</td>
											<td>
												<i class="fa fa-commenting-o"></i>
											</td>
											<td>
												<i class="fa fa-trash-o"></i>
											</td>
												<!-- <i class="fa fa-list-alt"></i> -->
										</tr>
										<tr style="text-align:center;">
											<td><a class="color" id="1" href="#"> 내가 쓴 글</a>&nbsp;<span class="badge">${map.mycount}</span></td><!-- 전체문의??? -->
											<td><a class="color" id="2" href="#">답변완료</a>&nbsp;<span class="badge">${map.success}<c:if test="${checkcount eq null}">${success}</c:if></span></td>
											<td><a class="color" id="3" href="#">미답변</a>&nbsp;<span class="badge">${map.yet}<c:if test="${nocheckcount eq null}">${yet}</c:if></span></td>
											<td><a class="color" id="4" href="#">삭제한 글</a>&nbsp;<span class="badge">${map.del}<c:if test="${delcount eq null}">${del}</c:if></span></td><!-- 삭제한글??? -->
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					 <hr style="background-color:rgba(242,187,156,0.5);"/>			
				</div>
				<br/>
				<div id="totalInquiry-div" class="table-main table-responsive">
				<h2>전체 문의 내역</h2><br><span id="b">현재 ${map.searchCount}개의 게시물이 검색되었습니다.</span>
					<table class="table table-hover" style="table-layout:fixed; text-align:center;" id="resultTable">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="30%">
						<col width="10%">
						<col width="10%">
					</colgroup>
						<thead>
							<th colspan="2">상품정보</th>
							<th>문의분류</th>
							<th>문의내역</th>
							<th>답변상태</th>
							<th>작성일</th>
							<th>편집</th>
						</thead>
						<tbody>
							<c:forEach var="list" items="${map.list}" varStatus="i">
							<tr>
								<td>
									<img src="${path}/resources/upload/product/${list.productImg}" style="width:60px;"/>
								</td>
								<td>${list.productName}</td>
								<td>${list.piCate}</td>
								<td  width="10" style="text-overflow:ellipsis; overflow: hidden;"><span>${list.piContent}</span></td>
								<c:if test="${list.piStatus eq 'Y'}">
								<td>
									<span style="color:#66CC00;border:1px solid rgba(102,204,000,0.9);padding:1px;">답변완료</span>
								</td>
								</c:if>
								<c:if test="${list.piStatus eq 'N' and list.piDel eq 'Y'}">
								<td>
									<span style="color:#FF6633;border:1px solid rgba(255,102,051,0.9);padding:1px;">답변대기</span>
								</td>
								</c:if>
								<c:if test="${list.piStatus eq 'N' and list.piDel eq 'N'}">
								<td>
									<span style="color:lightgray;border:1px solid rgba(204,204,204,0.9);padding:1px;">답변삭제</span>
								</td>
								</c:if>
								<td>${list.piDate}</td>
								<td onclick="event.cancelBubble=true">
								<c:if test="${list.piDel eq 'Y'}">
									<div class="form-group col-md-12">
										<a href = "javascript:void(0)" onclick ="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
										수정</a>
										<a class="btn" type="button" style="height:45%;background:#F2BB9C;" href="${path}/member/mypage/inquiry/deleteIq.do?no=${list.piNo }&id=${loginMember.memberId}">삭제</a>
									</div>
								</c:if>
								<c:if test="${list.piDel eq 'N'}">
									<span style="color:lightgray;">삭제된글입니다.</span>
								</c:if>
								</td>
							</tr>
							<input type="hidden" id="pdNo" value="${list.productNo}">
							</c:forEach>
						</tbody>
					</table>	
				</div>
				<div id="light" class="white_content">
				<div class="pi-list-box">
				<div class="container">
					<form action="${path }/shop/user/inquiryEnd.do" method="post" id="inquiryForm">
						<input type="hidden" value="" name="productNo">
						<div id="data-div">
							<div class="form-group required">
								<label for="piTitle" style="font-weight:bold;" class="control-label">상품제목</label>
								<input type="text" id="piTitle" class="form-control" name="piTitle" value="상품문의입니다:)" style="text-align:right;" readonly>
							</div>
							<div class="form-group required">
								<label for="memberId" style="font-weight:bold;" class="control-label">작성자</label>		
								<input type="text" id="memberId" class="form-control" name="memberId" style="text-align:right;" 
								value="${loginMember.memberId}" required readonly>	
							</div>
							<div class="form-group required">
								<div class="form-group required">
									<label for="piCate" style="font-weight:bold;" class="control-label">분류선택</label>
									<select id="piCate" class="form-control" name="piCate" required>
										<option value="" selected>선택하기</option>
										<option value="상품문의">[상품문의]</option>
										<option value="배송문의">[배송문의]</option>
									</select>
								</div>
								<div class="form-group required">
									<label for="piContent" style="font-weight:bold;" class="control-label">문의내역</label>
									<textarea cols="100%" rows="10"  id="piContent" class="form-control" name="piContent" required></textarea>
								</div>
								<input type="hidden" name="pirContent" id="pirContent" value="">
								</div>
							</div>
							<button type="submit" class="btn" style="float:right;background-color:#F2BB9C; margin-right:2%;">수정하기</button>
							<button type="reset" class="btn" style="float:right;background-color:#FCF7E1; margin-right:2%;">
							<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">&#88;</a></div>
							</button>
							<div id="fade" class="black_overlay"></div>
			       			 </div></div>
			       			<div id="pageBar">
				        		${pageBar }	        
				        	</div>
						</div>
						</div>
					 </div>
	 
	 <script>
	 $(function(){
	 	$("#search").click(function(){
	 		$("[name=submitFrm]").submit();
	 	})
	 });
	 $("#resultTable tbody tr").click(function(){
		 var no = $("#pdNo").val();//pdno
		location.href="${path}/shop/shopDetail.do?no="+no;
	 });
	 /* $("#1").click(function(){
		 var id=$("#memberId").val();
		 $.ajax({
			 url:"${path}/member/mypage/inquiry/myWrite.do",
			data:{id:id},
			type:"post",
			dataType:"json",
			success:function(data){
				$("#resultTable").empty();
				console.log("1ajax통신성공");
				var str="";
				$.each(data,function(i){
					str+='<tr>'
					str+='<td>'
					str+='<img src="${path}/resources/upload/product/'+data[i].productImg+'" style="width:60px;"/>'
					str+='</td>'
					str+='<td>'+data[i].productName+'</td>'
					str+='<td>'+data[i].piCate+'</td>'
					str+='<td  width="200" style="text-overflow:ellipsis; overflow: hidden;"><span>'+data[i].piContent+'</span></td>'
					str+='<td>'
					str+='<span style="color:#66CC00;border:1px solid rgba(102,204,000,0.9);padding:1px;">답변완료</span>'
					str+='</td>'
					str+='<td>'
					str+='<span style="color:#FF6633;border:1px solid rgba(255,102,051,0.9);padding:1px;">답변대기</span>'
					str+='</td>'
					str+='<td>${list.piDate}</td>'
					str+='<td>'
					str+='<div class="form-group col-md-12">'
					str+='<button class="btn" type="button" style="height:45%;background:#FCF7E1;">수정</button>'
					str+='<button class="btn" type="button" style="height:45%;background:#F2BB9C;">삭제</button>'
					str+='</div>'
					str+='<span style="color:lightgray;">삭제된글입니다.</span>'
					str+='</td>'
					str+='</tr>'
					$("#resultTable").append(str);
				})
			},
			error:function(){
				console.log("1ajax통신실패");
			}
		 })
	 }) */
	 $("#1").click(function(){
		  var id=$("#memberId").val();
		 location.href="${path}/member/mypage/inquiry/myWrite.do?id="+id;
	 })
	  $("#2").click(function(){
		  var id=$("#memberId").val();
		 location.href="${path}/member/mypage/inquiry/replySuccess.do?id="+id;
	 })
	 $("#3").click(function(){
		 var id=$("#memberId").val();
		 location.href="${path}/member/mypage/inquiry/replyYet.do?id="+id;
	 })
	  $("#4").click(function(){
		  var id=$("#memberId").val();
		 location.href="${path}/member/mypage/inquiry/replydel.do?id="+id;
	 })
	 </script>
	 
<style>
.black_overlay{
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	z-index:1001;
	-moz-opacity: 0.8;
	opacity:.80;
	filter: alpha(opacity=80);
}

.white_content {
	display: none;
	position: absolute;
	top: 25%;
	left: 25%;
	width: 50%;
	height: 50%;
	padding: 16px;
	border: 2px solid #F2BB9C;
	background-color: white;
	z-index:1002;
	overflow: auto;


 #status-list td:hover{
    	background-color:#FCF7E1;
    }
 .badge{
    	font-weight:bold;
    }
.color{
	color:#000000;
}
.color:hover{
	color:#F2BB9C;
}
.ellipsis{text-overflow:ellipsis; overflow: hidden;
    width:100px;
    white-space:nowrap;
}
</style>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		