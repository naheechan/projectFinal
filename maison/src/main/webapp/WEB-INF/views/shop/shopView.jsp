<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="쇼핑해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="쇼핑해요"/>
</jsp:include>

<!-- Start -->
<div class="shop-list-box">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 col-lg-5 col-md-6"></div>
		</div>
	</div>
</div>
<!-- End -->

<!-- ShopMainStart -->
<div class="shop-box-inner">
        <div class="container">
            <div class="row">
            <c:if test="${product != null}">
                <div class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right">
                    <div class="right-product-box">
                        <div class="product-item-filter row">
                            <div class="col-12 col-sm-8 text-center text-sm-left">
                                <div class="toolbar-sorter-right">
                                    <span>Sort by </span>
                                    <select id="basic" class="selectpicker show-tick form-control" data-placeholder="$ USD">
									<option data-display="Select">Nothing</option>
									<option value="1">Popularity</option>
									<option value="2">High Price → High Price</option>
									<option value="3">Low Price → High Price</option>
									<option value="4">Best Selling</option>
								</select>
                                </div>
                                <p>Showing all ${count} results</p>
                            </div>
                            <div class="col-12 col-sm-4 text-center text-sm-right">
                                <ul class="nav nav-tabs ml-auto">
                                    <li>
                                        <a class="nav-link active" href="#grid-view" data-toggle="tab"> <i class="fa fa-th"></i> </a>
                                    </li>
                                    <li>
                                        <a class="nav-link" href="#list-view" data-toggle="tab"> <i class="fa fa-list-ul"></i> </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
		<!-- 상품 -->
                 <div class="product-categorie-box">
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade show active" id="grid-view">
                                    <div class="row" id="divResult">
                                    
                                    <c:forEach var="list" items="${product}" varStatus="i">
                                        <div class="col-sm-6 col-md-6 col-lg-4 col-xl-4">
                                            <div class="products-single fix">
                                                <div class="box-img-hover">
                                                    <div class="type-lb">
                                                        <p class="sale">NEW</p><!-- 일주일 지나면 buy now! -->
                                                    </div>
                                                    <img src="${ path }/resources/upload/product/${list.productImg}" class="img-fluid" alt="Image">
                                                    <div class="mask-icon">
                                                        <ul>
                                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Compare"><i class="fas fa-sync-alt"></i></a></li>
                                                            <li><a href="#" data-toggle="tooltip" data-placement="right" title="Add to Wishlist"><i class="far fa-heart"></i></a></li>
                                                        </ul>
                                                        <a class="cart" href="#">Add to Cart</a>
                                                    </div>
                                                </div>
                                                <div class="why-text">
                                                    <h4><a href="${ path }/shop/shop-detail.html">${list.productName}</a></h4><br>
                                                    <h5><c:out value="${list.price}">${list.price}</c:out>원</h5>
                                                </div>
                                            </div>
                                        </div>
                                        </c:forEach>
                                     </div>
                                  </div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:if><!-- product가 null이 아니면 -->
                

                <!-- 요청해요 -->
		<div id="request-container" style="margin:0 10% 0 7%;"></div>
                <!-- 카테고리 -->
				<div class="col-xl-3 col-lg-3 col-sm-12 col-xs-12 sidebar-shop-left">
                    <div class="product-categori">
                        <div class="search-product">
                            <form action="" method="post">
                                <input class="form-control" id="autocomplete" name="value" placeholder="Search here..." type="text" list="list">
                                <datalist id="list"></datalist>
                                <button type="button" name="search" id="search"> <i class="fa fa-search"></i> </button>
                            </form>
                        </div>
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Categories</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                            	<c:forEach var="largeCate" items="${category }" varStatus="i">                  
                                <div class="list-group-collapse sub-men">
                                    <a class="list-group-item list-group-item-action" href="#sub-men${i.index }" data-toggle="collapse" aria-expanded="true" aria-controls="sub-men${i.index }">
                                  
                                    	${ largeCate.largeCate }
								</a>
                                   
                                    <div class="collapse <c:if test='${i.index eq 0}'>show</c:if> " id="sub-men${i.index }" data-parent="#list-group-men">
                                    <div class="list-group">
                                    <c:forEach var="mc" items="${ medicate }" varStatus="j">
                                    
                                      
                                    <c:if test="${ i.current.largeCate  eq j.current.largeCate }">
                                        <a href="#" class="list-group-item list-group-item-action<c:if test='${i.index eq 0}'>active</c:if> ">${ mc.mcName }</a>
                                     </c:if>
                                     </c:forEach>
                                    </div>
                                     </div>
                                </div>
                                 </c:forEach>
                        <div class="filter-price-left">
                            <div class="title-left">
                                <h3>Price</h3>
                            </div>
                            <div class="price-box-slider">
                                <div id="slider-range"></div>
                                <p>
                                    <input type="text" id="amount" readonly style="border:0; color:#fbb714; font-weight:bold;">
                                    <button class="btn hvr-hover" type="submit">Filter</button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
   </div>
   
    <div id="pageBar">
    	${pageBar }
    </div>
   </div>
   
    <script>
    	$(function(){
			
    		//keyword ajax 성공
    		$("button[name=search]").click(function(){
					var keyword = $("#autocomplete").val();
				$.ajax({
					url:"${path}/shop/search.do",
					data:{keyword:keyword},
// 					type:"get",
					dataType:"json",
					success:function(data){
						var html = '';
						var divResult = $("#divResult");
						var requestContainer = $("#request-container");
						var obj = Object.keys(data).length;
						divResult.empty();
						console.log("ajax통신성공"+data);
						
						
						if(obj >0){
						$.each(data,function(i){
			        html = "	<div class='col-sm-6 col-md-6 col-lg-4 col-xl-4'>									"
							+"	<div class='products-single fix' onclick= selectOneProduct("+data[i].productNo +")>"
							+"	<div class='box-img-hover'>																"
							+"	<div class='type-lb'>																		"
							+"	<p class='sale'>NEW</p>																"
							+"	</div>																							"
							+"	<img src='${ path }/resources/upload/product/"+data[i].productImg+"'  "
							+"	class='img-fluid' alt='Image'>															"
							+"	<div class='mask-icon'>																	"
							+"	<ul>																								"
							+"	<li><a href='#' data-toggle='tooltip' data-placement='right'					"
							+"	title='View'><i class='fas fa-eye'></i></a></li>								"
							+"	<li><a href='#' data-toggle='tooltip' data-placement='right'					"
							+"	title='Compare'><i class='fas fa-sync-alt'></i></a></li>					"
							+"	<li><a href='#' data-toggle='tooltip' data-placement='right'					"
							+"	title='Add to Wishlist'><i class='far fa-heart'></i></a></li>				"
							+"	</ul>																							"
							+"	<a class='cart' href='#'>Add to Cart</a>											"
							+"	</div>																							"
							+"	</div>																							"
							+"	<div class='why-text'>																		"
							+"	<h4>																								"
							+"	<a href='${ path }/shop/shop-detail.html'>"+data[i].productName+"</a>	"
							+"	</h4>																							"
							+"	<br>																								"
							+"	<h5>"+data[i].price+"원</h5>															"
							+"	</div>																							"
							+"	</div>																							"
							+"	</div>																							";
			       			 divResult.append(html);
						 });
						}else{
					html = " <form action='${path}/shop/product/requestP.do' method='post'>																					"
							+"<div>																																											"
							+"<h2><strong>💌 요청해요</strong></h2><br><br>																											"
							+"<span><strong>원하시는 상품의 모델명, 품번 등을 자세히 기입하시면 더 신속하게 확인 가능합니다.</strong><br><br>											"
							+" &nbsp;**유의사항**<br>																																				"
					 		+"1. 현재 판매중인 상품관련 문의는 질문해요 게시판에 남겨주세요.<br>																										"
							+"2. 입점불가대상 : 생필품 제외한 모든 상품 &nbsp;																															"
							+"ex)식품, 브랜드 정책상 온라인미판매 상품 등</span>																														"
							+"</div>																																										"
							+"<br>																																											"
							+"<textarea rows='10' cols='80' name='requestContent' id='requestP' placeholder='이런 상품 구해주세요 ' required></textarea>			"
							+"<c:if test='${ loginMember != null}'>																																"
							+"<button type='submit' id='loginReqBtn' class='btn' onclick='location.replace('${path}/shop/product/requestP.do')'>요청</button>"
							+"</c:if> 																																										"
							+"<c:if test='${ loginMember == null }'>																															"
							+"<button type='submit' id='reqBtn' class='btn'>요청</button>																								"
							+"</c:if>																																										"
	                		+"</form>																																										";
	                		requestContainer.append(html);
						}
						/* }); */
					},
					error:function(){
						console.log("ajax통신실패");
					}
				})
				
			});
    		
    		
    		$("#reqBtn").click(function(){
    
    		/* if(${loginMember==null}){
    				alert("로그인 후 이용해주세요");
    			} */
    			
    			
    		});
    		
    		
    	});
    </script>
    <script>
    	function selectOneProduct(productNo){							
    		location.href="url?productNo= "+productNo	//Get방식
    				
    	}
    	
    </script>
    <!-- End Shop Page -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		
<!-- PLUGINS -->
<script src="<%=request.getContextPath() %>/resources/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/jquery.nicescroll.min.js"></script>
