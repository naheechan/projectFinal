<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date,java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%
   //한달전 날짜 구하기
      Calendar mon = Calendar.getInstance();
      mon.add(Calendar.MONTH , -1);
      String monthAgo = new java.text.SimpleDateFormat("yyyy-MM-dd").format(mon.getTime());
%>

<!DOCTYPE html>
<html>
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>관리자 페이지</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="${path }/resources/admin/vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="${path }/resources/admin/vendors/base/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- plugin css for this page -->
  <link rel="stylesheet" href="${path }/resources/admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="${path }/resources/admin/css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="${path }/resources/admin/images/favicon.png" />
  <link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css">
  
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>  
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> -->
 
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
/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
.ui-datepicker-trigger{cursor: pointer;}
/*datepicer input 롤오버 시 손가락 모양 표시*/
.hasDatepicker{cursor: pointer;}

</style>
</head>
<body>

<c:if test="${start eq null }">
	<c:set var="today" value="<%=new Date()%>"/>
	<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today"/>
</c:if>
<c:set var="select" value="${select }"/>
<c:if test="${select eq null }">
	<c:set var="select" value="1"/>
</c:if>
<div class="container-scroller">
	<!-- Start nav -->
	<jsp:include page="/WEB-INF/views/admin/navbar.jsp"/>
	<!-- End nav -->
	<div class="container-fluid page-body-wrapper">
		<!-- Start sidebar -->
		<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
		<!-- End sidebar -->
		<!-- Start MainPanel 여기가 페이지별로 바뀌는 부분  -->
		      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
        <div class="card">
        <div class="card-body">
          <div class="container">
	
		<br>
		<br>
	<div id="review-container" class="row justify-content-center">
		<div class="col-12 align-self-center">
		<div class="table-main table-responsive">
			<div class="col-lg-12 col-md-12">
			<br>
			<div class="col-12">
			<form action="${path }/admin/review/selectPeriodReview.do">
				<!-- <div class="btn-group btn-group-toggle" data-toggle="buttons">
					<label class="btn btn-light">
						<input type="checkbox" name="revradio" id="revradio1" onclick="checkone()"> 1개월
					</label>
					<label class="btn btn-light">
						<input type="checkbox" name="revradio" id="revradio2"> 3개월
					</label>
						
				</div> -->
				&nbsp;&nbsp;
				<c:if test="${start eq null }">
				<input type="date" class="datepicker" id="start" name="start" value="<%=monthAgo %>" style="width:150px;">
				~
				<input type="date" class="datepicker" id="end" name="end" value="${today }" style="width:150px;">
				</c:if>
				<c:if test="${start ne null and end ne null }">
				<input type="date" class="datepicker" id="start" name="start" value="${start }" style="width:150px;">
				~
				<input type="date" class="datepicker" id="end" name="end" value="${end }" style="width:150px;">
				</c:if>
				&nbsp;&nbsp;
				<c:if test="${select eq '1' }">
				<select class="form-select" name="select" aria-label="Default select example">
				  <option selected value="1">전체보기</option>
				  <option value="2">답변 미작성 리뷰</option>
				</select>
				</c:if>
				<c:if test="${select eq '2' }">
				<select class="form-select" name="select" aria-label="Default select example">
				  <option  value="1">전체보기</option>
				  <option selected value="2">답변 미작성 리뷰</option>
				</select>
				</c:if>
				&nbsp;&nbsp;
				<input type="submit" value="조회">
				</form>
			</div>
			<br>
			<table class="table">
				<tr>
					<th style="width:20%">상품</th>
					<th style="width:50%">상품평</th>
					<th style="width:20%">등록일</th>
					<th style="width:10%"></th>
				</tr>
				<c:forEach var='r' items="${list }">
				
					<tr>
						<td>
						<img src="${path }/resources/upload/product/${r.productImg }" width="70px" height="100px">
						
						</td>
						<td>
						<p style="font-weight:bolder">${r.productName }</p>
						<div class='star-rating' style="margin-bottom :5px;">
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
			<br>
						${r.reviewContent }
		<br>
		<br>
			<span name="commentBtn" class="text-end" style="cursor:pointer; margin-top:10px;">답변보기<i class="far fa-comment-dots"></i></span>
			<input type="hidden" name="reviewNo" value="${r.reviewNo }">
		
		
		<div class="comment" id="open_${r.reviewNo }" >
		
		</div>
		<div class="comment-input">
			<div class="row" style="margin-top:20px;">
				<c:if test="${loginMember.memberId eq 'admin' }">
				<div class="col-2" >
					<p>답글 달기</p>
				</div>
				<div class="col-10">
					<input type="hidden" id="no_${reviewNo }" name="reviewNo" value="${r.reviewNo }" >
					<textarea id="origin-ta" id="ta_${reviewNo }" style="width:100%;  resize:none;" cols="50"  wrap="hard"></textarea>
					<button id="reply_"+${reviewNo } class="btn btn-sm insert-reply" >등록하기</button>
				</div>
				</c:if>
			</div>
		</div>
		
						</td>
						<td>
						<fmt:formatDate value="${r.reviewDate }" pattern="yyyy-MM-dd" var="fmdate"/>
						<fmt:formatDate value="${r.orderDate }" pattern="yyyy-MM-dd" var="fmoddate"/>
						<c:out value="${fmdate}"/><br><br>
						<p style="font-weight:bolder;font-size:12px;">결제일<br>
						<c:out value="${fmoddate }"/> </p>
						</td>
						<td>
							<input type="hidden" value="${r.reviewNo }" name="reviewNo">
						</td>
					</tr>
					
				</c:forEach>
			</table>
			
			</div>
		</div>
	</div>
	</div>
	</div>

	<br>

<div id="page-bar">
	${pageBar }
	</div>
	<br>
        </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
	</div>
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
</body>
<script>
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

	//답변등록
/* function insert_reply(s){
	console.log("답변등록 클릭 : "+s);
	var rrContent=$("#ta_"+s).val();
	//rrContent=text.replace(/(?:\r\n|\r|\n)/g,'<br/>');
	var reviewNo=$("#no_"+s).val();
	console.log(rrContent+" : "+reviewNo)
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
}; */

	$(function(){
		
		$(".comment").hide();
		$(".comment-input").hide();
		//댓글 모양 누르면 답변들 보이기
		 $("span[name=commentBtn]").click(function(){
			$(this).next().next().toggle();
			$(this).next().next().next().toggle();
			
			var reviewNo=$(this).next().val();
			$.ajax({
				url: "${path}/shop/selectReviewReply.do",
				data: {reviewNo : reviewNo},
				dataType: "json",
				success : function(data){
					var str='';
					console.log(data.legnth);
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
						str+="</c:if>"
						str+="</div>";
					});
					}else{
						str+="<div style='background-color:#EAEAEA;'>";
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
		/* $("span[name=commentBtn]").click(function(){
			$(this).next().next().toggle();
			
			var reviewNo=$(this).next().val();
			$.ajax({
				url: "${path}/shop/selectReviewReply.do",
				data: {reviewNo : reviewNo},
				dataType: "json",
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
				error : function(){
					console.log("ajax통신실패")
				}
			});
		}); */
		
		 /* $("#start").datepicker({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	         ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	         ,changeYear: true //콤보박스에서 년 선택 가능
	         ,changeMonth: true //콤보박스에서 월 선택 가능                
	         ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	         ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	         ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	         ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	         ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	         ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	         ,maxDate: "+0" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       	 ,onClose: function( selectedDate ) {    
	                 // 시작일(fromDate) datepicker가 닫힐때
	                 // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	                 $("#end").datepicker( "option", "minDate", selectedDate );
	             }     
	     });                    
	     
		 $("#end").datepicker({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	         ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	         ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	         ,changeYear: true //콤보박스에서 년 선택 가능
	         ,changeMonth: true //콤보박스에서 월 선택 가능                
	         ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	         ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	         ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	         ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	         ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	         ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	         ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	         ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	         ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	         ,minDate: "-1Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	         ,maxDate: "+0" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
	       	 ,onClose: function( selectedDate ) {
	             // 종료일(toDate) datepicker가 닫힐때
	             // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
	             $("#start").datepicker( "option", "maxDate", selectedDate );
	         }                
	     });     */ 
	     //초기값을 오늘 날짜로 설정
	    // $('#start').datepicker('setDate', '${start}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)   
		//$("#end").datepicker('setDate','${end}');	
		/* var today=new Date();
		var monthAgo= today.setMonth(date.getMonth()-1);
		console.log(today+": "+ monthAgo); */
	     
	     
		$(".reviewBtn").click(function(){
			$("#pop").show();
			
			var reviewNo=$(this).prev().val();
			$.ajax({
				url: "${path}/member/updateReview.do",
				data : {
					reviewNo : reviewNo
				},
				dataType:"html",
				success: function(data){
					$("#pop").html("");
					$("#pop").html(data);
				},
				error : function(){
					console.log("ajax 통신 실패");
				}
			});
		});
		
		$(".deleteBtn").click(function(){
			if(confirm("정말 삭제하시겠습니까? ")){
				var reviewNo=$(this).prev().prev().val();
				console.log(reviewNo);
				location.href="${path}/member/deleteReview.do?reviewNo="+reviewNo;
			}
			
		});
		
		//답변 달기
		$(".insert-reply").click(function(){
			console.log("답변등록 클릭");
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
</html>		