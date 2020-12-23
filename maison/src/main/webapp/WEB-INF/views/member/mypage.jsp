<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="마이페이지"/>
</jsp:include>
<style>
	.big{
		font-size:30px;
		color:#F2BB9C;
		padding-top:5px;
		padding-bottom:5px;
	}
</style>
<!-- Start Mypage -->
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
						<div class="col-lg-5">
							<br>
						 <h4><strong>${loginMember.memberName }</strong>님의</h4>
						 <h5>회원등급은 
						 	<span style="color:#F2BB9C;font-size:1.3em;" id="uppergradeCode"> 
						 	</span>&nbsp;등급 입니다.
						 	<input type="hidden" id="lowergradeCode" value="${loginMember.gradeCode }"/>
						 </h5>
						 <script>
						 	$(document).ready(function(){
						 		var lower = $("#lowergradeCode").val();
						 		console.log(lower);
						 		var upper = lower.toUpperCase();
						 		console.log(upper);
						 		$("#uppergradeCode").html(upper);
						 		
						 	});
						 </script>
						 <h5>적립금 : <c:out value="${loginMember.meileage }"/> 원</h5>
						</div>
						<div class="col-lg-7">
							<div class="table-main table-responseive">
								<table class="table table-bordered">
									<tbody>
										<tr style="text-align:center;">
											<td>
												<i class="fas fa-paper-plane big"></i>
											</td>
											<td>
												<i class="fas fa-heart big"></i>
											</td>
											<td>
												<i class="fas fa-question big"></i>
											</td>
											<td>
												<i class="fas fa-shipping-fast big"></i>
											</td>
										</tr>
										<tr style="text-align:center;">
											<td>입고신청&nbsp;<span class="badge">5</span></td>
											<td>위시리스트&nbsp;<span class="badge">1</span></td>
											<td>질문 / 답변&nbsp;<span class="badge">3</span></td>
											<td>주문 / 배송&nbsp;<span class="badge">2</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					 <hr style="background-color:rgba(242,187,156,0.5);"/>			
				</div>
				<br/>
				<div id="shipment-div" class="table-main table-responsive">
				<h2>최근 주문 정보</h2>
					<table class="table table-hover" style="text-align:center;">
						<thead>
							<th colspan="2">상품정보</th>
							<th>주문일자</th>
							<th>주문번호</th>
							<th>주문금액(수량)</th>
							<th colspan="2">주문상태</th>
						</thead>
						<tbody>
							<!-- forEach로 데이터 쏘기 
								Order만들어지면 여기에 띄우기
								orderNo자릿수 채크해서 8자리에서 자릿수 뺀만큼 앞에 0붙이고 
									orderDate fmt로 앞에 잘라서 2020120400000001 이런식으로 만들기
								 -->
							<tr>
								<td>
									<img src="${path }/resources/upload/product/product.jpg" style="width:60px;"/>
								</td>
								<td>
									옵티프리	
								</td>
								<td>
									2020.12.04
									
								</td>
								<td>
									<a href="#">2020120400000001</a>
								</td>
								<td>
									<p>2,000원</p>
									<p>1개</p>
								</td>
								<td>
									결제완료
								</td>
								<td>
								<!-- status에 따라서 보이는 버튼이 달라야함. 
									결제완료일 경우에는 취소와 리뷰작성 모두 가능해야하고, 배송완료일때는 리뷰쓰기만 가능 -->
									<div class="form-group col-md-12">
										<button class="btn" type="button" style="width:100%;height:45%;margin-bottom:4%;background:#FCF7E1;">취소요청</button>
										<br>
										<input type="hidden" name="productNo" value="4">
										<input type="hidden" name="orderDetailNo" value="13">
										<button class="btn addreview" type="button" style="width:100%;height:45%;background:#F2BB9C;">리뷰쓰기</button>
									</div>
								</td>
							</tr>
						
						</tbody>
					</table>	
				</div>
			</div>
		</div>
	 </div> 
	 <div id="pop">
	 </div>
</section>
<!-- End Mypage -->
<script>


	$(function(){
		//리뷰쓰는 팝띄우기		
		$(".addreview").click(function(){
			var productNo=$(this).prev().prev().val();
			var orderDetailNo=$(this).prev().val();
			
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		