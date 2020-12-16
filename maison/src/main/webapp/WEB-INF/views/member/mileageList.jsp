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
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
								<br/>
								<h2>적립금 관리</h2>
								<hr>
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
					<br>
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
					<br>
					<div class="row">
						<div class="col-lg-12">
							<div id="pageBar-div">
							
							</div>
						</div>
					</div>
					<br>
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
		dateFormat:'yy-mm-dd',
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
		dateFormat:'yy-mm-dd',
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

			b+=Object.values(data)[2];
			b+='<br/>';
			$.each(Object.values(data)[0],function(index,item){
				//날짜, 적립금, 주문, 내용
				//item.orderNo 
				//item.mileDate
				//item.mileType
				//item.mile
				var dateForm = new Date(item.mileDate);
				a+='<tr>';
				a+='<td>'+getFormatDate(dateForm)+'</td>';
				a+='<td>'+numberWithCommas(item.mile)+'원 </td>';
				if(item.orderNo==0){
					a+='<td> </td>';	
				}else{
					a+='<td>'+item.orderNo+'</td>';
				}
				if(item.mileType=='W'){
					a+='<td>신규회원 적립금</td>';
				}else if(item.mileType=='O'){
					a+='<td>구매에 대한 적립금</td>';
				}else if(item.mileType=='C'){
					a+='<td>구매취소로 인한 적립금 회수</td>';
				}else if(item.mileType=='U'){
					a+='<td>상품 구매시 사용한 적립금</td>';
				}
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
    return  year + '- ' + month + '- ' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
//금액형태로 변환
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//조회 버튼 클릭했을때 조건에 맞게 아래 내용 바꾸기
$(function(){
	$("#conditionOn").on('click',function(){
		var x = $("#datepicker1").val();
		var y = $("#datepicker2").val();
		var z = $("#status").val();
		var d = $("#hidenId").val();
		//날짜형식으로 변환해서 시작일 날짜가 종료일 날짜보다 후일 수 없게.
		var xArr = x.split('-');
		var xDate = new Date(xArr[0],xArr[1]-1,xArr[2]);		
		var yArr = y.split('-');
		var yDate = new Date(yArr[0],yArr[1]-1,yArr[2]);
		if(xDate.getTime()<yDate.getTime()){
			conditionMileage(x,y,z,d);		
		}else{
			swal('시작일이 종료일보다 클 수 없습니다.');
			$("#datepicker2").val(today());
			$("#datepicker1").val(lastMonth());
		}
	})
})
/* 날짜 객체 받아서 문자열로 리턴하는 함수 */
function getDateStr(myDate){
	return (myDate.getFullYear() + '-' + (myDate.getMonth() + 1) + '-' + myDate.getDate())
}
/* 오늘로부터 1개월전 날짜 반환 */
function lastMonth() {
  var d = new Date()
  var monthOfYear = d.getMonth()
  d.setMonth(monthOfYear - 1)
  return getDateStr(d)
}
/* 오늘날짜 반환 */
function today() {
	  var d = new Date()
	  return getDateStr(d)
	}

//조건이 들어간 데이터 ajax통신
function conditionMileage(x,y,z,d){
	$.ajax({
		url : '${path }/member/conditionMileage.do',
		type:'post',
		data:{'startDate':x,'endDate':y,'status':z,'memberId':d},
		success:function(data){
			if(data!=null){	
				if(Object.values(data)[1]!=0){
					var a ='';
					var b = '';
					b+=Object.values(data)[2];
					b+='<br/>';
					$.each(Object.values(data)[0],function(index,item){
						//날짜, 적립금, 주문, 내용
						//item.orderNo 
						//item.mileDate
						//item.mileType
						//item.mile
						var dateForm = new Date(item.mileDate);
						a+='<tr>';
						a+='<td>'+getFormatDate(dateForm)+'</td>';
						a+='<td>'+numberWithCommas(item.mile)+'원 </td>';
						if(item.orderNo==0){
							a+='<td> </td>';	
						}else{
							a+='<td>'+item.orderNo+'</td>';
						}
						if(item.mileType=='W'){
							a+='<td>신규회원 적립금</td>';
						}else if(item.mileType=='O'){
							a+='<td>구매에 대한 적립금</td>';
						}else if(item.mileType=='C'){
							a+='<td>구매취소로 인한 적립금 회수</td>';
						}else if(item.mileType=='U'){
							a+='<td>상품 구매시 사용한 적립금</td>';
						}
						a+='</tr>';
					})
						$("#tbl-mileageList-tbody").html(a);
						$("#pageBar-div").html(b);
				}else{
					$("#tbl-mileageList-tbody").html("<tr><td colspan=4>입력하신 조건에 해당하는 적립금이 없습니다.</td></tr>");
					$("#pageBar-div").html("");						
				}
			}else{
				$("#tbl-mileageList-tbody").html("<tr><td colspan=4>입력하신 조건에 해당하는 적립금이 없습니다.</td></tr>");
				$("#pageBar-div").html("");				
			}
		}
	});
}




</script>