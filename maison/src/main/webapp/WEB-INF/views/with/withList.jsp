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

<!-- Start With -->
<div class="products-box">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
	            <div class="title-all text-center">
	                <h1>함께해요</h1>
	                <p>함께해요에서 소모품을 나눔하거나 중고거래를 할 수 있습니다.</p>
	            </div>
        	</div>
		</div>
        <div class="row">
            <div class="col-lg-12">
                <div class="special-menu text-center">
                    <div class="button-group filter-button-group">
                        <button class="active" data-filter="*">전체</button>
                        <button data-filter=".free">나눔하기</button>
                        <button data-filter=".sell">중고거래</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
        	<div class="col-lg-12">
        		<h3>총 ${totalContents }건의 게시글이 있습니다.</h3>
        		<div class="table-main table-responsive">
        			<table class="table table-hover" id="tbl-withList">
        				<thead>
        					<tr>
        						<th>No</th>
        						<th>분류</th>
        						<th>제목</th>
        						<th>작성자</th>
        						<th>작성일</th>
        						<th>조회</th>
        					</tr>
        				</thead>
        				<tbody>
        					<c:if test="${not empty list }">
        						<c:forEach items="${list }" var="l" varStatus="vs">
        							<tr>
        								<td><c:out value="${l.wbNo }"/></td>
        								<td>
        									<c:if test="${l.wbType eq 'free' }">
        										나눔
        									</c:if>
        									<c:if test="${l.wbType ne 'free' }">
        										중고
        									</c:if>
        								</td>
        								<td><c:out value="${l.wbTitle }"/></td>
        								<td><c:out value="${l.memberId }"/></td>
        								<!-- 오늘 날짜를 구하기 -->
        								<c:set var="now" value="<%=new java.util.Date() %>"/>
        								<c:set var="sysCal"><fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/></c:set>
										<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd" value="${l.wbDate }"/></c:set>
        								<c:if test="${sysCal eq dateTempParse }">
        									<fmt:formatDate var="sysTime" value="${l.wbDate }" pattern="hh:mm"/>
	        								<td><c:out value="${sysTime }"/></td>
        								</c:if> 
        								<c:if test="${sysCal ne dateTempParse }">
        									<td><c:out value="${dateTempParse }"/></td>
        								</c:if>
        								<td><c:out value="${l.wbCount }"/></td>
        							</tr>
        						</c:forEach>
        					</c:if>
        				</tbody>
        			</table>	
        		</div>
        		<button class="btn" type="button" onclick="location.href='${path }/with/withEnroll.do'" style="float:right;background:#FCF7E1;">등록하기</button>   
        	</div>
				     	
        </div>
        <div class="row">
        	<div class="col-lg-12">
        		<div id="pageBar">
		        	${pageBar }	        
		        </div>
        	</div>
        </div>
	</div>
</div>

<!-- End With -->
<script>
	$(function(){
		$("#tbl-withList tr").click(function(){
			var str="";
			var tdArr = new Array();
			var tr = $(this);
			var td = tr.children();
			var no = td.eq(0).text();
			location.replace("${path }/with/withView.do?no="+no);
		})
	})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		