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
	<h2> &nbsp;&nbsp;${score }</h2>
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
	
	<p> 총 ${count }개의 리뷰가 있습니다. </p>
	</div>
</div>
<hr>
<div class="container">
<c:forEach var="r" items="${list }">
	<div class="row">
		<div class="col-9">
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
			<div class="col offset-md-9">
				<div class="justify-content-end">
					<span name="commentBtn" class="justify-content-end" style="margin-top:5px;"><i class="far fa-comment-dots"></i></span>
					<input type="hidden" name="reviewNo" value="${r.reviewNo }">
				</div>
			</div>
		</div>
		
		<div class="comment" id="open_${r.reviewNo }" >

		</div>
		<div class="comment-input">
			<div class="row" style="margin-top:20px;">
				<c:if test="${loginMember.memberId eq 'admin' }">
				<div class="col-1" >
				<p>답글 달기</p>
				</div>
				<div class="col-7">
				<input type="hidden" name="reviewNo" value="${r.reviewNo }" >
				<textarea id="origin-ta" style="width:100%; resize:none;" cols="50"  wrap="hard"></textarea>
				<button class="btn insert-reply" >등록하기</button>
				</div>
				</c:if>
			</div>
		</div>
		
		
		
	<hr>
</c:forEach>
</div>
</div>

<script>

//답변 div 생성하기
/* function makereplydiv(rrContent,rrNo,reviewNo){
	str+="<div class='row' style='margin-top:20px;'>";
	str+="<div class='col' style='font-weight:bolder;'> Maison  </div>";
	str+="</div>";
	str+="<div class='row'>";
	str+="<div class='col-8' style='background-color:#EAEAEA;'>";
	str+="<p style='margin:10px;'>";
	str+=rrContent;
	str+="</p>";
	str+="</div>";
	str+="<c:if test='${loginMember.memberId eq \'admin\' }'>";
	str+="<button class='offset-md-7 btn btn-sm update-reply' >"
	str+="수정";
	str+="</button>";
	str+="&nbsp;&nbsp;";
	str+="<button class='btn btn-sm delete-reply' onclick='deletereply("+rrNo+","+reviewNo+")' >"
	str+="삭제";
	str+="</button>";
	str+="<input type='hidden' value='"+rrNo+"'>";
	str+="</c:if>";
	str+="</div>";
}; */



//답변 삭제하기
function deleteReviewReply(rrNo,reviewNo){
	$.ajax({
		url: "${path}/shop/deleteReply.do",
		data : {
			rrNo : rrNo,
			reviewNo : reviewNo
		},
		dataType: "json",
		success: function(data){
			var str='';
			$.each(data,function(i,v){
				var rrCont=v.rrContent.replace(/<br>/gi, "\r\n");
				str+="<div class='row' style='margin-top:20px;'>";
				str+="<div class='col' style='font-weight:bolder;'> Maison  </div>";
				str+="</div>";
				str+="<div class='row'>";
				str+="<div class='col-8' style='background-color:#EAEAEA;'>";
				str+="<p style='margin:10px;' id='p_"+v.rrNo+"'>";
				str+=v.rrContent;
				str+="</p>";
				str+="</div>";
				str+="<c:if test='${loginMember.memberId eq \'admin\' }'>";
				str+="<button id='rrupdate_"+v.rrNo+"' class='offset-md-7 btn btn-sm update-reply' onclick='updateReviewReply("+v.rrNo+","+v.reviewNo+")'>"
				str+="수정";
				str+="</button>";
				str+="&nbsp;&nbsp;";
				str+="<button class='btn btn-sm delete-reply' onclick='deleteReviewReply("+v.rrNo+","+v.reviewNo+")' style='cursor:pointer'>"
				str+="삭제";
				str+="</button>";
				str+="<input type='hidden' value='"+v.rrNo+"'>";
				str+="</c:if>"
				str+="</div>";
			});
			$("#open_"+reviewNo).html(str);
		},
		error: function(){
			console("ajax 통신 실패");
		}
	});



};

//답변 수정하기
function updateReviewReply(rrNo,reviewNo){
	/* 
	 $(this).prev().prev().replaceWith("<form name='updateReviewReply'>
			 <textarea class='col-8' id='rrContent' name='rrContent' rows='6' style='resize:none;' required>"+rrCont+"</textarea>
	 <input type='hidden' id='rrNo' name='rrNo' value='"+rrNo+"'></form>");
         $(this).replaceWith("<a name='after_adminModi' id='after_adminModi' style='float:right;'>답글 수정</a>");
         /* modiAdminReply(no); */

	var rrContent=$("#p_"+rrNo).html();
    console.log(rrContent);
	var rrCont=rrContent.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	console.log(rrCont);
	var update="<form name='updateReviewReplyFrm'><textarea class='col-8' id='rrContent_"+rrNo+"' name='rrContent' rows='6' style='resize:none;' required>"+rrCont+"</textarea><input type='hidden' id='rrNo' name='rrNo' value='"+rrNo+"'></form>";
	update+="<input type='hidden' id='rrNo' name='rrNo' value='"+rrNo+"'></form>";
	
	
	
	$("#p_"+rrNo).replaceWith(update);
	$("#rrupdate_"+rrNo).replaceWith("<button class='offset-md-7 btn btn-sm update-reply' onclick='updateReviewReplyEnd("+rrNo+","+reviewNo+")'>수정완료</button>");
	$("#rrupdate_"+rrNo).next().replaceWith("<button>취소</button>")
	
}

function updateReviewReplyEnd(rrNo,reviewNo){
	
	var rrContent=$("#rrContent_"+rrNo).val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
	console.log(rrContent+":rrContent");
	
	$.ajax({
		url : "${path}/shop/updateReviewReply.do",
		data : {
			rrContent : rrContent,
			rrNo : rrNo,
			reviewNo : reviewNo
		},
		success : function(data){
			var str='';
			$.each(data,function(i,v){
				var rrCont=v.rrContent.replace(/<br>/gi, "\r\n");
				str+="<div class='row' style='margin-top:20px;'>";
				str+="<div class='col' style='font-weight:bolder;'> Maison  </div>";
				str+="</div>";
				str+="<div class='row'>";
				str+="<div class='col-8' style='background-color:#EAEAEA;'>";
				str+="<p style='margin:10px;' id='p_"+v.rrNo+"'>";
				str+=v.rrContent;
				str+="</p>";
				str+="</div>";
				str+="<c:if test='${loginMember.memberId eq \'admin\' }'>";
				str+="<button id='rrupdate_"+v.rrNo+"' class='offset-md-7 btn btn-sm update-reply' onclick='updateReviewReply("+v.rrNo+","+v.reviewNo+")'>"
				str+="수정";
				str+="</button>";
				str+="&nbsp;&nbsp;";
				str+="<button class='btn btn-sm delete-reply' onclick='deleteReviewReply("+v.rrNo+","+v.reviewNo+")' style='cursor:pointer'>"
				str+="삭제";
				str+="</button>";
				str+="<input type='hidden' value='"+v.rrNo+"'>";
				str+="</c:if>"
				str+="</div>";
			});
			$("#open_"+reviewNo).html(str);
		},
	})
	
}



function adjustHeight() {
	  var reply = $("#origin-ta");
	  reply[0].style.height = 'auto';
	  var replyHeight = reply.prop('scrollHeight');
	  reply.css('height', replyHeight);
	};
	
	$("textarea").on('keyup', function() {
	  adjustHeight();
	});

	
	$(function(){
	$(".comment").hide();
	$(".comment-input").hide();
	
	//댓글 모양 누르면 답변들 보이기
	$("span[name=commentBtn]").click(function(){
		$(this).parent().parent().parent().next().toggle();
		$(this).parent().parent().parent().next().next().toggle();
		
		var reviewNo=$(this).next().val();
		$.ajax({
			url: "${path}/shop/selectReviewReply.do",
			data: {reviewNo : reviewNo},
			dataType: "json",
			success : function(data){
				var str='';
				
				if(data.length!=0){
				$.each(data,function(i,v){
					var rrCont=v.rrContent.replace(/<br>/gi, "\r\n");
					str+="<div class='row' style='margin-top:20px;'>";
					str+="<div class='col' style='font-weight:bolder;'> Maison  </div>";
					str+="</div>";
					str+="<div class='row'>";
					str+="<div class='col-8' style='background-color:#EAEAEA;'>";
					str+="<p style='margin:10px;' id='p_"+v.rrNo+"'>";
					str+=v.rrContent;
					str+="</p>";
					str+="</div>";
					str+="<c:if test='${loginMember.memberId eq \'admin\' }'>";
					str+="<button id='rrupdate_"+v.rrNo+"' class='offset-md-7 btn btn-sm update-reply' onclick='updateReviewReply("+v.rrNo+","+v.reviewNo+")'>"
					str+="수정";
					str+="</button>";
					str+="&nbsp;&nbsp;";
					str+="<button class='btn btn-sm delete-reply' onclick='deleteReviewReply("+v.rrNo+","+v.reviewNo+")' style='cursor:pointer'>"
					str+="삭제";
					str+="</button>";
					str+="<input type='hidden' value='"+v.rrNo+"'>";
					str+="</c:if>";
					str+="</div>";
				});
				}else{
					str+="<div class='col-8' style='background-color:#EAEAEA; padding:10px'>";
					str+="<p style='margin:10px;'>아직 등록된 답변이 없습니다 !</p>";
					str+="</div>";
				}
				$("#open_"+reviewNo).html(str);
				
			},
			error : function(){
				console.log("ajax통신실패")
			}
		});
	});
	
	
	
	
	
	
	
	//삭제하기
/* 	$(".delete-reply").click(function(){
		var rrNo=$(this).next().val();
		console.log("클릭");
		console.log(rrNo);
		$.ajax({
			url: "${path}/shop/deleteReply.do",
			data : {}
		});
	}); */
	
	
	
	
	
	//답변 달기
	$(".insert-reply").click(function(){

		var text=$(this).prev().val();
		rrContent=text.replace(/(?:\r\n|\r|\n)/g,'<br/>');
		var reviewNo=$(this).prev().prev().val();
		
		$.ajax({
			url : "${path}/shop/insertReviewReply.do",
			data : {
				rrContent : rrContent,
				reviewNo : reviewNo
			},
			dataType:"json",
			success: function(data){
				var str='';
				$.each(data,function(i,v){
					var rrCont=v.rrContent.replace(/<br>/gi, "\r\n");
					str+="<div class='row' style='margin-top:20px;'>";
					str+="<div class='col' style='font-weight:bolder;'> Maison  </div>";
					str+="</div>";
					str+="<div class='row'>";
					str+="<div class='col-8' style='background-color:#EAEAEA;'>";
					str+="<p style='margin:10px;' id='p_"+v.rrNo+"'>";
					str+=v.rrContent;
					str+="</p>";
					str+="</div>";
					str+="<c:if test='${loginMember.memberId eq \'admin\' }'>";
					str+="<button id='rrupdate_"+v.rrNo+"' class='offset-md-7 btn btn-sm update-reply' onclick='updateReviewReply("+v.rrNo+","+v.reviewNo+")'>"
					str+="수정";
					str+="</button>";
					str+="&nbsp;&nbsp;";
					str+="<button class='btn btn-sm delete-reply' onclick='deleteReviewReply("+v.rrNo+","+v.reviewNo+")' style='cursor:pointer'>"
					str+="삭제";
					str+="</button>";
					str+="<input type='hidden' value='"+v.rrNo+"'>";
					str+="</c:if>"
					str+="</div>";
				});
				$("#open_"+reviewNo).html(str);
				$("textarea").val('');
			},
			error: function(){
				console.log("ajax 통신 실패");
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
