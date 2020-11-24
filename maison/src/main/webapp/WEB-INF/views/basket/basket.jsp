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

                            <script>
                            //전체체크/전체해제
								function allChecked(){
									var checked=$("#allCheck").prop("checked")
									console.log(checked);
									console.log($("input:checkbox[name=basketChecked]").prop("checked"));
									if(checked==true){
										$("input:checkbox[name=basketChecked]").prop("checked",true);
									}if(checked==false){
										$("input:checkbox[name=basketChecked]").prop("checked",false);
									}
								};
							
								
								
								
							</script>
<!-- Start With -->
<section>
<div class="cart-box-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-main table-responsive">
                    <form action="#" >
                        <table class="table">
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
                            <tbody>
                            <c:forEach var="list" items="${list }">
                                <tr>
                                	<td><input type="checkbox" name="basketChecked" value="${list.BASKETNO }" checked></td>
                                    <td class="thumbnail-img">
                                        <a href="#">
									<img class="" src='${list.PRODUCTIMG }' height="100px" alt="" />
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
                                    <td class="quantity-box"><input type="number" name="amount" size="4" value="${list.AMOUNT }" min="0" step="1" class="c-input-text qty text"></td>
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
                                <script>
                                
                                $("input[name=amount]").change(function(){
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
                                
	                                $(function(){ 
	                                	var p=$(".pTotal");
	                                	var prtotal=0;
	                                	$(".pTotal").each(function(){
	                                		var val=$(this).prop("innerHTML");
	                                		
	                                		var val2=Number((val.substring(0,val.length-1)).trim());
	                                		prtotal+=val2;
	                                	})
	                              	
	                                	console.log(prtotal);
	                                	$(".subTotal").html(prtotal+"원");
										
	                                	$(".grandTotal").html(prtotal+"원");
	                                	
	                                }); 
                                
                                </script>
                                <!-- <tr>
                                	<td><input type="checkbox" name="basketChecked" value="장바구니번호" checked></td>
                                    <td class="thumbnail-img">
                                        <a href="#">
									<img class="img-fluid" src="images/img-pro-03.jpg" alt="" />
								</a>
                                    </td>
                                    <td class="name-pr">
                                        <a href="#">
									Lorem ipsum dolor sit amet
								</a>
                                    </td>
                                    <td class="price-pr">
                                        <p>$ 30.0</p>
                                    </td>
                                    <td class="quantity-box"><input type="number" size="4" value="1" min="0" step="1" class="c-input-text qty text"></td>
                                    <td class="total-pr">
                                        <p>$ 80.0</p>
                                    </td>
                                    <td class="remove-pr">
                                        <a href="#">
									<i class="fas fa-times"></i>
								</a>
                                    </td>
                                </tr> -->
                            </tbody>
                        </table>
                       
                    </div>
                </div>
            </div>

            <div class="row my-5">
                <div class="col-lg-11 col-sm-11">
                   <!--  <div class="coupon-box">
                        <div class="input-group input-group-sm">
                            <input class="form-control" placeholder="Enter your coupon code" aria-label="Coupon code" type="text">
                            <div class="input-group-append">
                                <button class="btn btn-theme" type="button">Apply Coupon</button>
                            </div>
                        </div>
                    </div> -->
                </div>
                <div class="col-lg-1 col-sm-1">
                    <div class="update-box">
                        <input class="btn btn-sm" value="쇼핑 계속하기" type="button">
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
                            <div class="ml-auto font-weight-bold subTotal"> $ 130 </div>
                        </div>
                        <div class="d-flex">
                            <h4>총 할인금액</h4>
                            <div class="ml-auto font-weight-bold discount"> $ 40 </div>
                        </div>
                        <hr class="my-1">
                        
                        <div class="d-flex">
                            <h4>배송비</h4>
                            <div class="ml-auto font-weight-bold"> 무료 </div>
                        </div>
                        <hr>
                        <div class="d-flex gr-total">
                            <h5>결제예정 금액</h5>
                            <div class="ml-auto h5 grandTotal"> $ 388 </div>
                        </div>
                        <hr> </div>
                </div>
                <div class="col-12 d-flex shopping-box"><a href="#" class="ml-auto btn hvr-hover">전체 상품 주문</a> </div>
            </div>

        </div>
    </div>
    <!-- End Cart -->

</section>

<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		