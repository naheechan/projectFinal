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
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="${path}/resources/js/bootstrap4-toggle.min.js"></script>
<style>
	#detailTab-container{
		padding: 3vh;
	}
	.productActive {
		filter: brightness(100%);
	}
	.productInactive {
		filter: brightness(50%);
	} 
	.noList {
		padding: 20vh;
		text-align: center;
	}
	.noList button {
		margin-top: 5vh;
	}
	.text-area {
		background-color: #F2BB9C;
		color: white;
		font-size: 16px;
		font-weight: bold;
		padding: 5px;
	}
	.ellipsis{
	    width:200px;
	    padding:0 5px;
	    overflow:hidden;
	    text-overflow:ellipsis;
	    white-space:nowrap;
    }
</style>
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
								<a class="list-group-item list-group-item-action <c:if test="${tab eq 'all'}">active</c:if>" href="${path }/shopCycle/cycleList?tab=all">
									<b>한번에 보기(<c:out value="${countCycleMap.total}"/>)</b>
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
										<a href="${path }/shopCycle/cycleList?tab=${largeCate.largeCate }" id="cateSearch" class="list-group-item list-group-item-action <c:if test="${tab eq largeCate.largeCate}">active</c:if>">
											<c:set var="cate" value="${largeCate.largeCate}"/>
											<c:out value="- ${cate}" />
											<c:choose>
												<c:when test="${cate eq '주방'}"><c:out value="${countCycleMap.kitchen ne null?'('+=countCycleMap.kitchen+=')':''}"/></c:when>
												<c:when test="${cate eq '세탁실'}"><c:out value="${countCycleMap.laundry ne null?'('+=countCycleMap.laundry+=')':''}"/></c:when>
												<c:when test="${cate eq '현관'}"><c:out value="${countCycleMap.front ne null?'('+=countCycleMap.front+=')':''}"/></c:when>
												<c:when test="${cate eq '창고'}"><c:out value="${countCycleMap.warehouse ne null?'('+=countCycleMap.warehouse+=')':''}"/></c:when>
												<c:when test="${cate eq '욕실'}"><c:out value="${countCycleMap.bathroom ne null?'('+=countCycleMap.bathroom+=')':''}"/></c:when>
											</c:choose> 
										</a>
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
				
				<!-- 위에 보이는 세부목록 -->
				<c:if test="${tab ne 'all'}">
					<div class="border border-secondary" id="detailTab-container">
						<c:forEach var="mc" items="${medicate }" varStatus="j">
							<a href="${path }/shopCycle/cycleList?tab=${tab}&detailTab=${mc.mcName}">
								<span class="font-weight-bold">&middot; ${mc.mcName } &nbsp;</span>
							</a>
						</c:forEach>
					</div>
				</c:if>
				
				<!-- 현재 어디에 있는지 알려주는 텍스트 -->
				<div class="">
					<c:if test="${tab eq 'all'}">
						<span>한번에 보기 &gt;</span>
					</c:if> 
					<c:if test="${tab ne 'all'}">
						<span>세부내역 보기 &gt;</span>
						<span>${tab } &gt;</span>
						<c:if test="${detailTab ne null}">
							<span>${detailTab } &gt;</span>
						</c:if>
					</c:if>
				</div>
				
				<!-- 상품들을 감싸는 div -->
				<%-- <div class="" id="" style="background-color:fuchsia">

					<c:forEach var="product" items="${cycleList}" varStatus="i">
						${product}
					</c:forEach>
				</div> --%>
				
				<c:if test="${cycleList ne null}">
					<div class="right-product-box">
                        <div class="product-item-filter row">
                            <div class="col-12 col-sm-8 text-center text-sm-left">
                                <div class="toolbar-sorter-right">
                                    <span>필터</span>
                                    <select id="sort" class="selectpicker show-tick form-control" data-placeholder="$ USD">
										<option value="sortRecentOrder" ${param.sortOption eq null or param.sortOption eq 'sortRecentOrder'?'selected':''}>최근구매한 상품순</option>
										<option value="sortCycleDay" ${param.sortOption eq 'sortCycleDay'?'selected':''}>구매주기 순</option>
										<option value="sortNearDate" ${param.sortOption eq 'sortNearDate'?'selected':''}>다음 구매예상일순</option>
									</select>
                                </div> 
                            </div>
                            <div class="col-12 col-sm-4 text-center text-sm-right">
                            	<p>현재 페이지의 제품 개수 ${fn:length(cycleList)}개</p>
                            </div>
                        </div>
				<!-- 상품 -->
                 <div class="product-categorie-box">
                            <div class="tab-content">
                            	<c:if test="${cycleList.size()==0}">
                            		<div class="noList">
	                            		<p>이곳은 구매하신 상품의 관리를 위한 곳입니다.</p>
	                            		<p>상품을 구매하시고 '쇼핑시계'서비스를 이용해 보세요.</p>
	                            		<button class="btn btn-info" onclick="location.href='${path}/shop/shopView.do'">쇼핑하러 가기</button>
	                            	</div>
                            	</c:if>
                            	<c:if test="${cycleList.size()!=0}">
	                                <div role="tabpanel" class="tab-pane fade show active" id="grid-view">
	                                    <div class="row" id="divResult">
	                                    
	                                    <c:forEach var="list" items="${cycleList}" varStatus="i">
	                                        <div class="col-sm-6 col-md-6 col-lg-4 col-xl-4 eachItem">
	                                            <div class="products-single fix">
	                                            	<c:set var="toggleId" value="toggle${i.index}"/>
										     		<input type="hidden" name="no" value="${list.productNo}"/>
											     	<input type="checkbox" id="${toggleId}" class="alertToggle" name="alertCheck" data-toggle="toggle" data-size="xs" ${list.alertStatus eq 'Y'?'checked':''}><c:out value=" 알림 서비스 수신"/>
	                                                <div class="box-img-hover">
	                                                    <div class="type-lb">
	                                                    </div>
	                                                    <img src="${path }/resources/upload/product/${list.productImg}" class="img-fluid" alt="Image">
	                                                    <div class="mask-icon">
	                                                        <a class="cart" href="${path }/shop/shopDetail.do?no=${list.productNo}">상품 보러가기</a>
	                                                    </div>
	                                                </div>
	                                                <div class="why-text">
	                                                    <h4><a class="pName ellipsis" href="${path }/shopCycle/cycleDetail?no=${list.productNo}">${list.productName}</a></h4><br>
	                                                    
	                                                    <button class="btn btn-outline-info pSetting" onclick="location.href='${path }/shopCycle/cycleDetail?no=${list.productNo}'">주기 설정하기</button>
	                                                    <c:if test="${list.cycleMode eq 'onCycle' }">
	                                                  		<c:set var="cycleDay" value="${list.onCycle}" />
	                                                    </c:if>
	                                                    <c:if test="${list.cycleMode eq 'offCycle' }">  
		                                                    <c:set var="cycleDay" value="${list.offCycle}" />
	                                                    </c:if>
	                                                    
	                                                    <!-- 직전에 구매한 상품 갯수 -->
	                                                    <c:set var="odAmount" value="${list.odAmount}" />
	                                                    <!-- startDate를 밀리세컨드로 변환 -->
	                                                    <fmt:parseNumber var="startDate_M" value="${list.startDate.time}"/>
	                                                   	<!-- 변수를 스크립틀릿에서 사용하기 위해서 c:set으로 저장 -->
	                                                    <c:set var="startDa" value="${startDate_M}" />
	                                                    <%
	                                                    	//직전에 구매한 상품의 갯수
	                                                    	int amount = Integer.parseInt(String.valueOf(pageContext.getAttribute("odAmount")));
	                                                    	
	                                                    	//주기(day)를 int변수에 넣어줌
	                                                    	int cycleDay = Integer.parseInt(String.valueOf(pageContext.getAttribute("cycleDay")));
	                                                    	//startDate를 Calendar를 이용해서 주기(day)를 더하면 다음 구매예상일 날짜 구해짐
	                                                    	Date startDa = new Date(Long.valueOf(String.valueOf(pageContext.getAttribute("startDa"))));
	                                                    	Calendar cal = Calendar.getInstance();
	                                                    	cal.setTime(startDa);
	                                                    	
	                                                    	Calendar calToday = Calendar.getInstance(); //지금 현재 날짜
	                                                    	calToday.set(Calendar.HOUR_OF_DAY, 0);
	                                                    	calToday.set(Calendar.MINUTE, 0);
	                                                    	calToday.set(Calendar.SECOND, 0);
	                                                    	calToday.set(Calendar.MILLISECOND, 0);
	                                            			
	                                                    	//오늘보다 다음구매예상일이 더 커질때까지 더함.
	                                                    	do{
	                                                    		cal.add(Calendar.DATE, cycleDay*amount);
	                                                    	}while(cal.getTimeInMillis() < calToday.getTimeInMillis());
	                                                    	
	                                                    	startDa = new Date(cal.getTimeInMillis());
	                                                    	pageContext.setAttribute("startDate", startDa);
	                                                   	%>
	                                                    
	                                                    <div class="text-area">
		                                                    <ul>
		                                                    	<li>구매주기(1개 기준) </li>
		                                                    	<ul>
		                                                    		<li>&nbsp;&nbsp;&nbsp;&nbsp;- <c:out value="${cycleDay}" />일</li>
		                                                    	</ul>
		                                                    	<li>다음 구매예상일 </li>
		                                                    	<ul>
		                                                    		<li>&nbsp;&nbsp;&nbsp;&nbsp;- <fmt:formatDate value="${startDate}" pattern="yyyy년 MM월 dd일" /></li>
		                                                    	</ul>
		                                                    </ul>
	                                                    </div>
	                                                    
	                                                </div>
	                                            </div>
	                                        </div>
	                                        </c:forEach>
	                                     </div>
	                                     ${pageBar }
	                                  </div>
								</c:if>
                            </div>
                        </div>
                    </div>
				</c:if>
				
				
			</div>
			
			
			
			

		</div>	
	</div>
</div>
</section>


<script>
$(function() {
	
	//알림 수신 여부에 따라서 활성화/비활성화
	$("input[name=alertCheck]").each(function(index, item) {
		if(item.checked==true) {
			$(item).parents(".eachItem").addClass("productActive");
			$(item).parents(".eachItem").find(".pName").unbind('click');
			$(item).parents(".eachItem").find(".pSetting").attr("disabled",false);
		}else {
			$(item).parents(".eachItem").addClass("productInactive");
			$(item).parents(".eachItem").find(".pName").bind('click',false); 
			$(item).parents(".eachItem").find(".pSetting").attr("disabled",true);
		}
	});  
	
	
	//알림 수신 체크박스 누를때마다 ajax로 알림수신 on/off
	$("input[name=alertCheck]").on('change', function(e) {
		var item = e.target;
		var no = $(item).parent().prev().val();
		var check = item.checked;
		
		$.ajax({
			type:"get",
			url:"${path}/shopCycle/editAlert",
			data:{
				no:no,
				check:check
			},
			error:function(error) {
				console.log(error);
				swal("처리중 요류가 발생했습니다", "관리자에게 문의하세요", "warning");
			},
			success:function(data) {
				if(data=="1") {
					//ajax성공했으면 view도 알맞게 바꿔줌
					if(item.checked==true) {
						$(item).parents(".eachItem").addClass("productActive");
						$(item).parents(".eachItem").removeClass("productInactive");
						$(item).parents(".eachItem").find(".pName").unbind('click');
						$(item).parents(".eachItem").find(".pSetting").attr("disabled",false); 
						
					}else {
						$(item).parents(".eachItem").addClass("productInactive");
						$(item).parents(".eachItem").removeClass("productActive");
						$(item).parents(".eachItem").find(".pName").bind('click',false); 
						$(item).parents(".eachItem").find(".pSetting").attr("disabled",true);
					}
				}else {
					swal("처리중 요류가 발생했습니다", "관리자에게 문의하세요", "warning");
				}
			}
		});
	}); 
	
	
	//정렬하는 부분
	$("#sort").on('change',function(e) {
		var sortOption = $("#sort option:selected").val();
		location.href="${path}/shopCycle/cycleList?tab=${tab}&detailTab=${detailTab}&sortOption="+sortOption;
	});
	
	
	
});

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		