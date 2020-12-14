<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.kh.maison.common.crypto.AES256Util,com.kh.maison.member.model.vo.Member" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="문의하기"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="문의하기"/>
</jsp:include>
<style>
	#data-div{
		border:1px solid lightgray;
		padding:2%;
	}
	#info-div{
		margin-top:1%;
		margin-bottom:1%;
		padding:2%;
		background-color:#F9F9FA;
	}
	.form-group.required .control-label:after{
	   color: #d00;
	   content: "*";
	   position: absolute;
	   margin-left: 6px;
	}
	.pi-list-box{
		margin:7% 0% 7% 0;
	}
</style>

<!-- Start With Enroll-->
<div class="pi-list-box">
	<div class="container">
		<form action="${path }/shop/user/inquiryEnd.do" method="post" id="inquiryForm">
			<input type="hidden" value="${productOne.productNo }" name="productNo">
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
					</div>
				</div>
			<div id="info-div">
				■ 개인정보의 수집·이용 목적
				<br>
				서비스 제공 및 계약의 이행, 구매 및 대금결제, 물품배송 또는 청구지 발송, 회원관리 등을 위한 목적
				<br>
				■ 수집하려는 개인정보의 항목
				<br>
				이름, 주소, 연락처 등
				<br>
				■ 개인정보의 보유 및 이용 기간
				<br>
				회사(maison)은 개인정보 수집 및 이용목적이 달성된 후에는 예외없이 해당정보를 파기합니다. 
			</div>
			<button type="reset" class="btn btn-light" style="float:right;">다시쓰기</button>
			<button type="submit" class="btn" style="float:right;background-color:#F2BB9C; margin-right:2%;">등록하기</button>
		</form>	
	</div>
</div>
<!-- End With -->
<script>
	$(function(){
		if($("#piCate").val()=""){
			
			return false();
		}
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	