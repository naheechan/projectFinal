<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="첫화면"/>
</jsp:include>

<script>
	if(${auth ne null || !empty auth}) {
		swal("${auth}","이제 로그인하여 서비스를 이용하실수있습니다.","success");
	}
</script>
<style>
	.latest-blog, .products-box , #products-div{
		clear:both;
	}
</style>
<!-- Start Slider -->
   <div id="slides-shop" class="cover-slides">
        <ul class="slides-container">
            <li class="text-center">
                <img src="${path }/resources/images/mainpage/toiletpaper.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>안녕하세요 <br> 우리집 쇼핑시계 메종입니다</strong></h1>
                            <p class="m-b-40">지금 메종에서 회원가입하셔서 무료배송으로 소모품을 구매하시고, <br> 메일링이 포함되어 한층 더 편리한 구매주기관리를 서비스를 누려보세요.</p>
                            <p><a class="btn hvr-hover" href="#">시작하기</a></p>
                        </div>
                    </div>
                </div>
            </li>
            <li class="text-center">
                <img src="${path }/resources/images/mainpage/toothbrush.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>안녕하세요 <br> 우리집 쇼핑시계 메종입니다</strong></h1>
                            <p class="m-b-40">지금 메종에서 회원가입하셔서 무료배송으로 소모품을 구매하시고, <br> 메일링이 포함되어 한층 더 편리한 구매주기관리를 서비스를 누려보세요.</p>
                            <p><a class="btn hvr-hover" href="#">시작하기</a></p>
                        </div>
                    </div>
                </div>
            </li>
            <li class="text-center">
                <img src="${path }/resources/images/mainpage/detergent.jpg" alt="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="m-b-20"><strong>안녕하세요 <br> 우리집 쇼핑시계 메종입니다</strong></h1>
                            <p class="m-b-40">지금 메종에서 회원가입하셔서 무료배송으로 소모품을 구매하시고, <br> 메일링이 포함되어 한층 더 편리한 구매주기관리를 서비스를 누려보세요.</p>
                            <p><a class="btn hvr-hover" href="#">시작하기</a></p>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <div class="slides-navigation">
            <a href="#" class="next"><i class="fa fa-angle-right" aria-hidden="true"></i></a>
            <a href="#" class="prev"><i class="fa fa-angle-left" aria-hidden="true"></i></a>
        </div>
    </div>
    <!-- End Slider -->
    
    <!-- Start Categories  -->
    <div class="categories-shop">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="shop-cat-box">
                        <img class="img-fluid" src="${path }/resources/images/mainpage/mask.jpg" alt="" />
                        <a class="btn hvr-hover" href="#">안전</a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="shop-cat-box">
                        <img class="img-fluid" src="${path }/resources/images/mainpage/diaper2.jpg" alt="" />
                        <a class="btn hvr-hover" href="#">위생</a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="shop-cat-box">
                        <img class="img-fluid" src="${path }/resources/images/mainpage/shampoo.jpg" alt="" />
                        <a class="btn hvr-hover" href="#">뷰티</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Categories -->
    
    <!-- Start Products -->
    <div class="products-box">
    	<div class="container">
    		<div class="row">
    			<div class="col-lg-12">
                     <div class="title-all text-center">
                        <h1>인기상품</h1>
                        <p>메종 고객님들께서 가장 선호하시는 상품입니다.</p>
                    </div>   				
    			</div>
    		</div>
    		<div class="row">
    			<div class="col-lg-12">
                    <div class="special-menu text-center">
                        <div class="button-group filter-button-group">
                            <button id="NoFilter">전체보기</button>
                            <button id="WishFilter">위시리스트</button>
                            <button id="BestFilter">베스트셀러</button>
                        </div>
                    </div>
    			</div>
    		</div>
    		<!-- 여기서부터 상품 실제 데이터 띄우기 시작. -->
    		<div class="row" id="products-div">
    		
    		</div>
    	</div>
    </div>
    <!-- End Products -->
    <br>
    <!-- Start 함께해요 
    	이미지 추출하는걸 못해서 고민됨 ㅠㅠ-->
<!--     <div class="latest-blog">
    	<div class="container">
    		<div class="row">
    			<div class="col-lg-12">
                	<div class="title-all text-center">
                        <h1>함께해요</h1>
                        <p>한 주간 가장 인기많은 중고, 나눔  게시글입니다.</p>
                    </div>   				
    			</div>
    		</div>
    		함께해요 데이터들이 꽂히는 곳
    		<div class="row" id="withs-div">
    			
    		</div>
    	</div>
    </div> -->
    <!-- End 함께해요 -->
<script>
// 화면 켜지면, #products-div에 ajax로 가져온 데이터 꽂아주기. 
// 지금은 wishList() 4개를 ajax로 불러와서 꽂아주는데 , bestSeller랑 Mix만들어서
// 기본값은 function mixWishBest()로 해서 꽂을거임. (wish2개 , Best seller 2개)
$(document).ready(function(){
	wishList();
	bestSeller();
})

$(function(){
	$("#WishFilter").on('click',function(){
		$("#products-div").html('');
		wishList();
	});	
	
	$("#BestFilter").on('click',function(){
		$("#products-div").html('');
		bestSeller();
	})
	$("#NoFilter").on('click',function(){
		$("#products-div").html('');
		wishList();
		bestSeller();
	})
})

function wishList(){
	$.ajax({
		url : '${path}/firstpage/wishList.do',
		type:'get',
		success:function(data){
			var d = '';
			var dataLeng = Object.keys(data).length;	
			$.each(data,function(key,value){
				d+='<div class="col-lg-3 col-md-6 special-grid top-wish">';
				d+='<div class="products-single fix">';
				d+='<div class="box-img-hover">';
				d+='<div class="type-lb"><p class="sale">Sale</p></div>';
				d+='<img src="${path}/resources/upload/product/'+value.productImg+'" class="img-fluid" alt="Image">';			
				d+='</div>';
				d+='<div class="why-text">';
				d+='<a href="${path }/shop/shopDetail.do?no='+value.productNo+'"><h4>'+value.productName+'</h4></a>';
				d+='<h5> '+value.price+'</h5>';
				d+='</div></div></div>';
			})
			$("#products-div").append(d);
		}
	})
}

function bestSeller(){
	$.ajax({
		url : "${path }/firstpage/bestSeller.do",
		type:'get',
		success:function(data){
			var d='';
			var dataLeg = Object.keys(data).length;
			$.each(data,function(key,value){
				d+='<div class="col-lg-3 col-md-6 special-grid best-seller">';
				d+='<div class="products-single fix">';
				d+='<div class="box-img-hover">';
				d+='<div class="type-lb"><p class="sale">Sale</p></div>';
				d+='<img src="${path}/resources/upload/product/'+value.productImg+'" class="img-fluid" alt="Image">';			
				d+='</div>';
				d+='<div class="why-text">';
				d+='<a href="${path }/shop/shopDetail.do?no='+value.productNo+'"><h4>'+value.productName+'</h4></a>';
				d+='<h5> '+value.price+'</h5>';
				d+='</div></div></div>';				
			})
			$("#products-div").append(d);
		}
	})
}

$(function(){
	console.log("시작");
	function makeMonth(num){
		var nowDate=new Date();
		console.log(nowDate.getFullYear());
		console.log(nowDate.getMonth()+1);
		console.log(nowDate.getDate());
		var nowMonth=nowDate.getMonth()+1
		var calMonth=nowMonth-num;
		console.log(calMonth);
	}
	makeMonth(2);
})


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		