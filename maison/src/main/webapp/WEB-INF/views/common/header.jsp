<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Mobile Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Site Icons -->
<link rel="shortcut icon" href="${path }/resources/images/favicon.png" type="image/x-icon">
<link rel="apple-touch-icon" href="${path }/resources/images/apple-touch-icon.png">   
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="${path }/resources/css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="${path }/resources/css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${path }/resources/css/custom.css"> 

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<script src="${path }/resources/js/jquery-ui.js"></script>


<title><c:out value="${param.title }"/></title>
</head>
<body>
<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fa fa-bars"></i>
            </button>
                <a class="navbar-brand" href="index.html"><img src="${path }/resources/images/logo2.png" class="logo" alt="" style="width:94px;"></a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="navbar-menu">
				<ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
					<!-- 눌려졌을때를 표현하고 싶으면 li class에 active를 추가하세요. -->
					<li class="nav-item"><a class="nav-link" href="index.html">메종은?</a></li>

					<li class="nav-item"><a class="nav-link" href="${ path }/shop/shopView.do">쇼핑해요</a></li>

					<li class="nav-item"><a class="nav-link" href="${path }/with/withList.do">함께해요</a></li>
 					<li class="dropdown">
						<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">소통해요</a>
						<ul class="dropdown-menu">
							<li><a href="shop.html">공지해요</a></li>
							<li><a href="shop-detail.html">질문해요</a></li>
						</ul>
					</li>

					<li class="nav-item"><a class="nav-link" href="contact-us.html">쇼핑시계</a></li>
				</ul>
			</div>
            <!-- /.navbar-collapse -->

            <!-- Start Atribute Navigation -->
            <div class="attr-nav">
                <ul>
                	<c:if test="${loginMember ne null}">
                		<li><a href="${path }/wishList.do?id=${loginMember.memberId}"><i class="far fa-heart"></i></a></li>
                	</c:if>
                    <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                    
                    <c:if test="${loginMember eq null}">
                    	<li class="login"><a href="${path }/member/login"><i class="fas fa-user-alt"></i></a></li>
                    </c:if>
                    <c:if test="${loginMember ne null}">
                    	<li class=""><a href="#"><c:out value="${loginMember.memberName}님"/></a></li>
                    </c:if>
                    
                    <li class="side-menu">
                    	<a href="#">
							<i class="fa fa-shopping-bag"></i>
			                	<span class="badge">3</span>
								<p>장바구니</p>
						</a>
					</li>
					<c:if test="${loginMember ne null}">
                    	<li class=""><a href="${path}/member/logout"><c:out value="로그아웃"/></a></li>
                    </c:if>
					
                </ul>
            </div>
            <!-- End Atribute Navigation -->
        </div>
        
        <!-- Start Side Menu -->
        <div class="side">
            <a href="#" class="close-side"><i class="fa fa-times"></i></a>
            <li class="cart-box">
                <ul class="cart-list">
                    <li>

                        <a href="#" class="photo"><img src="${ path }/resources/images/img-pro-01.jpg" class="cart-thumb" alt="" /></a>

                        <a href="#" class="photo"><img src="${path }/resources/images/img-pro-01.jpg" class="cart-thumb" alt="" /></a>

                        <h6><a href="#">Delica omtantur </a></h6>
                        <p>1x - <span class="price">$80.00</span></p>
                    </li>
                    <li>

                        <a href="#" class="photo"><img src="${ path }/resources/images/img-pro-02.jpg" class="cart-thumb" alt="" /></a>

                        <a href="#" class="photo"><img src="${path }/resources/images/img-pro-02.jpg" class="cart-thumb" alt="" /></a>

                        <h6><a href="#">Omnes ocurreret</a></h6>
                        <p>1x - <span class="price">$60.00</span></p>
                    </li>
                    <li>

                        <a href="#" class="photo"><img src="${ path }/resources/images/img-pro-03.jpg" class="cart-thumb" alt="" /></a>

                        <a href="#" class="photo"><img src="${path }/resources/images/img-pro-03.jpg" class="cart-thumb" alt="" /></a>

                        <h6><a href="#">Agam facilisis</a></h6>
                        <p>1x - <span class="price">$40.00</span></p>
                    </li>
                    <li class="total">
                        <a href="#" class="btn btn-default hvr-hover btn-cart">VIEW CART</a>
                        <span class="float-right"><strong>Total</strong>: $180.00</span>
                    </li>
                </ul>
            </li>
        </div>
        <!-- End Side Menu -->
    </nav>
    <!-- End Navigation -->
</header>
<!-- End Main Top -->

<!-- Start Top Search -->
<div class="top-search">
    <div class="container">
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-search"></i></span>
            <input type="text" class="form-control" placeholder="Search">
            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
        </div>
    </div>
</div>
<!-- End Top Search -->