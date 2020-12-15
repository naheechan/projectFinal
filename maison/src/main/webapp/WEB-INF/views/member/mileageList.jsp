<%@page import="java.util.Date,java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	//한달전 날짜 구하기
		Calendar mon = Calendar.getInstance();
		mon.add(Calendar.MONTH , -1);
		String beforeMonth = new java.text.SimpleDateFormat("yyyy-MM-dd").format(mon.getTime());
%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="적립금관리"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="마이페이지  / 적립금 관리"/>
</jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Start Mypage mileageList-->
<section>
	<div class="container">
		<div class="row">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<div class="col-lg-9 col-md-7">
				<div class="data-div">
					<div class="row">
						<div class="col-lg-12">
							<div class="table-main table-responsive">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<br/>
											<td>
											<c:set var="priceFormat"><fmt:formatNumber value="${loginMember.meileage }"/></c:set>
											<input type="hidden" value="${loginMember.memberId }" id="hidenId"> 
											<span><c:out value="${loginMember.memberName }"/>님의 보유 포인트는 </span>
											<span style="font-size:1.5rem;color:black;"><c:out value="${priceFormat }"/></span>
											<span style="font-size:1.2rem;color:black;">원</span> 입니다.</td>
											<br/>
										</tr>
										<tr>
											<td>
												<div class="form-row">
													<div class="form-group col-md-4">
														<c:set var="today" value="<%=new Date()%>"/>
														<label for="datepicker1">시작일</label>
														<br>
														<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="today"/>
														<input type="text" class="form-control" id="datepicker1" name="startDate" style="width:80%;float:left;"
														value="<%=beforeMonth%>">
														&nbsp;
													</div>	
													<div class="form-group col-md-4">
														<label for="datepicker2">종료일</label>
														<br>
														<input type="text" class="form-control" id="datepicker2" name="endDate" style="width:80%;float:left;"
														value="${today }">																										
													</div>
													<div class="form-group col-md-2">
														<label for="status">상태</label>
														<select id="status" class="form-control" name="status">
															<option selected>전체상태</option>
															<option value="plus">적립</option>
															<option value="minus">사용</option>
														</select>
													</div>

													<div class="form-group col-md-2" style="text-align:center;">
														<label for="conditionOn">&nbsp;</label>
														<br>
														<button class="btn" style="background:#F2BB9C;" type="button" id="conditionOn"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;조회</button>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="table-main table-responsive">
								<table class="table table-hover">
									<thead>
										<th>주문날짜</th>
										<th>적립금</th>
										<th>관련주문</th>
										<th>내용</th>
									</thead>
									<tbody id="tbl-mileageList-tbody">
									
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div id="pageBar-div">
							
							</div>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</div>
</section>
<!-- End Mypage mileageList -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		
<script>
//데이트피커 설정
$(function(){
	$("#datepicker1").datepicker({
		showOn:"both",
		buttonImage:"${path}/resources/images/calendarIcon.jpg",
		buttonImageOnly:true,
		changeMonth:true,
		changeYear:true,
		minDate:'-150y',
		nextText:'다음 달',
		prevText:'이전 달',
		yearRange:'c-150:c+0',
		dateFormat:'yyyy-mm-dd',
		showMonthAfterYear:true,
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
	$("#datepicker2").datepicker({
		showOn:"both",
		buttonImage:"${path}/resources/images/calendarIcon.jpg",
		buttonImageOnly:true,
		changeMonth:true,
		changeYear:true,
		minDate:'-150y',
		nextText:'다음 달',
		prevText:'이전 달',
		yearRange:'c-150:c+0',
		dateFormat:'yyyy-mm-dd',
		showMonthAfterYear:true,
		dayNamesMin:['월','화','수','목','금','토','일'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
});

//멤버아이디
var hidenId = $("#hidenId").val();

// 페이지 로딩되자마자 ajax돌려서 조건 없는 mileage table 뽑아내기 
$(document).ready(function(){
	defaultMileage();
});

// 처음 시작할때 조건 없이 돌아가는 얘
function defaultMileage(){
	$.ajax({
		url:'${path }/member/defaultMileage.do',
		type:'get',
		data:{'memberId':hidenId},
		dataType:'json',
		success:function(data){
			var a ='';
			var b = '';
/* 			console.log('성공?');
			var dataLeng= Object.keys(data).length;
			console.log(dataLeng);
			console.log(Object.values(data)[0]);
			for(var i=0;i<dataLeng;i++){
				var items = data[i];
				console.log(data[0]);
			}
			console.log('성공!');
			$.each(data,function(index,item){
				var label = item.label;
				var value = item.value;
				console.log(label + "::::"+value);
			}) */

			console.log(Object.values(data)[2]);
			b+=Object.values(data)[2];
			$.each(Object.values(data)[0],function(index,item){
				//날짜, 적립금, 주문, 내용
				//item.orderNo 
				//item.mileDate
				//item.mileType
				//item.mile
				var dateForm = new Date(item.mileDate);
				a+='<tr>';
				a+='<td>'+getFormatDate(dateForm)+'</td>';
				a+='</tr>';
			})
				$("#tbl-mileageList-tbody").html(a);
				$("#pageBar-div").html(b);
		}
		
	})
}
//yyyy/MM/dd 변환
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '년 ' + month + '월 ' + day+'일';       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}



</script>