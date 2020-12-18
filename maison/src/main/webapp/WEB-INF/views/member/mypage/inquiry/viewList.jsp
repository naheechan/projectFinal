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
						 <form action="" method="post">
							 <select id="searchType" name="searchType">
							 	<option value="name" <c:if test="${map.searchType eq name}">selected</c:if>>상품별검색</option><!-- 상품이름별검색 -->
							 	<option value="title" <c:if test="${map.searchType eq title}">selected</c:if>>제목별검색</option><!--내용별검색-->
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
								<table class="table table-bordered">
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
											<td>내가 쓴 글&nbsp;<span class="badge">${totalcount}</span></td><!-- 전체문의??? -->
											<td>답변완료&nbsp;<span class="badge">${checkcount}</span></td>
											<td>미답변&nbsp;<span class="badge">${nocheckcount}</span></td>
											<td>삭제한 글&nbsp;<span class="badge">${delcount}</span></td><!-- 삭제한글??? -->
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
				<h2>전체 문의 내역</h2>
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
							<c:forEach var="list" items="${totalList}" varStatus="i">
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
								<c:if test="${list.piStatus eq 'N'}">
								<td>
									<span style="color:#FF6633;border:1px solid rgba(255,102,051,0.9);padding:1px;">답변대기</span>
								</td>
								</c:if>
								<td>${list.piDate}</td>
								<td>
								<c:if test="${list.piDel eq 'Y'}">
									<div class="form-group col-md-12">
										<button class="btn" type="button" style="height:45%;background:#FCF7E1;">수정</button>
										<button class="btn" type="button" style="height:45%;background:#F2BB9C;">삭제</button>
									</div>
								</c:if>
								<c:if test="${list.piDel eq 'N'}">
									<span style="color:lightgray;">삭제된글입니다.</span>
								</c:if>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>	
				</div>
       			<div id="pageBar">
	        		${pageBar }	        
	        	</div>
			</div>
			</div>
		 </div>
	 
	 <script>
	 $(function(){
		 var mId = $("#memberId").val();
	 	$("#search").click(function(){
	 		//searchkeyword();
	 		$("#keyword").val("");
	 	})
	 
	 	function searchkeyword(){
	 			var keyword=$("#keyword").val();
	 		$.ajax({
	 			url:"${path}/member/mypage/inquiry/searchkeyword.do?id="+mId,
	 			data:{keyword:keyword},
	 			type:"post",
	 			dataType:"json",
	 			success:function(data){
	 				console.log("검색ajax통신성공");
	 				swal("search","success","success");
	 				
	 			},
	 			error:function(){
	 				console.log("검색ajax통신실패");
	 			}
	 		})
	 	};
	 });
	 </script>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		