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
	                <h1>자동 주기 계산</h1>
	                <p>각 상품별로 자동 주기 계산 기능을 On 또는 Off하실 수 있습니다.</p>					
				</div>
			</div>
		</div>
		<div class="row my-5">
		    <div class="col-sm-6 col-lg-6">
		        <div class="service-block-inner">
		            <h3>On</h3>
		            <p>상품 구매이력이 1회일 경우 메종팀에서 1인 당사자 기준으로 알고리즘을 적용해 도출한 주기가 적용되며, 2회 이상일 경우 실제로 상품을 구입하신 텀을 계산해서 알려드립니다. </p>
		        </div>
		    </div>
		    <div class="col-sm-6 col-lg-6">
		        <div class="service-block-inner">
		            <h3>Off</h3>
		            <p>메종에서의 구매이력과 무관하게 평소 구매 패턴을 고려하시어 주기를 자유롭게 커스텀하실 수 있습니다. </p>
		        </div>
		    </div>
		</div>
	</div>
</div>
<!-- Start Contact Us -->
    <div class="contact-box-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-sm-12">
                    <div class="contact-form-right">
                        <h2>문의하기</h2>
                        <p>메종의 소개 페이지를 읽으시고 더 알고 싶으신 사항이 있으시면 메종으로 이메일을 보내주세요.</p>
                        <form action="${path }/firstpage/emailSend.do" method="post">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="name" name="nickname" placeholder="닉네임" required data-error="닉네임을 입력해주세요.">
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" placeholder="답변 받으실 이메일" id="email" class="form-control" name="email" required data-error="이메일을 입력해주세요.">
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="subject" name="title" placeholder="이메일 제목" required data-error="제목을 입력해주세요.">
                                        <div class="help-block with-errors"></div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <textarea class="form-control" id="message" placeholder="이메일 내용" name="content" rows="4" data-error="이메일 내용을 입력해주세요." required></textarea>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    <div class="submit-button text-center">
                                        <button class="btn hvr-hover" id="submit" type="submit">이메일로 문의하기</button>
                                        <div id="msgSubmit" class="h3 text-center hidden"></div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
				<div class="col-lg-4 col-sm-12">
                    <div class="contact-info-left">
                        <h2>메종팀 연락처</h2>
                        <p>메종은 여러분의 소중한 의견을 기다립니다! <br/> 아래 연락처로 메종을 이용하시면서 불편한 점, 개선점 등을 알려주시면 최대한 반영하여 불편함 없는 서비스를 제공할 수 있도록 노력하겠습니다.<br/>감사합니다. </p>
                        <ul>
                            <li>
                                <p id="adminAddr"></p>
                            </li>
                            <li>
                                <p id="adminPhone"></p>
                            </li>
                            <li>
                                <p id="adminEmail"></p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- End Contact Us -->
<!-- End Maison? -->
<script>
	$(document).ready(function(){
		writeAdmin();
	})
	//ajax로 admin의 데이터를 불러와서 띄워줌. 
	//이렇게 하면 관리자가 본인 회원정보 수정에서 바꿔줘도 자동으로 적용됨. 
	// 개발자와 실제 관리자의 분리가 가능 함. 
	function writeAdmin(){
		$.ajax({
			url : '${path }/firstpage/writeAdmin.do',
			type:'post',
			dataType:"json",
			success:function(data){
				if(data != null){
						var $zipcode = data.zipcode;
						var $addr = data.address;
						var $detailAddr = data.detailAddress;
						var $email = data.email;
						var $phone = data.phone;
						console.log($zipcode);
						console.log($addr);
						console.log($detailAddr);
						console.log($email);
						console.log($phone);
						var e = '';
						e+='<i class="fas fa-map-marker-alt"></i>';
						e+='주소 : '+$zipcode;
						e+='<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+$addr;
						e+='</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+$detailAddr;
						var f = '';
						f+='<i class="fas fa-phone-square"></i>';
						f+='연락처 : <a href="#">+82 '+phoneFomatter($phone)+'</a>';
						var g = '';	
						g+='<i class="fas fa-envelope"></i>';
						g+='이메일 : ';
						g+='<a href="#">'+$email+'</a>';
				}	
				$("#adminAddr").append(e);
				$("#adminPhone").append(f);
				$("#adminEmail").append(g);
			}
		})
	}
	//01011111111 형식으로 되어 있는 전화번호를 010-1111-1111로 바꿔주는 함수
	  function phoneFomatter(num,type){
		    var formatNum = '';
		    if(num.length==11){
		        if(type==0){
		            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
		        }else{
		            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		        }
		    }else if(num.length==8){
		        formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
		    }else{
		        if(num.indexOf('02')==0){
		            if(type==0){
		                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
		            }else{
		                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
		            }
		        }else{
		            if(type==0){
		                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
		            }else{
		                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
		            }
		        }
		    }
		    return formatNum;
		}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		