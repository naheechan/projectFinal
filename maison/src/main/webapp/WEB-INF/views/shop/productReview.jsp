<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />


<style>
.star-rating {
	width: 95px;
}

.star-rating, .star-rating span {
	display: inline-block;
	height:16.5px;
	overflow: hidden;
	background: url(${path}/resources/images/star.png) no-repeat;
}

.star-rating span {
	background-position: left bottom;
	line-height: 0;
	vertical-align: top;
}
</style>
</head>
<body>

<div>
<div class="row">
	<div class="col">
	<h2>${score }</h2>
</div>
</div>
<div class="row">
<div class="col">	
<div class='star-rating'>
	<span style ="width:${percent}%"></span>
</div>
</div>
</div>
<div class="row">
	<div class="col">
	
	<p> 총 ${count }개의 리뷰가 있습니다.</p>
	</div>
</div>
<hr>
<div class="container">
<c:forEach var="r" items="${list }">
	<div class="row">
		<div class="col">
			<div class='star-rating'>
				<c:if test="${r.reviewScore eq 5 }">
					<span style ="width:100%"></span>
				</c:if>
				<c:if test="${r.reviewScore eq 4 }">
					<span style ="width:80%"></span>
				</c:if>
				<c:if test="${r.reviewScore eq 3 }">
					<span style ="width:60%"></span>
				</c:if>
				<c:if test="${r.reviewScore eq 2 }">
					<span style ="width:40%"></span>
				</c:if>
				<c:if test="${r.reviewScore eq 1 }">
					<span style ="width:20%"></span>
				</c:if>				
			</div>
			
		</div>
			<div class="col">
				${r.memberId }
			</div>
		
	</div>
		<div class="row">
			<div class="col">
				${r.reviewContent }
			</div>
			
		
		</div>
		<div class="row">
			<div class="col">
				<div class="justify-content-end">
					<span name="commentBtn" class="justify-content-end"><i class="far fa-comment-dots"></i></span>
					<input type="text" name="reviewNo" value="${r.reviewNo }">
				</div>
			</div>
		</div>
		
		<div class="comment" >
			여기들어가ㅑㅇ하는데
		</div>
		
		
		
	<hr>
</c:forEach>
</div>
</div>

<script>
$(function(){
	$(".comment").hide();
	
	//댓글 모양 누르면 보이기
	$("span[name=commentBtn]").click(function(){
		$(this).parent().parent().parent().next().toggle();
		
		var reviewNo=$(this).next().val();
		console.log(reviewNo);
		$.ajax({
			url: "${path}/shop/selectReviewReply.do",
			data: {reviewNo : reviewNo},
			dataType: "json",
			success : function(data){
				console.log("ajax통신 성공")
				var str='';
				$.each(data,function(i,v){
					console.log(v.rrContent);
					str+="<div class='row'>";
					str+="<div class='col' style='font-weight:bolder;'> 관리자  </div>";
					str+="</div>";
					str+="<div class='row'>";
					str+="<div class='col-6' style='background-color:#EAEAEA;'>";
					str+=v.rrContent;
					str+="</div>";
					str+="</div>";
				});
				$(this).parent().parent().parent().next(".comment").append(str);
				//$(".comment").append(str);
			},
			error : function(){
				console.log("ajax통신실패")
			}
		});
	});
	
	$(".reply").click(function(){
		var rrContent=$(this).prev().prev().find("textarea").val();
		var reviewNo=$(this).prev().val();
		console.log(rrContent+": "+reviewNo);
		$.ajax({
			url: "${path}/shop/insertReviewReply.do",
			data: {
				rrContent : rrContent,
				reviewNo : reviewNo
			},
			dataType: "html",
			success : function(data){
				
			}
		});
		
	});
	
	
});

</script>
