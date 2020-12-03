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
	.starOn{
		color:#f2bb9c;
	}
	
	.rating .rate_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    cursor: pointer;
}
	
	
</style>
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>
</head>
<body>

<form action="${path }/notice/noticeAddEnd.do" method="post" id="noticeForm">
	<div id="data-div">
		<div class="form-group required">
		    <label for="noticeTitle" class="control-label" >별점</label>
		    <br>
			<label>
			<input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점">
			<label for="rating1">
				<span class="starOn"><i class="fas fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
			<label for="rating2">
				<span class="starOn"><i class="fas fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점">
			<label for="rating3">
				<span class="starOn"><i class="fas fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
			<label for="rating4">
				<span class="starOn"><i class="fas fa-star"></i></span>
			</label>
			
			<input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
			<label for="rating5">
				<span class="starOn"><i class="fas fa-star"></i></span>
			</label>
			
			
			
			
			
			</label>
		</div>
		<br>
		<div class="form-group required">
		    <label for="reviewContent" class="control-label">내용</label>
		    <br>
		   <textarea name="noticeContent" id="noticeContent"></textarea>
		</div>
		<input type="submit" class="btn btn-success" id="savebutton" value="등록" />
	</div>


</form>
</body>
<script>
	$(function(){
		
	});

</script>
</html>