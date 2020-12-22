<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원탈퇴"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="마이페이지  / 회원탈퇴"/>
</jsp:include>
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Start withdraw Page -->
<section>
	<div class="container">
		<div class="row">
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<div class="col-lg-9 col-md-7">
				<div class="data-div">
					<form action="${path }/member/withdrawEnd.do" method="post">
						<input type="hidden" value="${loginMember.memberId }" name="memberId"/>
						<br/>
						<h2>회원 탈퇴</h2>
						<hr>
							<div class="row">
								<div class="col-lg-12">
									<br/>
									<h3>탈퇴 유의사항</h3>
									<hr style="height:0.6px; background-color:rgba(0,0,0,0.7);">
									<h3><strong>적립금 소멸</strong></h3>
									<ul>
										<li>회원탈퇴 시 보유하고 계신 적립금이 자동 소멸되며 복원되지 않습니다.</li>
										<li>적립금 관련하여 미결사항이 있으신 경우 반드시 메종에 문의하신 후 탈퇴해주세요.</li>
									</ul>
									<br>
									<h4>나의 적립금</h4>
									<div class="table-main table-responsive">
										<table class="table table-hover">
											<thead>
												<td>사용 가능 금액 </td>
											</thead>
											<tbody>
												<tr>
												<c:set var="priceFormat"><fmt:formatNumber value="${loginMember.meileage }"/></c:set>	
													<td><c:out value="${priceFormat }"/></td>
												</tr>
											</tbody>
										</table>
									</div>
									<h3>탈퇴사유 및 개선점(선택)</h3>
									<hr style="height:0.6px; background-color:rgba(0,0,0,0.7);">
									<div class="form-group">
		  								<textarea class="form-control" rows="3" id="comment" style="resize:none;" name="withdrawCom" placeholder="메종에 해주고 싶은 말씀을 자유롭게 입력해주세요. (100자 이내)"></textarea>
									</div>
									 <div class="form-check">
									    <input type="checkbox" class="form-check-input" id="withdrawChk" name="withdrawChk" value="N"/>
									    <label class="form-check-label" for="withdrawChk"> 회원탈퇴 유의사항을 모두 확인하였으며, 메종 회원탈퇴에 동의합니다.</label>
									  </div>
									<hr>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12" style="text-align:center;">
									<button class="btn" type="submit" style="background:#F2BB9C;">&nbsp;&nbsp;&nbsp;확인&nbsp;&nbsp;&nbsp;</button>
								</div>
							</div>
							<br>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- End withdraw Page -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	
