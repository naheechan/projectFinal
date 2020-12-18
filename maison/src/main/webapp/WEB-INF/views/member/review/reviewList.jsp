<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>
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
<!-- Start With -->
<section>
<c:if test="${start eq null }">
	<c:set var="start" value="-1M"/>
	<c:set var="end" value="today"/>
</c:if>
<c:set var="select" value="${select }"/>
<c:if test="${select eq null }">
	<c:set var="select" value="1"/>
</c:if>
	<div class="container">
		<div class="row">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp" />
			</div>
			
			<div class="col-lg-9 col-md-7">
			<br>
			<div class="col-9">
			<form action="${path }/member/review/selectPeriodReview.do">
				<!-- <div class="btn-group btn-group-toggle" data-toggle="buttons">
					<label class="btn btn-light">
						<input type="checkbox" name="revradio" id="revradio1" onclick="checkone()"> 1개월
					</label>
					<label class="btn btn-light">
						<input type="checkbox" name="revradio" id="revradio2"> 3개월
					</label>
						
				</div> -->
				&nbsp;&nbsp;
				<input type="text" class="datepicker" id="start" name="start" style="width:100px;">
				~
				<input type="text" class="datepicker" id="end" name="end" style="width:100px;">
				&nbsp;&nbsp;
				<c:if test="${select eq '1' }">
				<select class="form-select" name="select" aria-label="Default select example">
				  <option selected value="1">전체보기</option>
				  <option value="2">답글달린 리뷰</option>
				</select>
				</c:if>
				<c:if test="${select eq '2' }">
				<select class="form-select" name="select" aria-label="Default select example">
				  <option  value="1">전체보기</option>
				  <option selected value="2">답글달린 리뷰</option>
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
			<br>
						${r.reviewContent }
		<br>
			<span name="commentBtn" class="text-end" style="cursor:pointer; margin-top:5px;">답변보기<i class="far fa-comment-dots"></i></span>
			<input type="hidden" name="reviewNo" value="${r.reviewNo }">
		
		
		<div class="comment" id="open_${r.reviewNo }" >
		
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
							<input type="button" class="reviewBtn btn btn-sm btn-success" value="수정">
							<input type="button" class="deleteBtn btn btn-sm btn-danger" value="삭제">
						</td>
					</tr>
					
				</c:forEach>
			</table>
			
			</div>
		</div>
	</div>
	<div id="page-bar">
	${pageBar }
	</div>
	<br>
<div id="pop">
</div>
</section>

<!-- End With -->
<script>
$(document).ready(function() {
    //라디오 요소처럼 동작시킬 체크박스 그룹 셀렉터
    $('input[type="checkbox"][name="revradio"]').click(function(){
    	console.log("클릭함");
        //클릭 이벤트 발생한 요소가 체크 상태인 경우
        if ($(this).prop('checked')) {
            //체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
            $('input[type="checkbox"][name="revradio"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });
});




$(function(){
	
	$("#revradio1").click(function(){
		console.log("클릭함");
		if($(this).prop('checked')){
			$("input[type='checkbox'][name='revradio']").prop("checked",false);
			$(this).prop("checked",false);
			
		}
		
	});
	
	$(".comment").hide();
	//댓글 모양 누르면 답변들 보이기
	$("span[name=commentBtn]").click(function(){
		$(this).next().next().toggle();
		//$(this).parent().parent().parent().next().next().toggle();
		
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
	
	
	
	
	
	
	 $("#start").datepicker({
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
     });     
     //초기값을 오늘 날짜로 설정
     $('#start').datepicker('setDate', '${start}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)   
	$("#end").datepicker('setDate','${end}');	
	
     
     
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
	
});
$(function(){
	$("#revradio1").click(function(){
		$("#start").datepicker('setDate', '-1M');
		$("#end").datepicker('setDate', 'today');
	});
	
	$(".datepicker").click(function(){
		console.log("누름");
		$("#revradio1").prop("checked", false);
		$("#revradio2").prop("checked", false);
	});
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		