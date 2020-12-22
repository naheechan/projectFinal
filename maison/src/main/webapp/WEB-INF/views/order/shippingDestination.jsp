<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link type="text/css" rel="stylesheet" href="https://ssl.pstatic.net/static.pay/u/c/static/202012171558/css/setting/setting_simple.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="배송지/환불계좌관리"/>
</jsp:include>


<section>
	
	<div class="container">
		<div class="row" style="height: 500px;">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-8">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			
	<div id="wrap" style="width: 75%">
   

    <!-- header -->
    <%-- <div id="header">
        <div class="header_inner">
            <h1>
                <a href="${path }/" class="logo_MAISON"><span class="blind">MAISON</span></a>
                <a href="${path }/member/mypage.do" class="logo_myinfo"><span class="blind">내정보</span></a>
            </h1>
        </div>
        <div class="lnb_area">
            <div class="lnb">
                <ul class="lnb_menu">
                    <li class="_snb_addressbook"><a href="#">배송지 목록</a></li>
                    <li class="_snb_recently"><a href="#">최근 배송지</a></li>
                </ul>
            </div>
        </div>
    </div> --%>
    <!-- //header -->

    <!-- container -->
    <div id="container">
	<div id="content" class="delivery_setting">
    <h2 class="setting_title">배송지 목록</h2>
	    <div class="desc_delivery">
	        <p class="desc">최근 입력하신 배송지 3곳을 보여드립니다.<br>자주 쓰는 배송지를 편리하게 통합 관리 하세요!</p>
	    </div>
	    
	    
	    
    <div class="delivery_list_area" style="overflow: hidden;">
        <table class="tbl_delivery_list">
            <colgroup>
                <col class="cell_delivery">
                <col>
                <col class="cell_tel">
                <col class="cell_edit">
            </colgroup>
            <thead>
            <tr>
                <th scope="col" class="cell_delivery">수령인</th>
                <th scope="col">주소</th>
                <th scope="col" class="cell_tel">연락처</th>
                <th scope="col" class="cell_edit">삭제</th>
            </tr>
            </thead>
            <tbody>
            	<c:forEach items="${list }" var="o">
                  <tr>
                    <td class="cell_delivery">
                        <strong class="nick">${o.receiver }</strong>
                       		${o.receiver }
                        <!-- <span class="mark_default">기본배송지</span> -->
                    </td>
                    <td>
                        <span class="zipcode">${o.orZipcode }</span> ${o.orAddress }<br>${o.orDetailAddress }
                    </td>
                    <td class="cell_tel">${o.orPhone } </td>
                    <td class="cell_edit">
                       
                        <a href="${path }/order/deleteShippingDestination.do?no=
                        }" class="_delete setting_btn type_h">삭제</a><!--N=a:adr.listdel-->
                      
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>    </div>
    <!-- //container -->
			
			
		</div>
</section>








<jsp:include page="/WEB-INF/views/common/footer.jsp"/>