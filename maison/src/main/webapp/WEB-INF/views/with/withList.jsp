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
                        <button class="active" id="NoFilter">전체보기</button>
                        <button id="freeFilter">나눔하기</button>
                        <button id="sellFilter">중고거래</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
        	<div class="col-lg-12">
        		<h3 id="contentsCount">총 <c:out value="${totalContents }"/>건의 게시글이 있습니다.</h3>
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
        				<tbody id="tbl-withList-tbody">
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
        								<td>
        								<c:choose>
        									<c:when test="${l.wbStatus eq 'N' }">
        										<c:out value="${l.wbTitle }"/>&nbsp;
        										<span style="color:#FA7B00;border:1px solid rgba(251,100,0,0.9);">판매중</span>
        									</c:when>
        									<c:when test="${l.wbStatus eq 'P' }">
        										<c:out value="${l.wbTitle }"/>&nbsp;
        										<span style="color:#09CE20;border:1px solid #09CE20;">예약중</span>
        									</c:when>
        									<c:when test="${l.wbStatus eq 'Y' }">
        										<span style="color:rgba(210,210,210,0.9);">
        											<c:out value="${l.wbTitle }"/>
        										</span>	&nbsp;
        										<span style="color:rgba(210,210,210,0.9);border:1px solid rgba(210,210,210,0.9);">판매완료</span>
        									</c:when>
        								</c:choose>
        									
        								</td>
        								
        								<td>
        									<c:set var="beforeMemberId" value="${l.memberId }"/>
											<c:set var="afterMemberId" value="${fn:substring(beforeMemberId,0,3) }"/>
        									<c:out value="${afterMemberId }"/>***
        								</td>
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
        		<c:if test="${not empty loginMember  }">
	        		<button class="btn" type="button" onclick="location.href='${path }/with/withEnroll.do'" style="float:right;background:#FCF7E1;">등록하기</button>   
          		</c:if>
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
	
	$(document).ready(function(){
		$('#freeFilter').on("click",function(){
			$("#tbl-withList-tbody tr").filter(function(){
				$(this).toggle($(this).text().toLowerCase().indexOf("나눔")>-1);
			});
		});
		$('#sellFilter').on("click",function(){
			$("#tbl-withList-tbody tr").filter(function(){
				$(this).toggle($(this).text().toLowerCase().indexOf("중고")>-1);
			});
		});
		$('#NoFilter').on("click",function(){
			$("#tbl-withList-tbody tr").filter(function(){
				$(this).toggle($(this).text().toLowerCase().indexOf("")>-1)
			});
		});
	});
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		