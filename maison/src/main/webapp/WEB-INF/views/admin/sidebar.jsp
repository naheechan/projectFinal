<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="${path }/admin/dashBoard.do">
              <i class="mdi mdi-home menu-icon"></i>
              <span class="menu-title">대시보드</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-product" aria-expanded="false" aria-controls="ui-product">
              <i class="mdi mdi-barcode-scan menu-icon"></i>
              <span class="menu-title">상품관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-product">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path}/admin/mypage/product/enrollView.do">상품 등록,수정</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/productStock.do">상품 재고 관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/admin/mypage/product/inquiryView.do">상품 문의 관리 </a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/review/selectPeriodReview.do">상품 리뷰 관리 </a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/productRequest.do">입고 요청 관리 </a></li>
                <li class="nav-item"> <a class="nav-link" href="${path}/admin/mypage/product/categoryView.do">상품 분류 관리 </a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-order" aria-expanded="false" aria-controls="ui-order">
              <i class="mdi mdi-cart menu-icon"></i>
              <span class="menu-title">주문관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-order">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="#">결제관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="#">취소관리</a></li>
              </ul>
            </div>
          </li>     
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-member" aria-expanded="false" aria-controls="ui-member">
              <i class="mdi mdi-account-multiple menu-icon"></i>
              <span class="menu-title">회원관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-member">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/memberList.do">회원 목록</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/deletedMemberList.do">회원 탈퇴 관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/membership.do">회원 등급 관리</a></li>
              </ul>
            </div>
          </li>      
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-board" aria-expanded="false" aria-controls="ui-board">
              <i class="mdi mdi-bulletin-board menu-icon"></i>
              <span class="menu-title">게시판관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-board">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/adminNoticeList.do">공지 관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="${path }/admin/adminQnaList.do">질문 관리</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-with" aria-expanded="false" aria-controls="ui-with">
              <i class="mdi mdi-bridge menu-icon"></i>
              <span class="menu-title">함께해요 관리</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-with">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="#">게시글 관리</a></li>
                <li class="nav-item"> <a class="nav-link" href="#">신고 관리</a></li>
              </ul>
            </div>
          </li>                     
          <li class="nav-item">
            <a class="nav-link" href="#">
              <i class="mdi mdi-cash menu-icon"></i>
              <span class="menu-title">매출현황</span>
            </a>
          </li>
          
        </ul>
      </nav>
<!-- partial -->