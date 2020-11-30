<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<style>
	.form-control{
		width:90%;
	}
	#Catecontainer{
		padding:10%;
		margin-bottom:25%;
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
<h2>카테고리 추가등록</h2><br>
<div id="Catecontainer">
<form action="${ path }/admin/product/enrollCate.do">
<div id="largeCateArea">
<label for="category" class="label-title">카테고리 [대]*</label>
            <select class="form-control" id="largeCate" name="largeCate">
            	<option value="주방">주방</option>	
            	<option value="욕실">욕실</option>
            	<option value="세탁실">세탁실</option>
            	<option value="현관">현관</option>
            	<option value="창고">창고</option>
            </select>
</div>
<div id="mediCateArea">
<label for="category" class="label-title">카테고리 [중]*</label>
<br>
<input type="text" id="mediCate" name="mcName" size="32">
</div>
<button type="button" class="btn" id="btn">등록</button>
</form>
</div>
<script>

$(function(){
	
	
	$("#btn").click(function(){
		alert("click");
		
	});
})	

</script>
