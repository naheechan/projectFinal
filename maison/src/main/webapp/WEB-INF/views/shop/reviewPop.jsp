<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	#data-div {
		border: 1px solid lightgray;
		padding: 2%;
	}
	
	#info-div {
		margin-top: 1%;
		margin-bottom: 1%;
		padding: 2%;
		background-color: #F9F9FA;
	}
	
	.form-group.required .control-label:after {
		color: #d00;
		content: "*";
		position: absolute;
		margin-left: 6px;
	}
	
	.starOn {
		color: #f2bb9c;
		cursor: pointer;
	}
	
	.rating .rate_radio+label {
		position: relative;
		display: inline-block;
		margin-left: -4px;
		z-index: 10;
		cursor: pointer;
	}
		
	.starOff{
		color:#C3C3C3;
		cursor: pointer;
	}
	
	input[type=checkbox] {
		display: none;
	}
	img{
		float:left;
	}
	img+p{
		float:left;
		margin-left:30px;
	}
	br{
	}
	
	.title{
		font-size:20px;
		font-weight:bold;
		color : black;
	}
	.clear-both{
		clear:both;
	}

	td{
		padding-left:20px;
	}

	#pop{
		width:500px;
		height:600px;
		position:absolute;
		top:100px;
		left:300px;
		text-align:center;
		border :2px solid #f2bb9c; 
		z-index: 100;
		background-color:white;
	}

</style>
<div class="container">
<div class="row">
<div class="col">
<form action="${path }/shop/insertReviewEnd.do" method="get" id="reviewForm">
	<div id="data-div review-container">
						<div class="form-group">
							<label class="control-label">구매 후기 쓰기</label> <br>
							<table>
								<tr>
									<td rowspan="2"><img
										src="${path }/resources/upload/product/${p.productImg}"
										width="150px" /></td>
									<td>
										<p class="title">${p.productName }</p>
										<input type="hidden" name="productNo" value="${p.productNo }">
									</td>
								</tr>
								<tr>
									<td>
										<p>${p.productSummary }</p>
									</td>
								</tr>
							</table>
							<p class="clear-both"></p>
						</div>
						<hr>
		<div class="form-group required">
		    <label for="reviewScroe" class="control-label" >별점</label>
		    <br>
			<label>
			<input type="checkbox" name="reviewScore" id="rating1" value="1"  class="rate_radio" title="1점">
			<label for="rating1">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="reviewScore" id="rating2" value="2" class="rate_radio" title="2점">
			<label for="rating2">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="reviewScore" id="rating3" value="3" class="rate_radio" title="3점">
			<label for="rating3">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="reviewScore" id="rating4" value="4" class="rate_radio" title="4점">
			<label for="rating4">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="reviewScore" id="rating5" checked value="5" class="rate_radio" title="5점">
			<label for="rating5">
				<span class="starOn"><i class="fas  fa-2x fa-star"></i></span>
			</label>
			
			</label>
		</div>
		<hr>
		<div class="form-group required">
		    <label for="reviewContent" class="control-label">내용</label>
		    <br>
		   <textarea class="form-control" name="reviewContent" rows="5" id="reviewContent" required></textarea>
		</div>
		<input type="submit" class="btn btn-success" id="savebutton" value="등록" />
		<input type="button" class="btn closebtn" value="닫기">
	</div>


</form>
</div>
</div>
</div>

<script>
$(function(){
	//닫기누르면 없애기
	$(".closebtn").click(function(){
		$("#pop").hide();
	});
})

</script>	