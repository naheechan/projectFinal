<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%@ page import="com.kh.maison.common.crypto.AES256Util,com.kh.maison.member.model.vo.Member" %>
<!-- loginMember의 값들은 암호화가 된채로 넘어온다. 그러므로 aes와 session값을 가지고 decrypt처리해준다. -->
<%
	AES256Util aes = new AES256Util();
	Member m = (Member)session.getAttribute("loginMember");
	String dZipcode = aes.decrypt(m.getZipcode());
	String dPhone = aes.decrypt(m.getPhone());
	String dAddress=aes.decrypt(m.getAddress());
	String dDetailAddress=aes.decrypt(m.getDetailAddress());
%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="결제"/>
</jsp:include>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<!-- Start With -->
<section>
	


    <!-- Start Cart  -->
    <div class="cart-box-main">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-lg-6 mb-3">
                    <div class="checkout-address">
                        <div class="title-left">
                            <h3>주문자&배송지</h3>
                        </div>
                        
                       
                        	
		                  <form id="orderFrm" name="orderFrm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">수령인 *</label>
                                    <input type="text" class="form-control" id="firstName" name="receiver" value="${loginMember.memberName }" placeholder="" required>
                                    <div class="invalid-feedback"> Valid first name is required. </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">핸드폰번호 *</label>
                                    <input type="text" class="form-control" id="firstName" name="orPhone" value="<%=dPhone %>" placeholder="'-'없이 번호만 입력하세요" required>
                                    <div class="invalid-feedback"> Valid first name is required. </div>
                                </div>
                                
                            </div>
                            <div class="mb-3">
                                <label for="username">회원아이디 *</label>
                                <div class="input-group">
                                	
                                    		<input type="text" class="form-control" name="memberId" id="username" placeholder="" value="${loginMember.memberId }" readonly>
                                    	
                                    <div class="invalid-feedback" style="width: 100%;"> Your username is required. </div>
                                </div>
                            </div>
                            
                            
                            
                             <div class="mb-3">
                                <label for="address">우편번호 *</label>
                                <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i></button>
                                <input type="text" class="form-control" id="orZipcode" value="<%=dZipcode %>" name="orZipcode" placeholder="우편번호" required>
                                
                            </div>
                            <div class="mb-3">
                                <label for="address">주소 *</label>
                                <input type="text" class="form-control" name="orAddress" id="orAddress" value="<%=dAddress %>" placeholder="도로명주소" required>
                                <div class="invalid-feedback"> Please enter your shipping address. </div>
                            </div>
                            <div class="mb-3">
                                <label for="address2">상세주소 *</label>
                                <input type="text" class="form-control" name="orDetailAddress" value="<%=dDetailAddress %>" id="orDetailAddress" placeholder=""> 
                            </div>
                            <div class="mb-3">
                                <label for="address2">구매 요청사항 *</label>
                                <input type="text" class="form-control" name="sellRequest" id="sellRequest" placeholder=""> 
                            </div>
                             <div class="mb-3">
                                <label for="address2">배송 시 요청사항 *</label>
                                <select class="form-control" name="deliRequest">
                                	<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
                                	<option value="배송 전 미리 연락주세요.">배송 전 미리 연락주세요</option>
                                	
                                </select>

                            </div>
                            
                            <script>
                            function execPostCode() {
                                new daum.Postcode({
                                    oncomplete: function(data) {
                                       // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                        
                                       // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                                       // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                                       var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                                       var extraRoadAddr = ''; // 도로명 조합형 주소 변수
                        
                                       // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                                       // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                           extraRoadAddr += data.bname;
                                       }
                                       // 건물명이 있고, 공동주택일 경우 추가한다.
                                       if(data.buildingName !== '' && data.apartment === 'Y'){
                                          extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                       }
                                       // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                                       if(extraRoadAddr !== ''){
                                           extraRoadAddr = ' (' + extraRoadAddr + ')';
                                       }
                                       // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                                       if(fullRoadAddr !== ''){
                                           fullRoadAddr += extraRoadAddr;
                                       }
                        
                                       // 우편번호와 주소 정보를 해당 필드에 넣는다.
                                       console.log(data.zonecode);
                                       console.log(fullRoadAddr);
                                       
                                       
                                       $("[name=orZipcode]").val(data.zonecode);
                                       $("[name=orAddress]").val(fullRoadAddr);
                                       
                                       /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                                       document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
                                       document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
                                   }
                                }).open();
                            }
                            </script>
                           
                           
                    </div>
                </div>
                <div class="col-sm-6 col-lg-6 mb-3">
                    <div class="row">
                        <div class="col-md-12 col-lg-12">
                            <div class="shipping-method-box">
                                <div class="title-left">
                                    <h3>배송방법</h3>
                                </div>
                                <div class="mb-4">
                                    <div class="custom-control custom-radio">
                                        <input id="shippingOption1" name="shipping-option" class="custom-control-input" checked="checked" type="radio">
                                        <label class="custom-control-label" for="shippingOption1">기본배송</label> <span class="float-right font-weight-bold">FREE</span> </div>
                                    <div class="ml-4 mb-2 small">(2-3일 소요 )</div>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12">
                            <div class="odr-box">
                                <div class="title-left">
                                   <h3>주문상품</h3>
                                </div>
                                
                               	<table class="table">
                          			<tr>
                          				<th>상품명</th>
                          				<th>수량</th>
                          				<th>가격</th>
                          			</tr>
                       				
                           			<tr>
                           				<td>${product.productName }</td>
                           				<td>${amount }</td>
                           				<td>${amount*product.price } 원</td>
                           			</tr>
                           		</table>
                           			<input type="hidden" name="amount" value="${amount }">
                           			<input type="hidden" name="productName" value="${product.productName }">
                           			<input type="hidden" name="productNo" value="${product.productNo }"
                                   			
                                
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-12">
                            <div class="order-box">
                                <div class="title-left">
                                    <h3>결제정보</h3>
                                </div>
                               
                                <hr class="my-1">
                                <div class="d-flex">
                                    <div class="font-weight-bold">주문상품</div>
                                    
                                   
                                    <div class="ml-auto font-weight-bold"> <label id="sumPrice">${amount*product.price }</label> 원</div>
                                    <input type="hidden" name="orderPrice" value="${amount*product.price }">
                                    <c:set var="sum" value="${amount*product.price }"/>
                                </div>
                                <!-- <div class="d-flex">
                                    <h4>Discount</h4>
                                    <div class="ml-auto font-weight-bold"> $ 40 </div>
                                </div> -->
                                <hr class="my-1">
                                
                                <div class="d-flex">
                                    <div class="font-weight-bold">보유 마일리지</div>
                                    <div class="ml-auto font-weight-bold">
                                    	<c:out value="${loginMember.meileage }"/>
                                    	<input type="hidden" name="mileage" value="${loginMember.meileage }" id="mileage">
	                                    
                                    </div>
                                    
                                </div>
                                <div class="d-flex">
                                    <div class="font-weight-bold">사용 마일리지</div>
                                    <div class="ml-auto font-weight-bold">
                                    	<input type="text" id="useMile" name="useMile" value="">
                                    	<button type="button" id="result">적용</button>
	                                    
                                    </div>
                                    
                                </div>
                                    

                                    
                                    
                               
                                <div class="d-flex">
                                    <div class="font-weight-bold">배달료</div>
                                    <div class="ml-auto font-weight-bold"> 0 </div>
                                </div>
                                
                                <hr>
                                <div class="d-flex">
                                    <div class="font-weight-bold">적립 마일리지</div>
                                    <div class="ml-auto font-weight-bold"> <fmt:parseNumber integerOnly="true" value="${sum/10 }"/>원 예정 </div>
                                    <input type="hidden" name="stackMile" value="<fmt:parseNumber integerOnly="true" value="${sum/10 }"/>">
                                </div>
                                
                                <div class="d-flex gr-total">
                                    <h5>총 주문금액</h5>
                                    <div class="ml-auto h5"><input type="text" name="totalPrice" id="totalPrice" value="" style="border:none; text-align: right;" readonly> 원 </div>
                        			
                                    
                                </div>
                                <hr> 
                                </div>
                        </div>
                        	
                        	
                        	
                        </form>
                        <button type="button" id="checkout" class="ml-auto btn hvr-hover" style="float: right;">주문하기</button>
                        
     
                        	
                        	
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- End Cart -->
</section>

<script>
	
	/* $(function(){
		var nowMeil=$("#nowMeil").val();
		var useMeil=$("#useMeil").val();
		//마일리지 전액사용	
		$("#allMeil").click(function(){
			$("#useMeil").val(nowMeil);
			
		})
	}) */
	
	 $("#result").click(function(){
		var price=Number($("#sumPrice").html());
		var useMile=Number($("#useMile").val());
		var mileage=Number($("#mileage").val());
		
		if(useMile>mileage){
			alert("보유중인 마일리지를 초과합니다.");
			$("#useMile").val("");
		}else{
			if(useMile>price*0.05){
				alert("마일리지 최대 사용액수는 상품구매가격의 5%입니다.");
				$("#useMile").val("");
			}else{
				
			var totalPrice=price-useMile;
			$("#totalPrice").val(totalPrice);
			console.log(totalPrice);
			}
			
		}
		
	}); 
	
	$(document).on('click',"#checkout",function(){
		
   	 	 var IMP = window.IMP; // 생략가능
        IMP.init('imp09698115'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'KH Books 도서 결제',
            amount : 2,
            buyer_email : '123@123',
            buyer_name : '이성준',
            buyer_tel : '01054523781',
            buyer_addr : '의정부',
            buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                var orderData=$("[name='orderFrm']").serialize();
                orderInsert(orderData);
                
                alert("결제성공");
                jQuery.ajax({
                    url: "https://www.myservice.com/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                   	
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                location.href='${path}/';
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="${path}/order/buy.do"; 
                alert(msg);
            }
        });  
   	
   });
 
	function orderInsert(orderData){
		$.ajax({
			url:'${path}/order/buyInsert.do',
			type:'post',
			data:orderData,
			success : function(data){
				if(data==1){
					console.log('SUCCESS');
					alert("결제성공");
				}else{
					alert("결제실패");
				}
			}
		})
	}

			
			
		

		
		
	
	

</script>



    


    



<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		