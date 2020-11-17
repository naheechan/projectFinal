<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="상품등록" />
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="상품등록" />
</jsp:include>

<!-- Start -->
<div class="shop-list-box">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 col-lg-5 col-md-6"></div>
		</div>
	</div>
</div>
<!-- End -->
<div class="wrapper">
  
  <div class="contact-form">
    <div class="input-fields">
    <select name="largeCate">
    	<option value="">대분류</option>
    	<option value="주방">주방</option>
    	<option value="욕실">욕실</option>
    	<option value="세탁실">세탁실</option>
    	<option value="현관">현관</option>
    	<option value="창고">창고</option>
    </select>
    <select name="mediumCate">
    	<option value="">중분류</option>
    	<option value="1">세제</option>
    	<option value="2">치약</option>
    </select>
      상품이름<input type="text" class="input" placeholder="Name">
      상품이미지<input type="file" placeholder="image">
      상품요약설명<input type="text" class="input" placeholder="상품요약">
      <!-- 에디터 -->
      
      상품재고수량<input type="range" class="input" placeholder="재고수량">
      상품판매상태<input type="radio" class="input" placeholder="판매상태">
      가격<input type=number placeholder="가격">
      기본주기일<input type="text" placeholder="ex)28일">
    </div>
    <div class="msg">
      <textarea placeholder="Message"></textarea>
      <div class="btn">send</div>
    </div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
