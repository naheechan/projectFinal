<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.util.Date,java.util.Calendar"%>
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
		<!-- Start MainPanel 여기가 페이지별로 바뀌는 부분  -->
		      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-md-12 grid-margin">
              <div class="d-flex justify-content-between flex-wrap">
                <div class="d-flex align-items-end flex-wrap">
                  <div class="mr-md-3 mr-xl-5">
                    <h2>환영합니다,</h2>
                    <p class="mb-md-0">메종 관리자 전용 페이지입니다.</p>
                  </div>

                </div>
                <div class="d-flex justify-content-between align-items-end flex-wrap">
                  <div class="d-flex">
                    <i class="mdi mdi-home text-muted hover-cursor"></i>
                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;&nbsp;</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
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
		                            <small class="mb-1 text-muted">현재 총 매출</small>
		                            <h5 class="mr-2 mb-0" id="totalStock7"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-success"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">매출 변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock7"></h5>
		                          </div>
		                        </div>
		                       <!--  <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
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
		                        </div> -->
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
		                            <small class="mb-1 text-muted">현재 총 매출</small>
		                            <h5 class="mr-2 mb-0" id="totalStock30"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-warning"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">매출 변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock30"></h5>
		                          </div>
		                        </div>
		                        <!-- <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
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
		                        </div> -->
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
		                            <small class="mb-1 text-muted">현재 총 매출</small>
		                            <h5 class="mr-2 mb-0" id="totalStock365"></h5>
		                          </div>
		                        </div>
		                        <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
		                          <i class="mdi mdi-contrast mr-3 icon-lg text-danger"></i>
		                          <div class="d-flex flex-column justify-content-around">
		                            <small class="mb-1 text-muted">매출 변동</small>
		                            <h5 class="mr-2 mb-0" id="changeStock365"></h5>
		                          </div>
		                        </div>
		                       <!--  <div class="d-flex border-md-right flex-grow-1 align-items-center justify-content-center p-3 item">
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
		                        </div> -->
		                      </div>
		                    </div>
		                    <!-- id가 year인 애 tab끝 -->
		                  </div>
		                  <!-- tab 3개 다 들어있는 애 끝 -->
		                </div>
		              </div>
		            </div>
          
          <div class="row">
            <div class="col-md-7 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">Cash deposits</p>
                  <p class="mb-4">To start a blog, think of a topic about and first brainstorm party is ways to write details</p>
                  <div id="cash-deposits-chart-legend" class="d-flex justify-content-center pt-3"></div>
                  <canvas id="cash-deposits-chart"></canvas>
                </div>
              </div>
            </div>
            <div class="col-md-5 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">Total sales</p>
                  <h1>$ 28835</h1>
                  <h4>Gross sales over the years</h4>
                  <p class="text-muted">Today, many people rely on computers to do homework, work, and create or store useful information. Therefore, it is important </p>
                  <div id="total-sales-chart-legend"></div>                  
                </div>
                <canvas id="total-sales-chart"></canvas>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 stretch-card">
              <div class="card">
                <div class="card-body">
                  <p class="card-title">Recent Purchases</p>
                  <div class="table-responsive">
                    <table id="recent-purchases-listing" class="table">
                      <thead>
                        <tr>
                            <th>상품번호</th>
                            <th>상품명</th>
                            <th>소계</th>
                            <th>금액</th>
                           
                            <th>주문날짜</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:forEach items="${list }" var="s">
                        <tr>  
                            <td>${s.productNo }</td>
                            <td>${s.productName }</td>
                            <td>${s.odAmount }</td>
                            <td>${s.odAmount*s.price }</td>
                            
                            <td>
                            	<fmt:formatDate value="${s.orderDate }" var="sysdate" pattern="yyyy-MM-dd"/>
                            	<c:out value="${sysdate }"/>
                            </td>
                        </tr>
                       </c:forEach>
                        
                      </tbody>
                    </table>
                  </div>
                  ${pageBar }
                </div>
              </div>
            </div>
        <!-- content-wrapper ends -->
		<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
      </div>
		<!-- End MainPanel 페이지별로 바뀌는 부분 끝 -->
	</div>
</div>
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
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/27fabf8f47.js" crossorigin="anonymous"></script>
<script>
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

function bringSecondData(sendNum){
	var obj='';
	$.ajax({
		url:'${path }/admin/bringSecondData.do',
		type:'post',
		data:{'sendNum':sendNum},
		 async: false,
		success:function(data){
			//a가 매출
			obj={
				a:Object.values(data)[0]
			
			}
		
		}
	});
	return obj;
	
}
(function($) {
	  'use strict';
	  $(function() {

	    if ($('#cash-deposits-chart').length) {
	      var cashDepositsCanvas = $("#cash-deposits-chart").get(0).getContext("2d");
	      var data = {
	        labels: [makeDay(6), makeDay(5), makeDay(4), makeDay(3), makeDay(2), makeDay(1), makeDay(0)],
	        datasets: [
	          {
	            label: '매출',
	            data: [bringSecondData(6).a, bringSecondData(5).a, bringSecondData(4).a, bringSecondData(3).a, bringSecondData(2).a, bringSecondData(1).a, bringSecondData(0).a],
	            borderColor: [
	              '#ff4747'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          }
	          /* {
	            label: 'Sales',
	            data: [29, 40, 37, 48, 64, 58, 70],
	            borderColor: [
	              '#4d83ff'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          },
	          {
	            label: 'Loss',
	            data: [90, 62, 80, 63, 72, 62, 40],
	            borderColor: [
	              '#ffc100'
	            ],
	            borderWidth: 2,
	            fill: false,
	            pointBackgroundColor: "#fff"
	          } */
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
	              min: 0,
	              max: 1000000,
	              stepSize: 100000,
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
	      document.getElementById('cash-deposits-chart-legend').innerHTML = cashDeposits.generateLegend();
	    }

	    if ($('#total-sales-chart').length) {
	      var totalSalesChartCanvas = $("#total-sales-chart").get(0).getContext("2d");

	      var data = {
	        labels: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",'10', '11','12', '13', '14', '15','16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26','27','28','29', '30','31', '32', '33', '34', '35', '36', '37','38', '39', '40'],
	        datasets: [
	          {
	            label: '2019',
	            data: [42, 42, 30, 30, 18, 22, 16, 21, 22, 22, 22, 20, 24, 20, 18, 22, 30, 34 ,32, 33, 33, 24, 32, 34 , 30, 34, 19 ,34, 18, 10, 22, 24, 20, 22, 20, 21, 10, 10, 5, 9, 14 ],
	            borderColor: [
	              'transparent'
	            ],
	            borderWidth: 2,
	            fill: true,
	            backgroundColor: "rgba(47,91,191,0.77)"
	          },
	          {
	            label: '2018',
	            data: [35, 28, 32, 42, 44, 46, 42, 50, 48, 30, 35, 48, 42, 40, 54, 58, 56, 55, 59, 58, 57, 60, 66, 54, 38, 40, 42, 44, 42, 43, 42, 38, 43, 41, 43, 50, 58 ,58, 68, 72, 72 ],
	            borderColor: [
	              'transparent'
	            ],
	            borderWidth: 2,
	            fill: true,
	            backgroundColor: "rgba(77,131,255,0.77)"
	          },
	          {
	            label: 'Past years',
	            data: [98, 88, 92, 90, 98, 98, 90, 92, 78, 88, 84, 76, 80, 72, 74, 74, 88, 80, 72, 62, 62, 72, 72, 78, 78, 72, 75, 78, 68, 68, 60, 68, 70, 75, 70, 80, 82, 78, 78, 84, 82 ],
	            borderColor: [
	              'transparent'
	            ],
	            borderWidth: 2,
	            fill: true,
	            backgroundColor: "rgba(77,131,255,0.43)"
	          }
	        ]
	      };
	      var options = {
	        scales: {
	          yAxes: [{
	            display: false,
	            gridLines: {
	              drawBorder: false,
	              lineWidth: 1,
	              color: "#e9e9e9",
	              zeroLineColor: "#e9e9e9",
	            },
	            ticks: {
	              display : true,
	              min: 0,
	              max: 100,
	              stepSize: 10,
	              fontColor: "#6c7383",
	              fontSize: 16,
	              fontStyle: 300,
	              padding: 15
	            }
	          }],
	          xAxes: [{
	            display: false,
	            gridLines: {
	              drawBorder: false,
	              lineWidth: 1,
	              color: "#e9e9e9",
	            },
	            ticks : {
	              display: true,
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
	          text.push('<ul class="dashboard-chart-legend mb-0 mt-4">');
	          for(var i=0; i < chart.data.datasets.length; i++) {
	            text.push('<li><span style="background-color: ' + chart.data.datasets[i].backgroundColor + ' "></span>');
	            if (chart.data.datasets[i].label) {
	              text.push(chart.data.datasets[i].label);
	            }
	          }
	          text.push('</ul>');
	          return text.join("");
	        },
	        elements: {
	          point: {
	            radius: 0
	          },
	          line :{
	            tension: 0
	          }
	        },
	        stepsize: 1,
	        layout : {
	          padding : {
	            top: 0,
	            bottom : 0,
	            left : 0,
	            right: 0
	          }
	        }
	      };
	      var totalSalesChart = new Chart(totalSalesChartCanvas, {
	        type: 'line',
	        data: data,
	        options: options
	      });
	      document.getElementById('total-sales-chart-legend').innerHTML = totalSalesChart.generateLegend();
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
	
function bringFirstData(numDate){
	$.ajax({
		url:'${path }/admin/bringFirstData.do',
		type:'post',
		data:{'numDate':numDate},
		success:function(data){
			var t='';
			var c='';
			/* var i='';
			var o=''; */
			t+=Object.values(data)[0];
			c+=Object.values(data)[1];
			/* i+=Object.values(data)[2];
			o+=Object.values(data)[3]; */
			$("#totalStock"+numDate).html(t+" 원");
			$("#changeStock"+numDate).html(c+" 원");
			/* $("#inStock"+numDate).html(i);
			$("#outStock"+numDate).html(o); */
		}
	})
}

$(document).ready(function(){
	bringFirstData(7);
	bringFirstData(30);
	bringFirstData(365);
})
</script>
</body>
</html>