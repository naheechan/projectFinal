<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="메종은?"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="메종은?"/>
</jsp:include>

<!-- Start Maison? -->
<div class="about-box-main">
	<div class="container">
		<div class="row">
				<div class="col-lg-6">
                    <div class="banner-frame"> <img class="img-fluid" src="${path }/resources/images/about-img.jpg" alt="" />
                    </div>
                </div>
                <div class="col-lg-6">
                    <h2 class="noo-sh-title-top">안녕하세요 <span>메종입니다.</span></h2>
                    <p>"집안에서 생활하는 시간이 늘어나는 요즘, 반드시 있어야하는 생활 소모품이 갑자기 똑 떨어져서 당황하신적이 있지 않나요?" </p>
                    
                    <p>	메종에서는 주방세제, 화장지, 기저귀, 면봉, 렌즈세정제, 치약, 샴푸, 섬유유연제, 마스크처럼 매일매일 우리 곁에 있는 생활 소모품들을 무료배송으로 구매할 수 있습니다. </p>
                    	
                    	<p>또한 메종에서 구입한 생활 소모품들의 사용 주기를 체크하여, 
                    	해당 상품의 사용 완료일 일주일 전에 메일링 서비스를 선택적으로 받으실 수 있습니다. 
                    	메일링 서비스를 받으시려면 회원가입시 반드시 인증가능한 이메일을 입력해주시고, 이메일 제공에 동의해주세요. 
                    	스크롤을 아래로 내리시면 메종에서 반드시 알아두셔야할 주기들의 개념에 대해서 보실 수 있습니다. 
                    	</p>
                    <p>즐거운 쇼핑되시고, 가정에 평안과 행복이 가득하시길 기원합니다. </p>
                    <c:if test="${loginMember eq null }">
						<a class="btn hvr-hover" href="${path }/member/login">시작하기</a>
                    </c:if>
                    <c:if test="${loginMember ne null }">
                    	<a class="btn hvr-hover" href="${path }/member/mypage.do">시작하기</a>
                    </c:if>
                </div>			
		</div>
	</div>
</div>
<div class="about-box-main">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="title-all text-center">
	                <h1>주기들</h1>
	                <p>메종에서 제공하는 주기 서비스의 근간이 되는 주기들로 기본주기, 실측주기, 예측주기, 추천주기가 있습니다.</p>					
				</div>
			</div>
		</div>
		<div class="row my-5">
		    <div class="col-sm-6 col-lg-3">
		        <div class="service-block-inner">
		            <h3>기본주기</h3>
		            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-3">
		        <div class="service-block-inner">
		            <h3>실측주기</h3>
		            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-3">
		        <div class="service-block-inner">
		            <h3>예측주기</h3>
		            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-3">
		        <div class="service-block-inner">
		            <h3>추천주기</h3>
		            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
		        </div>
		    </div>
		</div>
	</div>
</div>
<!-- End Maison? -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		