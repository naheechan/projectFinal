<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>


<c:forEach var="list" items="${list }">
	<tr>
		<td><input type="checkbox" name="basketChecked"
			value="${list.BASKETNO }" checked></td>
		<td class="thumbnail-img"><a href="#"> <img class=""
				src='${list.PRODUCTIMG }' height="100px" alt="" />
		</a></td>
		<td class="name-pr"><a href="#"> ${list.PRODUCTNAME } </a></td>
		<td class="price-pr">${list.PRICE }원</td>
		<td class="quantity-box"><input type="number" name="amount"
			size="4" value="${list.AMOUNT }" min="0" step="1"
			class="c-input-text qty text"> <input type="hidden"
			name="basketNoa" value="${list.BASKETNO }"></td>

		<td class="total-pr">
			<p class="pTotal">${list.PRICE*list.AMOUNT }원</p>
		</td>
		<td class="remove-pr">
		<a href="${path }/basket/deleteBasket.do?basketNo=${list.BASKETNO}">
				<i class="fas fa-times"></i>
		</a></td>
	</tr>
</c:forEach>

<!-- <script>
$(function(){
	
	$("input[name=amount]").bind('keyup mouseup',function(e){
		
		//수량변경된 배스킷번호랑 수량을 받아와야함
		var amount=$(this).val();
		var basketNo=$(this).next().val();
		
		console.log(basketNo+" : "+amount);
		
		//그 받아온 값을 넘겨줘서 업데이트 후 다시 배스킷정보를 받아와야함
		 	$.ajax({
    		
    		url: "${path}/basket/upDown.do",
    		data : {
	    			basketNo:basketNo,
	    			amount : amount
    				},
    		dataType : "html",
    		//받아온 배스킷 정보를 다시 테이블에 쏴줌
    		success : data=>{
    			var $tableBody=$("#basketTable tbody");
    			$("#basketTbody").html("");
    			$("#basketTbody").html(data);
    		},
    		error : function(){
    			
    		}
    		
    	});
	})
		</script> -->
