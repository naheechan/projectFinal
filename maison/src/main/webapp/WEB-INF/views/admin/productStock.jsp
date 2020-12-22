<%@page import="java.util.Date,java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%
	//일주일전 날짜 구하기 
		Calendar week = Calendar.getInstance();
		week.add(Calendar.DATE, -7);
		String beforeWeek = new java.text.SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
	//한달전 날짜 구하기
		Calendar mon = Calendar.getInstance();
		mon.add(Calendar.MONTH , -1);
		String beforeMonth = new java.text.SimpleDateFormat("yyyy-MM-dd").format(mon.getTime());
	//일년전 날짜 구하기
		Calendar year = Calendar.getInstance();
		year.add(Calendar.YEAR, -1);
		String beforeYear = new java.text.SimpleDateFormat("yyyy-MM-dd").format(year.getTime());
%>
<!DOCTYPE html>
<html>
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>관리자 페이지 > 상품 재고 관리</title>
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
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<div class="container-scroller">
	<!-- Start nav -->
	<jsp:include page="/WEB-INF/views/admin/navbar.jsp"/>
	<!-- End nav -->
	<div class="container-fluid page-body-wrapper">
		<!-- Start sidebar -->
		<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
		<!-- End sidebar -->
		<!-- Start productStockPanel 여기가 페이지별로 바뀌는 부분  -->
		<div class="main-panel">
			<!-- content-wrapper시작 -->
			<div class="content-wrapper">
				<!-- 첫번째 row div 시작 -->
				<div class="row">
		            <div class="col-md-12 grid-margin">
		              <div class="d-flex justify-content-between flex-wrap">
		                <div class="d-flex align-items-end flex-wrap">
		                  <div class="mr-md-3 mr-xl-5">
		                    <h2>상품 재고 관리</h2>
		                    <p class="mb-md-0">상품 재고 변동을 한눈에 보실 수 있습니다.</p>
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">상품 재고 관리</p>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 첫번째 row div 끝 -->
		          <!-- 두번째 row div 시작 -->
	              <div class="row">
		            <div class="col-md-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body dashboard-tabs p-0">
		                  <ul class="nav nav-tabs px-4" role="tablist">
		                    <li class="nav-item">
		                      <a class="nav-link active" id="week-tab" data-toggle="tab" href="#week" role="tab" aria-controls="week" aria-selected="true">이번 주</a>
		                    </li>
		                    <li class="nav-item">
		                      <a class="nav-link" id="month-tab" data-toggle="tab" href="#month" role="tab" aria-controls="month" aria-selected="false">이번 달</a>
		                    </li>
		                    <li class="nav-item">
		                      <a class="nav-link" id="year-tab" data-toggle="tab" href="#year" role="tab" aria-controls="year" aria-selected="false">이번 해</a>
		                    </li>
		                  </ul>
		                  <!-- tab3개 다 들어있는 애 시작 -->
		                  <div class="tab-content py-0 px-0">
		                  	<!-- id가 overview인 애 탭 시작 -->
		                    <div class="tab-pane fade show active" id="week" role="tabpanel" aria-labelledby="week-tab">
		                      <div class="d-flex flex-wrap justify-content-xl-between">
		                        <div class="d-none d-xl-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-calendar-heart icon-lg mr-3 text-primary"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">기준일</small>
		                            <div class="dropdown">
		                              <a class="btn btn-secondary p-0 bg-transparent border-0 text-dark shadow-none font-weight-medium" href="#" role="button" aria-haspopup="true" aria-expanded="false">
		                                <h5 class="mb-0 d-inline-block"><%=beforeWeek %></h5>
		                              </a>
		                            </div>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket mr-3 icon-lg" style="color:#4d83ff;"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">현재 총 재고</small>
		                            <h5 class="mr-2 mb-0" id="totalStock7"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-success"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">재고 변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock7"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-fill mr-3 icon-lg text-warning"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">입고량</small>
		                            <h5 class="mr-2 mb-0" id="inStock7"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex py-3 border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-unfill mr-3 icon-lg text-danger"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">출고량</small>
		                            <h5 class="mr-2 mb-0" id="outStock7"></h5>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- id가 overview인 애 탭 끝 -->
		                    <!-- id가 month인 애 탭 시작 -->
		                    <div class="tab-pane fade" id="month" role="tabpanel" aria-labelledby="month-tab">
		                      <div class="d-flex flex-wrap justify-content-xl-between">
		                        <div class="d-none d-xl-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-calendar-heart icon-lg mr-3 text-primary"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">기준일</small>
		                            <div class="dropdown">
		                              <a class="btn btn-secondary p-0 bg-transparent border-0 text-dark shadow-none font-weight-medium" href="#" role="button" aria-haspopup="true" aria-expanded="false">
		                                <h5 class="mb-0 d-inline-block"><%=beforeMonth %></h5>
		                              </a>
		                            </div>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket mr-3 icon-lg text-success"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">현재 총 재고</small>
		                            <h5 class="mr-2 mb-0" id="totalStock30"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-warning"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">재고변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock30"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-fill mr-3 icon-lg text-danger"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">입고량</small>
		                            <h5 class="mr-2 mb-0" id="inStock30"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex py-3 border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-unfill mr-3 icon-lg" style="color:#4d83ff;"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">출고량</small>
		                            <h5 class="mr-2 mb-0" id="outStock30"></h5>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- id가 month인 애 탭 끝 -->
		                    <!-- id가 year인 애 탭 시작 -->
		                    <div class="tab-pane fade" id="year" role="tabpanel" aria-labelledby="year-tab">
		                      <div class="d-flex flex-wrap justify-content-xl-between">
		                        <div class="d-none d-xl-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-calendar-heart icon-lg mr-3 text-primary"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">기준일</small>
		                            <div class="dropdown">
		                              <a class="btn btn-secondary p-0 bg-transparent border-0 text-dark shadow-none font-weight-medium" href="#" role="button" aria-haspopup="true" aria-expanded="false">
		                                <h5 class="mb-0 d-inline-block"><%=beforeYear %></h5>
		                              </a>
		                            </div>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket mr-3 icon-lg text-warning"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">현재 총 재고</small>
		                            <h5 class="mr-2 mb-0" id="totalStock365"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-danger"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">재고변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock365"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-fill mr-3 icon-lg" style="color:#4d83ff;"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">입고량</small>
		                            <h5 class="mr-2 mb-0" id="inStock365"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex py-3 border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-basket-unfill mr-3 icon-lg text-success"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">출고량</small>
		                            <h5 class="mr-2 mb-0" id="outStock365"></h5>
		                          </div>
		                        </div>
		                      </div>
		                    </div>
		                    <!-- id가 year인 애 tab끝 -->
		                  </div>
		                  <!-- tab 3개 다 들어있는 애 끝 -->
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 두번째 row div 끝 -->
		          <!-- 3번 row div 시작 -->
				  <div class="row">
		            <div class="col-md-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <p class="card-title">지난 일주일</p>
		                  <p class="mb-4">지난 일주일 간 재고 변동량, 입고량, 출고량의 변동을 차트로 볼 수 있습니다.</p>
		                  <div id="product-stock-chart-legend" class="d-flex justify-content-center pt-3"></div>
		                  <canvas id="product-stock-chart"></canvas>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 3번 row div 끝 -->
		          <!-- 네번째 row div 시작 -->
				  <div class="row">
		
		            <div class="col-md-12 stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <p class="card-title">상품 재고 변동</p>
			              <br/>
		                  <div class="table-responsive">
		                    <table id="recent-purchases-listing" class="table">
		                      <thead>
		                        <tr>
		                            <th>상품번호</th>
		                            <th>상품이름</th>
		                            <th>상품요약</th>
		                            <th>현재재고</th>
		                            <th>재고변동일</th>
		                            <th>재고변동수량</th>
		                        </tr>
		                      </thead>
		                      <tbody id="recent-purchases-tbody">
		                      	<c:if test="${not empty list }">
		                      		<c:forEach items="${list }" var="l" varStatus="vs">
		                      			<tr>
		                      				<td><c:out value="${l.productNo }"/></td>
		                      				<td><c:out value="${l.productName }"/></td>
		                      				<td>
		                      					<c:choose>
												        <c:when test="${fn:length(l.productSummary) gt 26}">
												        <c:out value="${fn:substring(l.productSummary, 0, 25)}">...
												        </c:out></c:when>
												        <c:otherwise>
												        <c:out value="${l.productSummary}">
												        </c:out></c:otherwise>
												</c:choose>
		                      				</td>
		                      				<td><c:out value="${l.productStock }"/></td>
		                      				
		                      				<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd" value="${l.pcDate }"/></c:set>
		                      				
		                      				<td><c:out value="${dateTempParse }"/></td>
		                      				<td><c:out value="${l.pcAmount }"/></td>
		                      			</tr>
		                      		</c:forEach>
		                      	</c:if>
	                      	  </tbody>
		                    </table>
		                  </div>
		                  <br>
		                  <div id="pageBar">
		                  	${pageBar }
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 네번째 row div 끝 -->
			</div>
			<!-- content-wrapper 끝 -->
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>	
		<!-- End productStockPanel -->
	</div>
</div>
  <!-- plugins:js -->
  <script src="${path }/resources/admin/vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <script src="${path }/resources/admin/vendors/chart.js/Chart.min.js"></script>
  <script src="${path }/resources/admin/vendors/datatables.net/jquery.dataTables.js"></script>
  <script src="${path }/resources/admin/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="${path }/resources/admin/js/off-canvas.js"></script>
  <script src="${path }/resources/admin/js/hoverable-collapse.js"></script>
  <script src="${path }/resources/admin/js/template.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="${path }/resources/admin/js/data-table.js"></script>
  <script src="${path }/resources/admin/js/jquery.dataTables.js"></script>
  <script src="${path }/resources/admin/js/dataTables.bootstrap4.js"></script>
  <!-- End custom js for this page-->
<script>
//메소드로 숫자 넣어서 날짜 만드는 함수
function makeDay(num){
	var nowDate = new Date();
	var calDate = nowDate.getTime()-(num*24*60*60*1000);
	nowDate.setTime(calDate);
	var nowYear = nowDate.getFullYear();
	var nowMonth = nowDate.getMonth()+1;
	var nowDay = nowDate.getDate();
	if(nowMonth<10){nowMonth="0"+nowMonth;}
	if(nowDay<10){nowDay = "0"+nowDay;}
	var resultDate = nowYear+"-"+nowMonth+"-"+nowDay;
	return resultDate;
}
//두번째 div 즉, char용 function 
function bringSecondDiv(sendNum){
	var obj='';
	$.ajax({
		url:'${path }/admin/bringSecondDiv.do',
		type:'post',
		data:{'sendNum':sendNum},
		 async: false,
		success:function(data){
			//b가 재고 변동이고, a가 in, c가 out
			obj={
				a:Object.values(data)[0],
				b:Object.values(data)[1],
				c:Object.values(data)[2]
			}
		
		}
	});
	return obj;
	
}
(function($) {
  'use strict';
  $(function() {

    if ($('#product-stock-chart').length) {
      var cashDepositsCanvas = $("#product-stock-chart").get(0).getContext("2d");
      
      
      var data = { 		  
        labels: [makeDay(6), makeDay(5), makeDay(4), makeDay(3), makeDay(2), makeDay(1), makeDay(0)],
        datasets: [
          {
            label: '입고량',
            data: [bringSecondDiv(6).a, bringSecondDiv(5).a, bringSecondDiv(4).a, bringSecondDiv(3).a,bringSecondDiv(2).a, bringSecondDiv(1).a, bringSecondDiv(0).a],
            borderColor: [
              '#ff4747'
            ],
            borderWidth: 2,
            fill: false,
            pointBackgroundColor: "#fff"
          },
          {
            label: '출고량',
            data: [bringSecondDiv(6).c, bringSecondDiv(5).c, bringSecondDiv(4).c, bringSecondDiv(3).c, bringSecondDiv(2).c, bringSecondDiv(1).c, bringSecondDiv(0).c],
            borderColor: [
              '#4d83ff'
            ],
            borderWidth: 2,
            fill: false,
            pointBackgroundColor: "#fff"
          },
          {
            label: '재고변동',
            data: [bringSecondDiv(6).b, bringSecondDiv(5).b, bringSecondDiv(4).b, bringSecondDiv(3).b, bringSecondDiv(2).b, bringSecondDiv(1).b, bringSecondDiv(0).b],
            borderColor: [
              '#ffc100'
            ],
            borderWidth: 2,
            fill: false,
            pointBackgroundColor: "#fff"
          }
        ]
      };
      var options = {
        scales: {
          yAxes: [{
            display: true,
            gridLines: {
              drawBorder: false,
              lineWidth: 1,
              color: "#e9e9e9",
              zeroLineColor: "#e9e9e9",
            },
            ticks: {
              min:	-500,
              max: 500,
              stepSize: 100,
              fontColor: "#6c7383",
              fontSize: 16,
              fontStyle: 300,
              padding: 15
            }
          }],
          xAxes: [{
            display: true,
            gridLines: {
              drawBorder: false,
              lineWidth: 1,
              color: "#e9e9e9",
            },
            ticks : {
              fontColor: "#6c7383",
              fontSize: 16,
              fontStyle: 300,
              padding: 15
            }
          }]
        },
        legend: {
          display: false
        },
        legendCallback: function(chart) {
          var text = [];
          text.push('<ul class="dashboard-chart-legend">');
          for(var i=0; i < chart.data.datasets.length; i++) {
            text.push('<li><span style="background-color: ' + chart.data.datasets[i].borderColor[0] + ' "></span>');
            if (chart.data.datasets[i].label) {
              text.push(chart.data.datasets[i].label);
            }
          }
          text.push('</ul>');
          return text.join("");
        },
        elements: {
          point: {
            radius: 3
          },
          line :{
            tension: 0
          }
        },
        stepsize: 1,
        layout : {
          padding : {
            top: 0,
            bottom : -10,
            left : -10,
            right: 0
          }
        }
      };
      var cashDeposits = new Chart(cashDepositsCanvas, {
        type: 'line',
        data: data,
        options: options
      });
      document.getElementById('product-stock-chart-legend').innerHTML = cashDeposits.generateLegend();
    }

    $('#recent-purchases-listing').DataTable({
        "aLengthMenu": [
          [5, 10, 15, -1],
          [5, 10, 15, "All"]
        ],
        "iDisplayLength": 10,
        "language": {
          search: ""
        },
        searching: false, paging: false, info: false
      });

  });
})(jQuery);

//제일 위에 div에 꽂을 데이터들 가져오는거
//공통적으로 들어가는게 7일전부터~, 30일전부터~, 365일전부터~니까 이 숫자를 매개변수로 넣고 function 돌릴꺼임 
function bringFirstDiv(numDate){
	$.ajax({
		url:'${path }/admin/bringFirstDiv.do',
		type:'post',
		data:{'numDate':numDate},
		success:function(data){
			var t='';
			var c='';
			var i='';
			var o='';
			t+=Object.values(data)[0];
			c+=Object.values(data)[1];
			i+=Object.values(data)[2];
			o+=Object.values(data)[3];
			$("#totalStock"+numDate).html(t);
			$("#changeStock"+numDate).html(c);
			$("#inStock"+numDate).html(i);
			$("#outStock"+numDate).html(o);
		}
	})
}

$(document).ready(function(){
	bringFirstDiv(7);
	bringFirstDiv(30);
	bringFirstDiv(365);
})

</script>

</body>
</html>