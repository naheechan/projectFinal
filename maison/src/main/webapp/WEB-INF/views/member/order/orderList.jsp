<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>

<!-- Start With -->

<section>
	<div class="container">
		<div class="row">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<!-- Right Data page  -->
			<div class="col-lg-9 col-md-7">
				<div id="summary" style="margin-top:50px; background-color:#EAEAEA; ">
					<table class="col-lg-8 table table-bordered text-center" style="padding:15px;">
						<tr>
							<td><i class="fas fa-2x fa-box"></i></td>
							<td><i class="fas fa-2x fa-truck"></i></td>
							<td><i class="fas fa-2x fa-undo"></i></td>
							<td><i class="fas fa-2x fa-ban"></i></td>
						</tr>
						<tr>
							<td>주문완료<br>${a }</td>
							<td>배송완료<br>${b }</td>
							<td>취소신청<br>${c }</td>
							<td>취소완료<br>${d }</td>
						</tr>
					</table>
				</div>
				
				<div id="orderList">
					<table class="table table-bordered" style=" vertical-align: middle" align="center">
						<tr>
							<th>[주문번호]<br>주문일자</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>수량</th>
							<th>총 상품가격</th>
							<th>주문 상태</th>
							<th>리뷰/취소신청</th>
						</tr>
						<c:forEach var="o" items="${ list}">
						<tr>
							 <br>
							<td rowspan="${o.odCount }" style=" vertical-align: middle">
								<a href="${path }/member/order/detailOrder?orderNo=${o.orderNo }">
								[${o.orderNo }]
								<br>
								<fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</a>
								</td>
								<c:set var="od" value="${o.ods[0] }"/>
							<td><img src="${path }/resources/upload/product/${od.productImg}" width="100px"></td>
							<td>${od.productName }</td>
							<td>${od.odAmount }</td>
							<td><c:out value="${od.price*od.odAmount }"/></td>
							<td>${o.orderStatus }</td>
							<td>
								<input type="hidden" value="${od.productNo }" >
								<input type="hidden" value="${od.orderDetailNo }">
								<button class="btn btn-sm addreview">리뷰작성</button>
								<br>
								<button class="btn btn-sm btn-danger">취소신청</button>
							</td>
						</tr>
							<c:forEach var="ods" items="${o.ods }" begin="1">
							<tr>
								<td><img src="${path }/resources/upload/product/${ods.productImg}" width="100px"></td>
								<td>${ods.productName }</td>
								<td>${ods.odAmount }</td>
								<td>${ods.price*od.odAmount }</td>
								<td>${o.orderStatus }</td>
								<td>
								<input type="hidden" value="${ods.productNo }" >
								<input type="hidden" value="${ods.orderDetailNo }">
									<button class="btn btn-sm addreview">리뷰작성</button>
									<br>
									<button class="btn btn-sm btn-danger">취소신청</button>
								</td>
							</tr>
							</c:forEach>
						</c:forEach>
					</table>
				</div>
				<div>
				${pageBar }
				</div>
				<br>
			</div>
		</div>
	 </div> 
	 <div id="pop">
	 </div>
</section>
<script>
$(function(){
	//리뷰쓰는 팝띄우기		
		$(".addreview").click(function(){
			
			var productNo=$(this).prev().prev().val();
			var orderDetailNo=$(this).prev().val();
			
			$("#pop").css({
                "top": (($(window).height()-$("#pop").outerHeight())/2+$(window).scrollTop())+"px",
                "left": (($(window).width()-$("#pop").outerWidth())/2+$(window).scrollLeft())+"px"
                //팝업창을 가운데로 띄우기 위해 현재 화면의 가운데 값과 스크롤 값을 계산하여 팝업창 CSS 설정
             
             }); 
			
			
			$.ajax({
				url : "${path }/shop/insertReview.do",
				data:{
					orderDetailNo : orderDetailNo,
					productNo : productNo	
				
				},
				dataType : "html",
				success : function(data){
					$("#pop").html("");
					$("#pop").html(data);
					$("#pop").show();
				}
						
			})
				
			});
		
		
		
		//닫기누르면 없애기
		$(".closebtn").click(function(){
			$("#pop").hide();
		});
		
		
		
		$(":checkbox").css("display","none"); 
		
		$(":checkbox").click(function(){
			var score= $(this).val();
			console.log(score);
			switch(score){
			
			case '1': 
				$("#rating1").prop("checked",true);
				$("#rating2").prop("checked",false);
				$("#rating3").prop("checked",false);
				$("#rating4").prop("checked",false);
				$("#rating5").prop("checked",false);
				$("#rating2").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating3").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating4").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating5").next().children("span").removeClass("starOn").addClass("starOff");
				break;
			case '2': 
				$("#rating1").prop("checked",false);
				$("#rating2").prop("checked",true);
				$("#rating3").prop("checked",false);
				$("#rating4").prop("checked",false);
				$("#rating5").prop("checked",false);
				$("#rating2").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating3").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating4").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating5").next().children("span").removeClass("starOn").addClass("starOff");
				break;
			case '3': 
				$("#rating1").prop("checked",false);
				$("#rating2").prop("checked",false);
				$("#rating3").prop("checked",true);
				$("#rating4").prop("checked",false);
				$("#rating5").prop("checked",false);
				$("#rating2").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating3").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating4").next().children("span").removeClass("starOn").addClass("starOff");
				$("#rating5").next().children("span").removeClass("starOn").addClass("starOff");
				break;
			case '4': 
				$("#rating1").prop("checked",false);
				$("#rating2").prop("checked",false);
				$("#rating3").prop("checked",false);
				$("#rating4").prop("checked",true);
				$("#rating5").prop("checked",false);
				$("#rating2").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating3").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating4").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating5").next().children("span").removeClass("starOn").addClass("starOff");
				break;
			case '5': 
				$("#rating1").prop("checked",false);
				$("#rating2").prop("checked",false);
				$("#rating3").prop("checked",false);
				$("#rating4").prop("checked",false);
				$("#rating5").prop("checked",true);
				$("#rating2").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating3").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating4").next().children("span").removeClass("starOff").addClass("starOn");
				$("#rating5").next().children("span").removeClass("starOff").addClass("starOn");
				break;
			
			
			}
		
		
		});



});
</script>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		