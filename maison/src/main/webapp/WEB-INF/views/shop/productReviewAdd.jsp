<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="${path }/resources/css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="${path }/resources/css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${path }/resources/css/custom.css"> 

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>
<script src="${path }/resources/js/jquery-ui.js"></script>
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

}

</style>
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
<div class="row">
<div class="col-8">
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
			<input type="checkbox" name="rating" id="rating1" value="1"  class="rate_radio" title="1점">
			<label for="rating1">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
			<label for="rating2">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점">
			<label for="rating3">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
			<label for="rating4">
				<span class="starOn"><i class="fas fa-2x fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
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
	</div>


</form>
</div>
</div>
</div>
</body>
<script>
	$(function(){
		$(":checkbox").css("display","none"); 
		
		$(":checkbox").click(function(){
			var score= $(this).val();
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
<script
  src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"
  integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk="
  crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath() %>/resources/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/jquery.superslides.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap-select.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/inewsticker.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootsnav.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/images-loded.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/isotope.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/baguetteBox.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/form-validator.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/contact-form-script.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/custom.js"></script>
</html>