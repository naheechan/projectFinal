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
		margin-bottom:15%;
	}
	#btn{
		float:right;
		margin-top:15%;
	}
	input{
		font-size:20px;
	}
	select{
		font-size:23px;
	}
	#Catecontainer{
		background:#F2BB9C;
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
<form action="${ path }/admin/product/enrollCate.do" name="submitForm" method="post">
<div id="largeCateArea">
<label for="category" class="label-title">카테고리 [대]*</label><br>
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
<input type="text"  name="mcName" id="mcName" size="38" required>
<button type="button" class="btn" id="btn">등록</button>
</div>
</form>
</div>
<script>

$(function(){
	
	$("#btn").click(function(){
		var insertCate = $('[name=submitForm]').serialize();
		enrollCate(insertCate);
	});
	
	function enrollCate(insertCate){
		$.ajax({
			url:"${ path }/admin/product/enrollCate.do",
			type:"post",
			data:insertCate,
			success:function(data){
				if(data==1){
					console.log("ajax통신성공");
					alert("카테고리 추가 등록 성공");
					self.close();
				}else{
					alert("카테고리 추가 등록이 실패하였습니다.")
				}
			},
			error:function(){
				console.log("ajax통신실패");
			}
		})

	};
	
})	

</script>
