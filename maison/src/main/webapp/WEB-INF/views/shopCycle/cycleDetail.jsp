<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.Date" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=""/>
</jsp:include>
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	.announce-text {
		margin: 6px;
   	 	background-color: #202B3F;
   	 	color: white;
   	 	padding: 2vh;
   	 	font-size: 2.5vh;
	}
	.cycle-container {
		display: flex;
		flex-direction: column;
		padding: 7vh;
	}
	.onOffCycle{
		display: flex;
		justify-content: space-between;
	}
	.cycleEdit-container {
		display: flex;
		justify-content: center;
		margin-top: 5vh;
	}
	.cycle {
		width: 40vh;
		height: 40vh;
		font-size: 3vh;
		text-align: center;
		color: white;
		background-color: #BDBDBD;
		padding-top: 0px;
	}
	.selected {
		background-color: #F2BB9C;
	}
	.cycleTitle {
		text-align: left;
		color: black;
		background-color: white;
	}
	.cycle-content {
		padding: 3vh;
	}
	.marginBottom {
		margin-bottom: 5vh;
	}
	.underLine {
		text-decoration: underline;
	}
	#datepicker{
		width: 25vh;
		display: inline-block;
	}
</style>

<!-- 현재 주기cycleMode가 뭔지 파악 -->
<c:set var="selectedCycle" value="${product.cycleMode}"/>


<!-- 각 주기별 다음 구매예상 날짜 구하기 -->
<!-- startDate를 밀리세컨드로 변환 -->
<fmt:parseNumber var="startDate_M" value="${product.startDate.time}"/>
<!-- 변수를 스크립틀릿에서 사용하기 위해서 c:set으로 저장 -->
<c:set var="startDa" value="${startDate_M}" />
<!-- onCycle과 offCycle의 날짜수를 변수에 넣어줌 -->
<c:set var="onCycleDay" value="${product.onCycle}" />
<c:set var="offCycleDay" value="${product.offCycle}" />
<%
	//주기(day)를 int변수에 넣어줌
	int onCycleDay = Integer.parseInt(String.valueOf(pageContext.getAttribute("onCycleDay")));
	int offCycleDay = Integer.parseInt(String.valueOf(pageContext.getAttribute("offCycleDay")));
	//startDate를 Calendar를 이용해서 주기(day)를 더하면 다음 구매예상일 날짜 구해짐
	Date startDa = new Date(Long.valueOf(String.valueOf(pageContext.getAttribute("startDa"))));
	Calendar onCal = Calendar.getInstance();
	Calendar offCal = Calendar.getInstance();
	onCal.setTime(startDa);
	offCal.setTime(startDa);
	
	Calendar calToday = Calendar.getInstance(); //지금 현재 날짜
	//오늘보다 다음구매예상일이 더 커질때까지 더함.
	do{
		onCal.add(Calendar.DATE, onCycleDay);
	}while(onCal.getTimeInMillis() < calToday.getTimeInMillis());
	
	do{
		offCal.add(Calendar.DATE, offCycleDay);
	}while(offCal.getTimeInMillis() < calToday.getTimeInMillis());

	Date onStartDa = new Date(onCal.getTimeInMillis());
	Date offStartDa = new Date(offCal.getTimeInMillis());
	//완성된 각 예상구매날짜를 변수에 넣어줌
	pageContext.setAttribute("onStartDate", onStartDa);
	pageContext.setAttribute("offStartDate", offStartDa);
%>
<section>
<div class="shop-box-inner">
	<div class="container">
		<div class="row">
		
			<!-- 카테고리 -->
			<div class="col-xl-3 col-lg-3 col-sm-12 col-xs-12 sidebar-shop-left">
				<div class="product-categori">
					<div class="filter-sidebar-left">
			            <div class="title-left">
			                <h3>쇼핑시계</h3>
			            </div>
						<div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
		                          	
							<div class="list-group-collapse sub-men">
								<a class="list-group-item list-group-item-action " href="${path }/shopCycle/cycleList?tab=all">
									<b>한번에 보기</b>
								</a>
							</div>
								
							<div class="list-group-collapse sub-men">
		                    	<a class="list-group-item list-group-item-action" href="#sub-men1" data-toggle="collapse" aria-expanded="true" aria-controls="sub-men1">
									<b>세부내역 보기</b>
								</a>
							</div>
		                    <div class="show" id="sub-men1" data-parent="#list-group-men">
		                    	<div class="list-group">
		                     		<c:forEach var="largeCate" items="${category }" varStatus="i">
										<a href="${path }/shopCycle/cycleList?tab=${largeCate.largeCate }" id="cateSearch" class="list-group-item list-group-item-action <c:if test="${product.largeCate eq largeCate.largeCate}">active</c:if>">${largeCate.largeCate}</a>
		                     		</c:forEach>
		                    	</div>
		                    </div>
							<br>
						</div>
					</div>
				</div>
			</div>
	
			<!--오른쪽 내용부분 -->
			<div class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right">
			
				<!-- 지금 주기상태가 ON인지 OFF인지 알려주는 텍스트 -->
				<div class="announce-text rounded">
					<span>현재 '</span>
					<span>${product.productName}</span>
					<span>'의 현재주기는 </span>
					<span style="color:#FFBB00"><c:out value="${selectedCycle eq 'onCycle'?'ON':'OFF'}"/></span>
					<span>입니다.</span>
				</div>
				
				<!-- 상품 사진,설명 div -->
				<div class="shop-detail-box-main">
			        <div class="container">
			            <div class="row">
			                <div class="col-xl-5 col-lg-5 col-md-6">
			                	<!-- 상품 상세 이미지 넣기 -->
			                   <img class="d-block w-100" src="${path }/resources/images/big-img-01.jpg" alt="First slide">
			                </div>
			                <div class="col-xl-7 col-lg-7 col-md-6">
			                    <div class="single-product-details">
			                        <h2>${product.productName }</h2>
			                        <%-- <h5><fmt:formatNumber type="currency" value="${product.price }"/></h5> --%>
									<h2>상품 안내:</h2>
									<p>${product.productSummary }</p>
			                    </div>
			                </div>
			            </div>
					</div>
				</div>
				
				<!-- 주기 선택하는 부분 -->
				<div class="cycle-container">
					<!-- on이랑 off상자 -->
					<div class="onOffCycle">
						<!-- ON부분 -->
						<div class="cycle" id="on-cycle">
							<!-- text부분 -->
							<div class="cycleTitle">
								<span>ON</span>
							</div>
							
							<!-- 해당 주기내용 부분 -->
							<div class="cycle-content">
								<!-- 설정된 주기가 몇일인지 -->
								<div class="marginBottom">
									<span class="display-3 font-weight-bold underLine">${product.onCycle}</span>
									<span>일</span>
								</div>
								<div class="">
									<span>다음 예상 구매일 :</span>	
								</div>
								<div class="">
									<span><c:out value="${onStartDate}" /></span>
								</div>
							</div>
						</div>
						
						<!-- OFF부분 -->
						<div class="cycle" id="off-cycle">
							<!-- text부분 -->
							<div class="cycleTitle">
								<span>OFF</span>
							</div>
							
							<!-- 해당 주기내용 부분 -->
							<div class="cycle-content">
								<!-- 설정된 주기가 몇일인지 -->
								<div class="marginBottom">
									<span class="display-3 font-weight-bold underLine">${product.offCycle}</span>
									<span>일</span>
								</div>
								<div class="">
									<span>다음 예상 구매일 :</span>	
								</div>
								<div class="">
									<span><c:out value="${offStartDate}" /></span>
								</div>
							</div>
						</div>
					</div>
					<!-- 주기 수정버튼 -->
					<div class="cycleEdit-container">
						<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#editModal">주기 수정</button>
					</div>
				</div>
				
				<!-- 주기 수정하는 모달 창 -->
				<div class="modal fade" id="editModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<form action="${path }/shopCycle/editCycle" method="post">
							
								<input type="hidden" name="no" value="${product.productNo}">
								<!-- 모달 헤더 -->
								<div class="modal-header">
									<h2 class="modal-title">주기 수정하기</h2>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								
								<!-- 모달 바디 -->
								<div class="modal-body">
									<!-- 필수 부분(주기 선택) -->
									<div class="marginBottom">
										<h4>&bull; 주기를 선택하세요(필수사항)</h4>
										<div class="form-check">
										 	<label class="form-check-label">
										   		<input type="radio" class="form-check-input" name="chooseCycle" id="onRadio" value="onCycle" required ${selectedCycle eq 'onCycle'?'checked':''}>ON
										 	</label>
										</div>
										<div class="form-check">
										 	<label class="form-check-label">
										   		<input type="radio" class="form-check-input" name="chooseCycle" id="offRadio" value="offCycle" ${selectedCycle eq 'offCycle'?'checked':''}>OFF
										 	</label>
										</div>
										<div class="form-group">
									  		<input type="number" class="form-control" id="offInput" name="offInput" disabled placeholder="직접 주기일을 지정하세요(현재: ${product.offCycle}) - 기준:일(day)">
										</div>
									</div>
									
									<!-- 선택 부분(시작일 선택) -->
									<div class="marginBottom">
										<h4>&bull; 시작일 선택(선택사항)</h4>
										<p>입력한 시작일로부터 다음 예상구매일을 알려줍니다.</p>
							
										<div class="form-check">
											<label class="form-check-label">
												<input type="checkbox" class="form-check-input" name="startCheckbox" id="startCheckbox" value="1">시작일 선택하기
											</label>
										</div>
										
										<div class="form-group" id="dateDiv" style="display:none">
										    <label for="datepicker"></label><br>
										    <input type="text" class="form-control" id="datepicker" name="start">
										    <div id="checkStart-container">
											    <p class="text-danger" id="notRegStart" style="display:none">달력에서 시작일을 선택해주세요</p>
										    </div>
										    <input type="hidden" id="startCheck" name="startCheck" value="0">
									 	</div>		
									</div>
								</div>
								
								<!-- 모달 푸터 -->
								<div class="modal-footer">
									<input type="submit" class="btn btn-success" onclick="return checkSubmit();" value="수정">
									<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
				
				
				
				
				
				
				<!-- 구매이력 -->
				<div class="">
					<p>구매이력</p>
				</div>
				
				
				
			</div>

		</div>	
	</div>
</div>
</section>

<script>

	/* submit할때 유효성검사 */
	function checkSubmit() {
		if($("#offRadio").is(":checked")==true) {
			$("#offInput").removeAttr("disabled");
			$("#offInput").attr("required","true");
		}
		if($("#startCheckbox").is(":checked")==true) {
			$("#dateDiv").show();
			$("#datepicker").attr("required","true");
			if($("#startCheck").val()=="0") {
				swal("시작일을 정확히 입력해주세요");
				return false;
			}
		}
	}


	$(function() {

		/* 현재 주기에 맞게 색칠해주는것 */
		var selectedCycle = "<c:out value='${selectedCycle}'/>";
		if(selectedCycle=='onCycle') {
			/* 현재 주기가 ON일때 */
			$("#on-cycle").addClass('selected');
			$("#off-cycle").removeClass('selected');
		}else {
			/* 현재 주기가 OFF일때 */
			$("#on-cycle").removeClass('selected');
			$("#off-cycle").addClass('selected');
		}
		
		/* offRadio버튼이 선택되어 있을때만 offInput에 입력가능 */
		$("input[type=radio]").click(function() {
			if($("#offRadio").is(":checked")==true) {
				$("#offInput").removeAttr("disabled");
				$("#offInput").attr("required","true");
			}else {
				$("#offInput").attr("disabled",true);
				$("#offInput").removeAttr("required");
			}	
		});
		
		/* offInput에 숫자만 입력할수있도록*/
		$("#offInput").on("change keyup paste", function() {
			var currentVal = $(this).val();
			var reg = /^[0-9]/g;
			if(!reg.test(currentVal)) {
				swal('숫자만 입력하시기 바랍니다.');
				$(this).val('');
			}
		});
		
		
		//startCheckbox을 눌러야 시작일을 선택할 수 있음
		$("#startCheckbox").click(function() {
			if($("#startCheckbox").is(":checked")==true) {
				$("#dateDiv").show();
				$("#datepicker").attr("required","true");
			}else {
				$("#dateDiv").hide();
				$("#datepicker").removeAttr("required");
			}
		});
		
		
		
		//시작일(데이트피커) 유효성체크
    	$("#datepicker").change(function(e) {
    		$("#startCheck").val("0");
    		let checkStart = $(e.target).val().trim();
    		let regStart = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
    		if(regStart.test(checkStart)) {
    			$("#checkStart-container").children().css("display","none");
    			$("#startCheck").val("1");
    		}else {
    			$("#checkStart-container").children().css("display","none");
    			$("#notRegStart").css("display","block");
    		}
    	});
		
		
		//데이트피커 설정
        $("#datepicker").datepicker({
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
		
	})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		