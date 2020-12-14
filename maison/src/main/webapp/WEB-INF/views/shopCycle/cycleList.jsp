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
<style>
	#detailTab-container{
		padding: 3vh;
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
											<c:out value="${cate}" />
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
                                    <span>Sort by </span>
                                    <select id="basic" class="selectpicker show-tick form-control" data-placeholder="$ USD">
									<option data-display="Select">Nothing</option>
									<option value="1">Popularity</option>
									<option value="2">High Price → High Price</option>
									<option value="3">Low Price → High Price</option>
									<option value="4">Best Selling</option>
								</select>
                                </div> 
                                <p>총 제품의 개수 ${fn:length(cycleList)}개</p>
                            </div>
                            <div class="col-12 col-sm-4 text-center text-sm-right">
                                <ul class="nav nav-tabs ml-auto">
                                    <li>
                                        <a class="nav-link active" href="#grid-view" data-toggle="tab"> <i class="fa fa-th"></i> </a>
                                    </li>
                                    <li>
                                        <a class="nav-link" href="#list-view" data-toggle="tab"> <i class="fa fa-list-ul"></i> </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
				<!-- 상품 -->
                 <div class="product-categorie-box">
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade show active" id="grid-view">
                                    <div class="row" id="divResult">
                                    
                                    <c:forEach var="list" items="${cycleList}" varStatus="i">
                                        <div class="col-sm-6 col-md-6 col-lg-4 col-xl-4">
                                            <div class="products-single fix">
                                                <div class="box-img-hover">
                                                    <div class="type-lb">
                                                    </div>
                                                    <img src="${path }/resources/upload/product/${list.productImg}" class="img-fluid" alt="Image">
                                                    <div class="mask-icon">
                                                        <a class="cart" href="${path }/shop/shopDetail.do?no=${list.productNo}">상품 보러가기</a>
                                                    </div>
                                                </div>
                                                <div class="why-text">
                                                    <h4><a href="#">${list.productName}</a></h4><br>
                                                    <button class="btn btn-outline-info" onclick="location.href='${path }/shopCycle/cycleDetail?no=${list.productNo}'">주기 설정하기</button>
                                                    <c:if test="${list.cycleMode eq 'onCycle' }">
                                                  		<c:set var="cycleDay" value="${list.onCycle}" />
	                                                    <h5>구매주기 : <c:out value="${cycleDay}" />일</h5>                                                
                                                    </c:if>
                                                    <c:if test="${list.cycleMode eq 'offCycle' }">  
	                                                    <c:set var="cycleDay" value="${list.offCycle}" />
	                                                    <h5>구매주기 : <c:out value="${cycleDay}" />일</h5>                                               
                                                    </c:if>
                                                    
                                                    <!-- startDate를 밀리세컨드로 변환 -->
                                                    <fmt:parseNumber var="startDate_M" value="${list.startDate.time}"/>
                                                   	<!-- 변수를 스크립틀릿에서 사용하기 위해서 c:set으로 저장 -->
                                                    <c:set var="startDa" value="${startDate_M}" />
                                                 	
                                                    <%
                                                    	//주기(day)를 int변수에 넣어줌
                                                    	int cycleDay = Integer.parseInt(String.valueOf(pageContext.getAttribute("cycleDay")));
                                                    	//startDate를 Calendar를 이용해서 주기(day)를 더하면 다음 구매예상일 날짜 구해짐
                                                    	Date startDa = new Date(Long.valueOf(String.valueOf(pageContext.getAttribute("startDa"))));
                                                    	Calendar cal = Calendar.getInstance();
                                                    	cal.setTime(startDa);
                                                    	
                                                    	Calendar calToday = Calendar.getInstance(); //지금 현재 날짜
                                                    	//오늘보다 다음구매예상일이 더 커질때까지 더함.
                                                    	do{
                                                    		cal.add(Calendar.DATE, cycleDay);
                                                    	}while(cal.getTimeInMillis() < calToday.getTimeInMillis());
                                                    	
                                                    	startDa = new Date(cal.getTimeInMillis());
                                                    	pageContext.setAttribute("startDate", startDa);
                                                   	%>
                                                    <h5>다음 구매예상일 : </h5>
                                                    <h5><fmt:formatDate value="${startDate}" pattern="yyyy년 MM월 dd일" /></h5>
                                                </div>
                                            </div>
                                        </div>
                                        </c:forEach>
                                     </div>
                                  </div>
                            </div>
                        </div>
                    </div>
				</c:if>
				
				
			</div>
			
			
			
			

		</div>	
	</div>
</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		