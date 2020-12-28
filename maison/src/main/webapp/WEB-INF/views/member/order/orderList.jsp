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
<c:if test="${start eq null }">
	<c:set var="start" value="-1M"/>
	<c:set var="end" value="today"/>
</c:if>
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
				<div id="date-container">
				<form action="${path }/member/order/orderList.do" >
					<input type="text" class="datepicker" id="start" name="start" style="width:100px;">
						~
					<input type="text" class="datepicker" id="end" name="end" style="width:100px;">
					<input type="submit" value="조회">
				</form>
			</div>
				<div id="orderList" >
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
								<a href="${path }/member/order/orderDetail.do?orderNo=${o.orderNo }">
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
							<c:if test="${o.orderStatus eq '취소신청' or o.orderStatus eq '취소완료'}">
								<td>
									
								</td>
							</c:if>
							<c:if test="${o.orderStatus ne '취소신청' and o.orderStatus ne '취소완료'}">
							<td>
								<input type="hidden" value="${od.productNo }" >
								<input type="hidden" value="${od.orderDetailNo }">
								<button class="btn btn-sm addreview" style="background:#F2BB9C">리뷰작성</button>
								<br>
								<button class="btn btn-sm " type="button" style="background:#FCF7E1" onclick="location.href='${path }/member/order/cancel.do?orderNo=${o.orderNo }'">취소신청</button>
							</td>
							</c:if>
						</tr>
							<c:forEach var="ods" items="${o.ods }" begin="1">
							<tr>
								<td><img src="${path }/resources/upload/product/${ods.productImg}" width="100px"></td>
								<td>${ods.productName }</td>
								<td>${ods.odAmount }</td>
								<td>${ods.price*od.odAmount }</td>
								<td>${o.orderStatus }</td>
								<td>
								<input type="hidden" value="${o.orderNo }"
							<c:if test="${o.orderStatus ne '취소신청' and o.orderStatus ne '취소완료'}">
								<input type="hidden" value="${ods.productNo }" >
								<input type="hidden" value="${ods.orderDetailNo }">
									<button class="btn btn-sm addreview" style="background:#F2BB9C">리뷰작성</button>
									<br>
									<button class="btn btn-sm " style="background:#FCF7E1" type="button" onclick="location.href='${path }/member/order/cancel.do?orderNo=${o.orderNo }'">취소신청</button>
								</td>
							</c:if>
							</tr>
							</c:forEach>
						</c:forEach>
						<c:if test="${empty list }">
							<tr>
								<td colspan="7" class="text-center">
									조회된 주문 내역이 없습니다 !
								</td>
							</tr>
						</c:if>
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


		
		
		
		 $("#start").datepicker({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	         ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	         ,changeYear: true //콤보박스에서 년 선택 가능
	         ,changeMonth: true //콤보박스에서 월 선택 가능                
	         ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	         ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	         ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	         ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	         ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	         ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	         ,maxDate: "+0" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       	 ,onClose: function( selectedDate ) {    
	                 // 시작일(fromDate) datepicker가 닫힐때
	                 // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	                 $("#end").datepicker( "option", "minDate", selectedDate );
	             }     
	     });                    
	     
		 $("#end").datepicker({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	         ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	         ,changeYear: true //콤보박스에서 년 선택 가능
	         ,changeMonth: true //콤보박스에서 월 선택 가능                
	         ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	         ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	         ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	         ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	         ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	         ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	         ,maxDate: "+0" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       	 ,onClose: function( selectedDate ) {
	             // 종료일(toDate) datepicker가 닫힐때
	             // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
	             $("#start").datepicker( "option", "maxDate", selectedDate );
	         }                
	     });     
	     //초기값을 오늘 날짜로 설정
	     $('#start').datepicker('setDate', '${start}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)   
		$("#end").datepicker('setDate','${end}');

});
</script>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		