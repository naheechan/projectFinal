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
			<br>
			<br>
			주문정보
				<table class="table ">
					<tr>
						<th style="width:15%">주문 번호</th>
						<td>${o.orderNo }</td>
					</tr>
					<tr>
						<th>주문 일자</th>
						<td><fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>${o.receiver }</td>
					</tr>
					<tr>
						<th>주문 처리상태</th>
						<td>${o.orderStatus }</td>
					</tr>
				</table>
				
				<br>
				결제정보
				<table class="table">
					<tr>
						<th style="width:15%">총 주문금액</th>
						<td>${o.orderPrice }</td>
					</tr>
					<tr>
						<th>사용 적립금</th>
						<td>${o.useMile }</td>
					</tr>
					<tr>
						<th>총 결제금액</th>
						<td>${o.totalPrice }</td>
					</tr>
					<tr>
						<th>결제 수단</th>
						<td>카드 결제</td>
					</tr>
				</table>
				<br>
				주문상품 정보
				<table class="table">
					<tr>
						<th>이미지</th>
						<th>상품명</th>
						<th>수량</th>
						<th>판매가</th>
						<th>주문 처리 상태</th>
						<th>취소/리뷰</th>
					</tr>
					<c:forEach items="${o.ods }" var="od">
						<tr>
						<td><img
							src="${path }/resources/upload/product/${od.productImg}"
							width="100px"></td>
						<td>${od.productName }</td>
						<td>${od.odAmount }</td>
						<td><c:out value="${od.price*od.odAmount }" /></td>
						<td>${o.orderStatus }</td>
						<td><input type="hidden" value="${od.productNo }"> 
						<input type="hidden" value="${od.orderDetailNo }">
							<button class="btn btn-sm addreview">리뷰작성</button> <br>
							<button class="btn btn-sm btn-danger">취소신청</button></td>
						</tr>
						
					</c:forEach>
				
				</table>
				<p style="font-size:18px;" class="text-aligned-end">합계: ${o.totalPrice }</p>
				
				<br>
				배송지 정보
				<table class="table">
					<tr>
						<th style="width:15%">받으시는 분</th>
						<td>${o.receiver }</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td>${o.orZipcode }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${o.orAddress } ${o.orDetailAddress }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${o.orPhone }</td>
					</tr>
					<tr>
						<th>배송메시지</th>
						<td>${o.deliRequest }</td>
					</tr>
				</table>
				
				<button style="margin-bottom:20px"class="btn offset-md-10" onclick="location.href='${path}/member/order/orderList.do'">주문 목록보기</button>
			</div>
				<br>
		</div>
</div>
<div id="pop">
</div>
			

</section>
<script>
$(function(){
			$("#pop").css({
                "top": (($(window).height()-$("#pop").outerHeight())/2+$(window).scrollTop())+"px",
                "left": (($(window).width()-$("#pop").outerWidth())/2+$(window).scrollLeft())+"px"
                //팝업창을 가운데로 띄우기 위해 현재 화면의 가운데 값과 스크롤 값을 계산하여 팝업창 CSS 설정
             
             }); 
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