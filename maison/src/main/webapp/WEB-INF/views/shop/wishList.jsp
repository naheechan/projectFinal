<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="위시리스트"/>
</jsp:include>

	
	<!-- Start Wishlist  -->
    <div class="wishlist-box-main">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-main table-responsive">
                        <table class="table" style="text-align:center;">
                            <thead>
                                <tr>
                                	<th>상품번호</th>
                                    <th>Images</th>
                                    <th>Product Name</th>
                                    <th>가격</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                            	
	                               <c:forEach items="${list }" var="w">
		                                <tr>
		                                
		                                	<td class="add-pr">
		                                        <p>${w.PRODUCTNO }</p>
		                                    </td>
		                                    <td class="thumbnail-img">
		                                        <a href="#">
													<img class="img-fluid" src="${path }/resources/upload/product/${w.PRODUCTIMG }" alt="" />
												</a>
		                                    </td>
	
		                                    
		                                    <td class="name-pr">
		                                        <a href="${path }/shop/shopView.do?no=${w.PRODUCTNO}">
													${w.PRODUCTNAME }
												</a>
		                                    </td>
		                                    
		                                    <td class="price-pr">
		                                        <p><fmt:formatNumber type="currency" value="${w.PRICE }"/></p>
		                                    </td>
		                                    <td class="remove-pr">
		                                       <%--  <button onclick="deleteWishList(${w.PRODUCTNO });">
													<i class="fas fa-times"></i>
												</button> --%>
												<form action="${path }/deleteWishList.do" id="deleteFrm">
													<input type="hidden" value="${w.PRODUCTNO }" name="no">
													<input type="hidden" value="${loginMember.memberId }" name="id">
													
 												</form>
 												
 												<button id="deleteBtn" onclick="deleteWishList();">
													<i class="fas fa-times"></i>
												</button>
		                                    </td>
		                                </tr>
	                               </c:forEach>
	                        	<c:if test="${empty list }">
	                        		<tr>
	                        			<td colspan="5">나만의 위시리스트를 추가해보세요.
	                        				<a href="${path }/shop/shopList.do" style="text-decoration: underline;color: blue;">쇼핑하러가기</a>
	                        			</td>
	                        		</tr>
	                        	</c:if>
	                        	
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    	
    	 function deleteWishList(){
    		var check=confirm('정말로 삭제하시겠습니까?');
    		
    		 if(check){
    			$("#deleteFrm").submit();
    			
    		} 
    		
    	} 
    </script>
    <!-- End Wishlist -->
	


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		