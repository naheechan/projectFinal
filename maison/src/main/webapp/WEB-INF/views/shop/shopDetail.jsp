<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="상품상세페이지"/>
</jsp:include>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.navbar-brand {
    float: left;
    height: 100px;
    padding: 15px 15px;
    font-size: 18px;
    line-height: 20px;
}
	[id^='content']{
		margin:80px 0 100px 0;
		text-indent:70px;
	}
	#reply{
		color:#F2BB9C;
		padding:0px 30px 0px 0px;
	}
	#reply_modi{
		padding:0px;
		color:#F2BB9C;
	}
	#reply_del{
		padding:0px 30px 0 0;
		color:#F2BB9C;
	}
	#pdInquiryList tr:hover{
		background:#FCF7E1;
	}
	#replySubmit{
		color:#F2BB9C;
		text-align:center;
	}
	#replySubmit:hover{
		color:#F2BB9C;
	}
	#reply_reply{
		color:#F2BB9C;
	}
	.answer{
		color:#F2BB9C;
	}
	#admin_repModi{
		color:#F2BB9C;
		text-align:center;
	}
	#after_adminModi{
		color:#F2BB9C;
		text-align:center;
	}
	#after_userModi{
		color:#F2BB9C;
		text-align:center;
		padding-right:0px;
	}
	#after_cancel{
		color:#F2BB9C;
		text-align:center;
		padding-left:0px;
	}
	select {
	float:left;
	  width: 200px;
	  padding: .8em .5em;
	  font-family: inherit;
	  background: url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg) no-repeat 95% 50%;  
	  background-color:white;
	  -webkit-appearance: none;
     -moz-appearance: none;
      appearance: none;
	  border: 1px solid #999;
	  border-radius: 0px;
	}

select::-ms-expand { /* for IE 11 */
    display: none;
}
.replaceDel td{
	text-align:center;
}
#admin_repDel{
	color:#F2BB9C;
	text-align:center;
	padding-left:0px;
}
#user_Ydel{
	color:#F2BB9C;
	text-align:center;
}
</style>
 <script>
      $(document).ready(function(){
    	
		/* 상품 상세로 스크롤이동 */
 		$('.menu1').click(function(){

 			var offset = $("#product-detail").offset(); 

 	        $('html').animate({scrollTop : offset.top}, 1000);

 		}),
 		/* 고객후기로 스크롤이동 */
 		$('.menu2').click(function(){

 			var offset = $("#product-review").offset(); 

 	        $('html').animate({scrollTop : offset.top}, 1000);

 		}),
 		/* 상품문의로 스크롤이동 */
 		$('.menu3').click(function(){

 			var offset = $("#product-inquery").offset(); 

 	        $('html').animate({scrollTop : offset.top}, 1000);

 		}),
 		
 		/* 관련상품으로 스크롤이동 */
 		$('.menu4').click(function(){

 			var offset = $("#product-relative").offset(); 

 	        $('html').animate({scrollTop : offset.top}, 1000);

 		});
 		
 	
 	}); 
 	
	

</script>

    <!-- Start All Title Box -->
    <!-- <div class="all-title-box">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Shop Detail</h2>
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Shop</a></li>
                        <li class="breadcrumb-item active">Shop Detail </li>
                    </ul>
                </div>
            </div>
        </div>
    </div> -->
    <!-- End All Title Box -->
		
    <!-- Start Shop Detail  -->
   <div>
    <div class="shop-detail-box-main">
    
        <div class="container">
            <div class="row">
            <form action="${path }/order/buy.do" id="buyFrm">
                <div class="col-xl-5 col-lg-5 col-md-6">
                	<!-- 상품 상세 이미지 넣기 -->
                	
                   <img class="d-block w-100" src="${path }/resources/upload/product/${product.productImg }" alt="First slide">
                </div>
                <div class="col-xl-7 col-lg-7 col-md-6">
                
                    <div class="single-product-details">
                        <h2>${product.productName }</h2>
                        
                        <h5><fmt:formatNumber type="currency" value="${product.price }"/></h5>
                        
						<h2>상품 안내:</h2>
						<p>${product.productSummary }</p>
						<ul>
							<li>
								<div class="form-group quantity-box">
									<label class="control-label">수량</label>

									<input type="number" name="amount" class="form-control" id="amount" value="1" step="1" min="1" max="20" >
									

								</div>
							</li>
						</ul>

					
					<div class="price-box-bar">
							<div class="cart-and-bay-btn">


								<!-- <a class="btn hvr-hover" data-fancybox-close="" href="#">바로구매</a> -->
									<input type="hidden" name="productName" value="${product.productName }">
									<input type="hidden" name="productNo" id="productNo" value="${product.productNo }">
									<input type="hidden" name="price" value="${product.price }">
									
									<button type="submit" class="btn hvr-hover" id="buyBtn">바로구매</button>	
									
								<a class="btn hvr-hover" id="basketA" data-fancybox-close="" href="#">장바구니</a>

							</div>
							
							</form>
						</div>
						
						
						

						<div class="add-to-btn">
							<div class="add-comp">
								<c:if test="${loginMember.memberId!=null }">
									<div class="container">
									  
									  <form action="${path }/shop/wishList.do" method="post" target="frm">
									    <div class="form-group">
									      <input type="hidden" class="form-control" value="${product.productNo }" name="no" id="SessionProductNo">
									      <input type="hidden" class="form-control" value="${loginMember.memberId }" name="id" id="sessionMemberId">
									    </div>
									    <iframe name="frm" style="width: 1px; height: 1px;border: 0;"></iframe>
									    <button type="submit" class="btn hvr-hover">Add to WishList</button>
									  </form>
									  
									</div>
									
										<%-- <a class="btn hvr-hover" href="${path }/shop/wishList.do?no=${product.productNo}"><i class="fas fa-heart"></i> Add to wishlist</a> --%>
								</c:if>				
							</div>
							
						</div>
                    </div>
                    
                </div>
            </div>
            
           
          
         
          
            
			
			<div class="row my-5">
			<ul class="nav nav-tabs nav-justified pagination-lg">
	            <li class="nav-item active menu1">
	              <a class="nav-link text-muted" href="#">상품상세</a>
	            </li>
	            <li class="nav-item menu2">
	              <a class="nav-link text-muted" href="#">고객후기</a>
	            </li>
	            <li class="nav-item menu3">
	              <a class="nav-link text-muted" href="#">상품문의</a>
	            </li>
	            <li class="nav-item menu4">
	              <a class="nav-link text-muted" href="#">관련상품</a>
	            </li>
         	 </ul>
			 
			<!-- 상품 상세설명 -->
			
			<div class="card card-outline-secondary my-4" id="product-detail">
				<!-- <div class="card-header">
					<h2>상품상세</h2>
				</div> -->
				
				<div class="card-body">
					<!-- ck에디터 이미지 띄우기 -->
					<img src="${path }/resources/upload/product/${product.productImg }" style="width: 600px;height: 600px;">
					<p>${product.productContent }</p>
					<textarea id="imgContent" hidden="hidden"><c:out value="${product.productContent}"/></textarea>
					<%-- <div class="col-lg-12" id="imgShow" style="text-align:center;">
				<textarea id="imgContent" hidden="hidden"><c:out value="${product.productContent}"/></textarea>
			</div> --%>
				</div>
		 	</div>
			<!-- 상품 리뷰 -->
			
				<div class="card card-outline-secondary my-4" id="product-review">
					<ul class="nav nav-tabs nav-justified pagination-lg">
			            <li class="nav-item menu1">
			              <a class="nav-link text-muted" href="#">상품상세</a>
			            </li>
			            <li class="nav-item active menu2">
			              <a class="nav-link text-muted" href="#">고객후기</a>
			            </li>
			            <li class="nav-item menu3">
			              <a class="nav-link text-muted" href="#">상품문의</a>
			            </li>
			            <li class="nav-item menu4">
			              <a class="nav-link text-muted" href="#">관련상품</a>
			            </li>
         			 </ul>
					<!-- <div class="card-header">
						<h2>고객후기</h2>
					</div> -->
					<div class="card-body">
						<div id="review-container">
						</div>
						<div class="media mb-3">
							<!-- <div class="mr-2"> 
								
							</div>
							<div class="media-body">
								<p>맛없어요</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>맛없어요</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>맛없어요</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>맛없어요</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>맛없어요</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div>
						</div>
						<hr>
						<div class="media mb-3">
							<div class="mr-2"> 
								<img class="rounded-circle border p-1" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%2264%22%20height%3D%2264%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2064%2064%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_160c142c97c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_160c142c97c%22%3E%3Crect%20width%3D%2264%22%20height%3D%2264%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2213.5546875%22%20y%3D%2236.5%22%3E64x64%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" alt="Generic placeholder image">
							</div>
							<div class="media-body">
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
								<small class="text-muted">Posted by Anonymous on 3/1/18</small>
							</div> -->
						</div>
						<hr>
						<!-- <a href="#" class="btn hvr-hover">리뷰 남기기</a> -->
					</div>
				  </div>
				
				  <!-- 상품 문의 -->
				  
				  <div class="card card-outline-secondary my-4" id="product-inquery">
				 	 <ul class="nav nav-tabs nav-justified pagination-lg">
			            <li class="nav-item menu1">
			              <a class="nav-link text-muted" href="#">상품상세</a>
			            </li>
			            <li class="nav-item menu2">
			              <a class="nav-link text-muted" href="#">고객후기</a>
			            </li>
			            <li class="nav-item menu3">
			              <a class="nav-link active text-muted" href="#">상품문의</a>
			            </li>
			            <li class="nav-item menu4">
			              <a class="nav-link text-muted" href="#">관련상품</a>
			            </li>
         	 		</ul>
					<!-- <div class="card-header">
<h2>상품문의</h2>
					</div> -->
					<div class="card-body">
						<div class="media mb-3">
							<div class="media-body">
								<h4 id="countList"></</h4>
								<br>
								
								<table class="table table-hover" id="pdInquiryList" name="pdInquiryList">
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="40%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">카테고리</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">작성일</th>
										<th scope="col">답변여부</th>
									</tr>
									</thead>
									<tbody>
									<input type="hidden" name="sessionMemberId" class="form-control"  id="sessionMemberId" value="${loginMember.memberId }">
									</tbody>
								</table>
							</div>
							<div class="pageBar"></div>
						</div>
						<hr>
						 
			        	<c:if test="${loginMember!=null && loginMember.memberId ne 'admin'}">
						<a href="${path}/shop/user/writeInQuiry.do?no=${ product.productNo }" class="btn hvr-hover">문의하기</a>
						</c:if>
						<c:if test="${loginMember.memberId eq null}">
						<a onclick="swal('','로그인 후 이용해주세요');" class="btn hvr-hover">문의하기</a>
						</c:if>
						<c:if test="${loginMember.memberId eq 'admin' }">
						<!-- form adminFrm -->
						</c:if>
					</div>
				  </div>
			</div>
			
<script>
/* $(document).ready(function(){
	var replaced = $("#imgContent").val().replace('maison','20AM_MAISON_final');
	$("#imgShow").html(replaced);
}); */
$(function(){
		//상품번호
		var pNo = $("#SessionProductNo").val();
		//session 아이디
		var mId =$("#sessionMemberId").val();
		var nullId=$("#pdInquiryList").children().next().next().find("input").val();
		if(nullId==""){
			$("#pdInquiryList tbody").append("<tr><td colspan='6'><span>로그인 후 이용가능합니다.</span></td></tr>");
		}
//관리자답글 click ok
		$(document).on("click",'[name=reply_reply]',function(){
			if(confirm("관리자 답글을 작성하시겠습니까?")){
				$(this).next().show();
			}else{
				$(this).next().hide();
			}
		});
//admin답글달기 버튼 ok
		$(document).on("click",'[name=replySubmit]',function(e){
			
			var insertReply = $(e.target).parent().serializeArray();
			var form =$(e.target).parent(); 
			console.log(insertReply);
				if(form.children("textarea").val()==""){
					swal('',"내용을 입력해주세요.");
				}else{
					replyInsert(insertReply);
 					$("[name=pirContent]").val("");
 					//답변여부 업데이트시켜주기 o
 					var no = $(this).siblings("input[name='piNo']").val();
 					console.log(no);
 					updateStatus(no);
				}
		})
		inquiryList();

//admin 답글 수정버튼누르면 화면전환 ok
$(document).on("click",'[name=admin_repModi]',function(e){
	var no = $(this).prev().val();//pirNo
		if(confirm("답글을 수정하시겠습니까?")){
			$(this).prev().prev().replaceWith("<form name='afterAdminReply'><textarea id='rmContent' name='rmContent' rows='6' cols='115' style='resize:none;' required></textarea><input type='hidden' id='pirNo' name='pirNo' value='"+no+"'></form>");
			$(this).replaceWith("<a name='after_adminModi' id='after_adminModi' style='float:right;'>답글 수정</a>");
		}
});

//admin답글 수정 ok
$(document).on("click",'[name=after_adminModi]',function(e){
	var no = $(this).prev().val();
	if(confirm("답글을 수정하시겠습니까?")){
		var updateFrm = $("form[name='afterAdminReply']").serializeArray();
		if($("#rmContent").val()==""){
			swal('',"수정할 답글을 입력해주세요");
		}else{
			modiAdminReply(updateFrm);
			swal('',"답글수정성공","success");
			location.reload();
		}
	}
	
});

//user수정화면전환 ok
		$(document).on("click",'[name=reply_modi]',function(e){
			var no = $(this).prev().prev().val();
			if(confirm("문의를 수정하시겠습니까?")){
				$(this).prev().prev().prev().replaceWith("<form name='userModiInquiry'><select name='piCate'><option value='상품문의'>상품문의</option><option value='배송문의'>배송문의</option></select><br><textarea id='umContent' name='umContent' rows='6' cols='115' style='resize:none;' required></textarea><input type='hidden' id='piNo' name='piNo' value='"+no+"'></form>");
				$(this).replaceWith("<a name='after_cancel' id='after_cancel' style='float:right;'>취소</a><a name='after_userModi' id='after_userModi' style='float:right;'>수정</a>");
				$("#after_userModi").prev().prev().detach();
				$("#after_cancel").click(function(e){
					if(confirm("문의수정을 취소하시겠습니까?")){
						location.reload();
					}
				})
			}
		});
		
//user수정업데이트 ok
$(document).on("click",'[name=after_userModi]',function(e){
	var no = $(this).prev().val();
	if(confirm("답글을 수정하시겠습니까?")){
		var updateFrm = $("form[name='userModiInquiry']").serializeArray();
		if($("#umContent").val()==""){
			swal('',"수정할 문의 내용을 입력해주세요");
		}else{
			modiUserReply(updateFrm);
			swal('',"문의글 수정 성공","success");
			location.reload();
		}
	}
});

//user문의글 삭제
		$(document).on("click",'[name=reply_del]',function(e){
			var no = $(this).prev().val();
			if(confirm("문의를 삭제하시겠습니까?")){
				delUserInquiry(no);
				swal('',"문의 삭제 성공","success");
				location.reload();
			}
		})
//user status=='Y'일때 문의글 삭제
		$(document).on("click",'[name=user_Ydel]',function(e){
			var no = $(this).prev().val();
			if(confirm("문의를 삭제하시겠습니까?")){
 				delUserInquiry(no);
				swal('',"문의 삭제 성공","success");
				location.reload();
			}
		})

//답글등록//답글내용insert  ok
function replyInsert(insertReply){
	
		$.ajax({
			url:"${path}/shop/admin/inquiryReply.do",
			type:"post",
			data:insertReply,
			dataType:"json",
			success:function(data){
				console.log("댓글ajax통신성공");
			},
			error:function(){
				console.log("댓글ajax통신실패");
			}
		});
};

//문의내역 리스트 보여주기 o
function inquiryList(){
	var no=$("[name=productNo]").val();
		$.ajax({
			url:"${path}/shop/shopInquiry",
			data:{"no":no},
			type:"post",
			dataType:"json",
			/* data:{"pNo":pNo},//상품번호 넘겨주기 */
			success:function(data){
				
				console.log("ajax통신성공");
				var str ='';
				var dataLeng = Object.keys(data).length;
				$.each(data,function(i){
					//상품번호에 맞는 문의내역만 보여주기
					if(data!=null){/* [dataLeng-i] */
						if(data[i].productNo==pNo){
							if(data[i].piDel=='Y'){
								str += '<tr class="odd"><td>'+[dataLeng-i]+'</td><td>'+data[i].piCate+'</td><td id="title">'+data[i].piTitle+'</td><td>'+data[i].memberId+'</td><td>'+data[i].piDate+'</td><td id="conf">'+data[i].piStatus+'</td>';
								str +='</tr>';
								str +="<tr class='content' id='content"+[i]+"'><td colspan='6'><div id='contentDiv'>"+data[i].piContent+"</div>";
								str+="<input type='hidden' name='piNum' id='piNum' value="+data[i].piNo+">";
								if(data[i].piStatus=='Y' && data[i].memberId==mId){
									str+="<a name='user_Ydel' id='user_Ydel' style='float:right;'>문의 삭제</a>";
								}
							}else{
								str+="<tr class='replaceDel' style='color:lightgrey;'><td style='text-align:left;'>"+[dataLeng-i]+"</td><td></td><td>삭제된 문의글 입니다.</td><td style='text-align:left'>"+data[i].memberId+"</td><td colspan='2'></td></tr>";
							}
							//답글row추가
							if(data[i].piStatus=='Y'){
								if(data[i].pirContent!=null&&data[i].piDel!='N'){//댓글이 null이 아니고 삭제여부가 n일때
									str+="<tr class='answer'>";
									str+='<td></td><td>'+data[i].piCate+'</td><td>&nbsp;&nbsp;&nbsp;re:답변드립니다:)</td><td>관리자</td><td>'+data[i].pirDate+'</td><td>답변완료</td>';
									str+="</tr>";
									str+="<tr class='answer_content'><td colspan='6'><div id='contentPirDiv'>"+data[i].pirContent+"</div>";
									str+="<input type='hidden' name='pirNo' id='pirNo' value="+data[i].pirNo+">";
									if(mId!=null && mId == 'admin'){
										str+="<a name='admin_repModi' id='admin_repModi' style='float:right;'>답글 수정</a>";
									}
								} 
							}
							if(data[i].piDel=='Y' && data[i].piStatus=='N'){//문의가 존재하고(n이 없는거)
								if(mId == data[i].memberId){//세션값과 아이디값이 같으면 
									str+='<a name="reply_del" id="reply_del" style="float:right;">삭제</a>';
									str+='<a name="reply_modi" id="reply_modi" style="float:right;">수정</a>';
								}
							if(mId!=null && mId == 'admin'){//관리자일 때
								if(data[i].piStatus=='N'){//답글이 안달려있으면
									str+="<a name='reply_reply' id='reply_reply' style='float:right'>답글</a>";
									//댓글달기하단에
									str+="<div id='replyContainer' name='replyContainer' style='display:none;'>";
									str+="<form action='${path }/shop/admin/inquiryReply.do' method='post' name='adminFrm' id='adminFrm"+data[i].piNo+"'>";
									str+="<div id='replyAdmin' name='replyAdmin'></div><span style='color:#F2BB9C'>▼Admin</span>";
									str+="<input type='hidden' class='form-control' value='"+data[i].productNo+"' name='no' id='SessionProductNo"+[i]+"'>";
									str+="<input type='hidden' name='piNo' id='piNo' value="+data[i].piNo+">"
									str+="<textarea class='form-control' name='pirContent' id='pirContent"+[i]+"' rows='6'  style='resize:none;' required></textarea>";
									str+="<br>";
									str+='<a id="replySubmit" name="replySubmit" style="float:right;">답글달기</a>';
									str+="</form></div>";
									}
								}
							};
							str+="<br>";
							str+="</td></tr>";
						}
					}
				})
					$("#pdInquiryList").append(str);
				
				//문의 내용 toggle
				$(".content").hide();
				$(".answer_content").hide();
				$("#pdInquiryList tr").on('click',function(){
					$("#pdInquiryList tr:first-child").show();//열머리글 보여주기
					/* $("#pdInquiryList tr:odd").addClass("odd"); */
					/* $("#pdInquiryList tbody tr:not(.odd)").hide(); */
					
					$("#pdInquiryList tr.odd").click(function(){
						console.log(dataLeng);
						$(this).next("tr").toggle();
						$("#replyAdmin").empty();
						/* $("[name=replyAdmin]").append("<input type='hidden' name='piNo' id='piNo' value="+$(this).text()[0]+">"); */
					})
					
					$("#pdInquiryList tr.answer").click(function(){
						$(this).next("tr").toggle();
					})
				})
			},
			error:function(){
				console.log("ajax통신실패");
			}
		})
};

//답변여부 업데이트 ok 
function updateStatus(no){
	console.log("업데이트"+no);
	$.ajax({
		url:"${path}/shop/updateStatus.do?no="+no,
		type:"post",
		success:function(data){
			console.log("답변업뎃ajax통신성공");
			if(data!=null){
				swal('',"답글완료","success");
				location.reload();//답변여부 reload
			}
		},
		error:function(){
			console.log("답변업뎃ajax통신실패");
		}
	})
};

//관리자 답글 수정 ajax
function modiAdminReply(updateFrm){
	$.ajax({
		url:"${path}/shop/admin/modiReply.do",
		data:updateFrm,
		type:"post",
		dataType:"json",
		success:function(data){
			console.log("답글수정ajax통신성공");
		},
		error:function(){
			console.log("답글수정ajax통신실패");
		}
	})
}

//user 문의글 수정
function modiUserReply(updateFrm){
	$.ajax({
		url:"${path}/shop/user/modiInQuiry.do",
		data:updateFrm,
		type:"post",
		dataType:"json",
		success:function(data){
			console.log("문의글 수정 ajax통신성공");
		},
		error:function(){
			console.log("문의글 수정 ajax통신실패");
		}
	})
}
//user 문의글 삭제
function delUserInquiry(no){
	$.ajax({
		url:"${path}/shop/user/deleteInQuiry.do",
		data:{"no":no},
		type:"post",
		dataType:"json",
		success:function(data){
			console.log("문의삭제 ajax 통신 성공");
		},
		error:function(){
			console.log("문의삭제 ajax 통신 실패");
		}
	})
}
	});

</script>

            <div class="row my-5" id="product-relative">
	            <ul class="nav nav-tabs nav-justified pagination-lg">
		            <li class="nav-item menu1">
		              <a class="nav-link text-muted" href="#">상품상세</a>
		            </li>
		            <li class="nav-item menu2">
		              <a class="nav-link text-muted" href="#">고객후기</a>
		            </li>
		            <li class="nav-item menu3">
		              <a class="nav-link text-muted" href="#">상품문의</a>
		            </li>
		            <li class="nav-item active menu4">
		              <a class="nav-link text-muted" href="#">관련상품</a>
		            </li>
       	 		</ul>
                <div class="col-lg-12">
                
                    <div class="title-all text-center">	                
                        <h1>관련상품</h1>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet lacus enim.</p>
                    </div>
                    <div class="featured-products-box owl-carousel owl-theme">
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-01.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-02.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-03.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-04.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-01.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-02.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-03.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="products-single fix">
                                <div class="box-img-hover">
                                    <img src="${path }/resources/images/img-pro-04.jpg" class="img-fluid" alt="Image">
                                    <div class="mask-icon">
                                        <ul>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                        </ul>
                                        <a class="cart" href="#">Add to Cart</a>
                                    </div>
                                </div>
                                <div class="why-text">
                                    <h4>Lorem ipsum dolor sit amet</h4>
                                    <h5> $9.79</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- End Cart -->

    <!-- Start Instagram Feed  -->
    <div class="instagram-box">
        <div class="main-instagram owl-carousel owl-theme">
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-01.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-02.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-03.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-04.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-05.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-06.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-07.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-08.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-09.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="ins-inner-box">
                    <img src="${path }/resources/images/instagram-img-05.jpg" alt="" />
                    <div class="hov-in">
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Instagram Feed  -->


    <!-- Start Footer  -->
    <footer>
        <div class="footer-main">
            <div class="container">
				<div class="row">
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Business Time</h3>
							<ul class="list-time">
								<li>Monday - Friday: 08.00am to 05.00pm</li> <li>Saturday: 10.00am to 08.00pm</li> <li>Sunday: <span>Closed</span></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Newsletter</h3>
							<form class="newsletter-box">
								<div class="form-group">
									<input class="" type="email" name="Email" placeholder="Email Address*" />
									<i class="fa fa-envelope"></i>
								</div>
								<button class="btn hvr-hover" type="submit">Submit</button>
							</form>
						</div>
					</div>
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Social Media</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<ul>
                                <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                            </ul>
						</div>
					</div>
				</div>
				<hr>
                <div class="row">
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-widget">
                            <h4>About Freshshop</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p> 
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p> 							
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link">
                            <h4>Information</h4>
                            <ul>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Customer Service</a></li>
                                <li><a href="#">Our Sitemap</a></li>
                                <li><a href="#">Terms &amp; Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Delivery Information</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link-contact">
                            <h4>Contact Us</h4>
                            <ul>
                                <li>
                                    <p><i class="fas fa-map-marker-alt"></i>Address: Michael I. Days 3756 <br>Preston Street Wichita,<br> KS 67213 </p>
                                </li>
                                <li>
                                    <p><i class="fas fa-phone-square"></i>Phone: <a href="tel:+1-888705770">+1-888 705 770</a></p>
                                </li>
                                <li>
                                    <p><i class="fas fa-envelope"></i>Email: <a href="mailto:contactinfo@gmail.com">contactinfo@gmail.com</a></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer  -->

    <!-- Start copyright  -->
    <div class="footer-copyright">
        <p class="footer-company">All Rights Reserved. &copy; 2018 <a href="#">ThewayShop</a> Design By :
            <a href="https://html.design/">html design</a></p>
    </div>
    <!-- End copyright  -->

    <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

    <!-- ALL JS FILES -->
     <script src="<%=request.getContextPath() %>/resources/js/jquery-3.2.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script src="<%=request.getContextPath() %>/resources/js/jquery.superslides.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap-select.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/inewsticker.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootsnav.js."></script>
    <script src="<%=request.getContextPath() %>/resources/js/images-loded.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/isotope.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/baguetteBox.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/form-validator.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/contact-form-script.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/custom.js"></script>
</body>
<script>
	$(function() {
						
	$("#basketA").click(
			function() {
				var amount = $("input[name=amount]").val();
				const productNo = $("#productNo").val();
				$(this).attr('href',
				'${path}/basket/insertBasket.do?productNo='+ productNo
				+ '&amount=' + amount);
				});

			});
				
	  $(function(){
	  		$.ajax({
	  			url: "${path}/shop/selectReviewList.do",
	    		cache: false,
	    		data : {productNo : ${product.productNo}},
	    		dataType : "html",
	    		success : function(data){
	   			$("#review-container").html('');
	   			$("#review-container").html(data);
		    		},
	    		error:function(request,status,error){
	    	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    	       }	
		  		});
	  	});
				  
				  
				  
$(function(){
	$(".comment").hide();
	
	//댓글 모양 누르면 보이기
	$("span[name=commentBtn]").click(function(){
		//$(this).parent().parent().parent().next().toggle();
		
		var reviewNo=$(this).next().val();
		console.log(reviewNo);
		$.ajax({
			url: "${path}/shop/selectReviewReply.do",
			data: {reviewNo : reviewNo},
			dataType: "json",
			success : function(data){
				/* 	<div class="row">
				<div class="col" style="font-weight: bolder;">관리자</div>
			</div>
				<div class="row">
				<div class="col-6" style="background-color:#EAEAEA;">
					djdjdjdjjdjdjjd
				</div>
				</div> */
				var str='';
				$.each(data,function(i,v){
					str+="<div class='row'>";
					str+="<div class='col' style='font-weight:bolder;'> 관리자  </div>";
					str+="</div>";
					str+="<div class='row'>";
					str+="<div class='col-6' style='background-color:#EAEAEA;'>";
					str+=v.rrContent;
					str+="</div>";
					str+="</div>";
				});
				$(this).parent().parent().parent().next().append(str);
			}
		});
	});
	
	$(".reply").click(function(){
		var rrContent=$(this).prev().prev().find("textarea").val();
		var reviewNo=$(this).prev().val();
		console.log(rrContent+": "+reviewNo);
		$.ajax({
			url: "${path}/shop/insertReviewReply.do",
			data: {
				rrContent : rrContent,
				reviewNo : reviewNo
			},
			dataType: "html",
			success : function(data){
				
			}
		});
		
	});
	
	
});

</script>
</html>