<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="장바구니"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="장바구니"/>
</jsp:include>
<script src="${path }/resources/js/basket.js"></script>
                      
<!-- Start With -->
<section>
<div class="cart-box-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-main table-responsive">
                    <form action="${path }/basket/orderBasket" id="basketFrm" method="post">
                        <table id="basketTable" class="table">
                            <thead>
                                <tr>
                                	<th style="width:3%"><input type="checkbox" id="allCheck" onclick="allChecked();"></th>
                                    <th style="width:22%">사진</th>
                                    <th style="width:36%">상품 명</th>
                                    <th style="width:15%">판매가</th>
                                    <th style="width:10%">수량</th>
                                    <th style="width:15%">합계</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody id="basketTbody">
                            <c:if test="${list ne null }">
                            <c:forEach var="list" items="${list }">
                                <tr>
                                	<td><input type="checkbox" name="basketChecked" value="${list.BASKETNO }" checked></td>
                                	
                                    <td class="thumbnail-img">
                                        <a href="#">
									<img class="" src='${path }/resources/images/upload/product/${list.PRODUCTIMG }' height="100px" alt="상품 이미지" />
										</a>
                                    </td>
                                    
                                    <td class="name-pr">
                                        <a href="#">
											${list.PRODUCTNAME }
										</a>
                                    </td>
                                    
                                    <td class="price-pr">
                                       ${list.PRICE }원
                                    </td>
                                    
                                    <td class="quantity-box">
                                    	<input type="number" name="amount" size="4" value="${list.AMOUNT }" min="0" step="1" class="c-input-text qty text">
                                    	<input type="hidden" name="basketNo" value="${list.BASKETNO }">			
                                    </td>
                                    
                                    <td class="total-pr">
                                        <p class="pTotal"> ${list.PRICE*list.AMOUNT }원</p>
                                    </td>
                                    
                                    <td class="remove-pr">
                                        <a href="${path }/basket/deleteBasket.do?basketNo=${list.BASKETNO}">
											<i class="fas fa-times"></i>
										</a>
                                    </td>
                                    
                                </tr>
                               </c:forEach>
                         
                             </c:if>
                             <c:if test="${empty list }">
                             	<tr>
                             	<td colspan="7" style="text-align : center">
                             		장바구니가 비어 있습니다.
                             	</td>
                             	</tr>
                             </c:if>
                                
                            </tbody>
                        </table>
                       </form>
                    </div>
                </div>
            </div>

            <div class="row my-5">
                <div class="col-lg-11 col-sm-11">
                  
                </div>
                <div class="col-lg-1 col-sm-1">
                    <div class="update-box">
                        <input class="btn btn-sm" id="continueBtn" value="쇼핑 계속하기" type="button">
                    </div>
                </div>
            </div>
            

            <div class="row my-5">
                <div class="col-lg-8 col-sm-12"></div>
                <div class="col-lg-4 col-sm-12">
                    <div class="order-box">
                        <!-- <h3>Order summary</h3> -->
                        <div class="d-flex">
                            <h4>총 상품금액</h4>
                            <div class="ml-auto font-weight-bold subTotal"></div>
                        </div>
                        <div class="d-flex">
                            <h4>총 할인금액</h4>
                            <div class="ml-auto font-weight-bold discount"></div>
                        </div>
                        <hr class="my-1">
                        
                        <div class="d-flex">
                            <h4>배송비</h4>
                            <div class="ml-auto font-weight-bold"> 무료 </div>
                        </div>
                        <hr>
                        <div class="d-flex gr-total">
                            <h5>결제예정 금액</h5>
                            <div class="ml-auto h5 grandTotal"></div>
                        </div>
                        <hr> </div>
                </div>
                <div class="col-12 d-flex shopping-box"><input type="button" id="orderbtn" style="color:white" class="ml-auto btn hvr-hover" value="전체 상품 주문"> </div>
            </div>

        </div>
    </div>
    <!-- End Cart -->

</section>
<script>
$(function(){
	
	
	
	$("#orderbtn").on('click',function(e){
		$("#basketFrm").submit();
	});
	
	$("#continueBtn").on('click',function(e){
		//
		location.href="${path}/";
	});
	
	
	$("input[name=amount]").on('change',function(e){
		
		 //수량변경된 배스킷번호랑 수량을 받아와야함
		var amount=$(this).val();
		var basketNo=$(this).next().val();
		
		console.log(basketNo+" : "+amount);
		
		//그 받아온 값을 넘겨줘서 업데이트 후 다시 배스킷정보를 받아와야함
		 	$.ajax({
    		
    		url: "${path}/basket/upDown.do",
    		cache: false,
    		data : {
	    			basketNo:basketNo,
	    			amount : amount
    				},
    		dataType : "html",
    		//받아온 배스킷 정보를 다시 테이블에 쏴줌
    		success : function(data){
    			var $tableBody=$("#basketTable tbody");
    			$("#basketTbody").html("");
    			$("#basketTbody").html(data);
    			
    			//가격 합계를 다시 계산해줌
    			var prtotal=0;
    			$(".pTotal").each(function(){
    				var val=$(this).prop("innerHTML");
    				
    				var val2=Number((val.substring(0,val.length-1)).trim());
    				console.log(val2);
    				prtotal+=val2;
    			})
    			$(".subTotal").html(prtotal+"원");
    			
    			$(".grandTotal").html(prtotal+"원");
    		},
    		error:function(request,status,error){
    	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	       }

    		
    	});
		
	});
	
	$("#basketTbody").on('change',function(e){
		
			//배스킷 다시 불러온 후 합계 다시 정산하는 것
			var p=$(".pTotal");
			var prtotal=0;
			$(".pTotal").each(function(){
				var val=$(this).prop("innerHTML");
				
				var val2=Number((val.substring(0,val.length-1)).trim());
				prtotal+=val2;
			})
			$(".subTotal").html(prtotal+"원");
			
			$(".grandTotal").html(prtotal+"원");
		
		});
	
})


</script>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		