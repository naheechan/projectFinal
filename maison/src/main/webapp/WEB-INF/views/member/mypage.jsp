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

<!-- Start Mypage -->
<section>
	<!--  <div class="container">-->
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
						 <h3><strong>${loginMember.memberName }</strong>님의</h3>
						 <h3>회원등급은 
						 	<span style="color:#F2BB9C;" id="uppergradeCode"> 
						 	</span>&nbsp;등급 입니다.
						 	<input type="hidden" id="lowergradeCode" value="${loginMember.gradeCode }"/>
						 </h3>
						 <script>
						 	$(document).ready(function(){
						 		var lower = $("#lowergradeCode").val();
						 		console.log(lower);
						 		var upper = lower.toUpperCase();
						 		console.log(upper);
						 		$("#uppergradeCode").html(upper);
						 		
						 	});
						 </script>
						 <h3>적립금 : <c:out value="${loginMember.meileage }"/> 원</h3>
						</div>
						<div class="col-lg-7">
							<div class="table-main table-responseive">
								<table class="table table-bordered">
									<tbody>
										<tr style="text-align:center;">
											<td>
												<i class="fas fa-paper-plane" style="font-size:50px;color:#F2BB9C;"></i>
											</td>
											<td>
												<i class="fas fa-heart" style="font-size:50px;color:#F2BB9C;"></i>
											</td>
											<td>
												<i class="fas fa-question" style="font-size:50px;color:#F2BB9C;"></i>
											</td>
											<td>
												<i class="fas fa-shipping-fast" style="font-size:50px;color:#F2BB9C;"></i>
											</td>
										</tr>
										<tr style="text-align:center;">
											<td>입고신청</td>
											<td>위시리스트</td>
											<td>질문 / 답변</td>
											<td>주문 / 배송</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					 <hr style="background-color:rgba(242,187,156,0.5);"/>			
				</div>
			</div>
		</div>
	<!-- </div> -->
</section>
<!-- End Mypage -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		