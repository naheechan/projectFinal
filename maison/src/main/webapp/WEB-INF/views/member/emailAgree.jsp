<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%@ page import="com.kh.maison.common.crypto.AES256Util,com.kh.maison.member.model.vo.Member" %>
<!-- loginMember의 값들은 암호화가 된채로 넘어온다. 그러므로 aes와 session값을 가지고 decrypt처리해준다. -->
<%
	AES256Util aes = new AES256Util();
	Member m = (Member)session.getAttribute("loginMember");
	String dEmail = aes.decrypt(m.getEmail());
	String dPhone = aes.decrypt(m.getPhone());
%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이메일 수신 동의"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="마이페이지  / 이메일 수신 동의"/>
</jsp:include>
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- Start emailAgree -->
<section>
	<div class="container">
		<div class="row">
		<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<div class="col-lg-9 col-md-7">
				<div class="data-div">
					<form action="${path }/member/emailAgreeEnd.do" method="post">
						<input type="hidden" value="${loginMember.memberId }" name="memberId"/>
						<br/>
						<h2>이메일  수신 동의</h2>
						<hr>
							<div class="row">
								<div class="col-lg-12">
									<br/>
									<h3 >연락처 정보</h3>
									<hr style="height:0.6px; background-color:rgba(0,0,0,0.7);">
									<table class="table table-borderless">
										<tbody>
											<tr>
												<th>이메일 주소</th>
												<td><%=dEmail %></td>
											</tr>
											<tr>
												<th>휴대폰 번호</th>
												<td><%=dPhone %></td>
											</tr>
										</tbody>
									</table>
									<hr>
									<span>※ 이메일주소 및 휴대폰번호는 개인정보수정 메뉴에서 변경하실 수 있습니다.</span>
								    <c:choose>
		                    			<c:when test="${empty loginMember.memberPw }">
				                        	<a href="${path }/member/updateNaver.do" class="btn btn-light" style="float:right;">
				                        		바로가기 
				                        	</a>		                    			
		                    			</c:when>
		                    			<c:otherwise>
				                        	<a href="${path }/member/update.do" class="btn btn-light" style="float:right;">
				                        		바로가기
				                        	</a>    			
		                    			</c:otherwise>
		                    		</c:choose>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<br/>
									<h3 >주기알림 서비스 동의여부</h3>
									<hr style="height:0.6px; background-color:rgba(0,0,0,0.7);">
									 <div class="form-check">
									    <input type="checkbox" class="form-check-input" id="emailStatus" name="emailStatus" value="Y"
									    ${loginMember.emailStatus eq 'Y' ? 'checked' :'' }>
									    <label class="form-check-label" for="emailStatus"><strong>(선택)</strong> 주기 알림 서비스 제공을 위한 개인정보 수집 및 이용 동의</label>
									  </div>
									  <hr>
									  <span>※ 회원정보, 구매정보 및 서비스 주요 정책 관련 내용은 수신 동의 여부와 관계없이 발송됩니다.</span>
								</div>
							</div>
							<br>
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
<!-- End emailAgree -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	