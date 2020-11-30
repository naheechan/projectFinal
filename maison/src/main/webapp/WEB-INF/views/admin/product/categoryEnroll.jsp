<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="카테고리등록"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="카테고리등록"/>
</jsp:include>
<style>
	.form-control{
		width:90%;
	}
	#Catecontainer{
		padding:10%;
		margin-bottom:30%;
	}
	#btn{
		float:right;
		margin-top:15%;
	}
</style>
<!-- Start -->
<div class="shop-list-box">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 col-lg-5 col-md-6"></div>
		</div>
	</div>
</div>
<br><br>
<!-- End -->
<div id="Catecontainer">
<form action="${ path }/admin/product/enrollCate.do">
<div id="largeCateArea">
<label for="category" class="label-title">카테고리 [대]*</label>
            <select class="form-control" id="largeCate" name="largeCate" >
            	<option value="주방">주방</option>	
            	<option value="욕실">욕실</option>
            	<option value="세탁실">세탁실</option>
            	<option value="현관">현관</option>
            	<option value="창고">창고</option>
            </select>
</div>
<div id="mediCateArea">
<label for="category" class="label-title">카테고리 [중]*</label>
<input type="text" id="mediCate" name="mcName" size="39">
</div>
<button type="submit" class="btn" id="btn">등록</button>
</form>
</div>
