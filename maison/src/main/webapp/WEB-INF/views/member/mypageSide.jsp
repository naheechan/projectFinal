<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
				<div class="sidebar">
					<hr/>
					
					<h3 style="text-align:center;">카테고리</h3>
					<hr/>
           			<div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
		            	<div class="list-group-collapse sub-men ">
		                	<a class="list-group-item list-group-item-action" href="#sub-men1" data-toggle="collapse" aria-expanded="false" aria-controls="sub-men1">
		                	<h4>주문관리</h4>
								<small class="text-muted"></small>
							</a>
		                    <div class="collapse" id="sub-men1" data-parent="#list-group-men">
		                    	<div class="list-group">
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>주문/배송 조회 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        </div>
		                     </div>
		                </div>
		            	<div class="list-group-collapse sub-men">
		                	<a class="list-group-item list-group-item-action" href="#sub-men2" data-toggle="collapse" aria-expanded="false" aria-controls="sub-men2">
		                	<h4>쇼핑통장관리</h4>
								<small class="text-muted"></small>
							</a>
		                    <div class="collapse" id="sub-men2" data-parent="#list-group-men">
		                    	<div class="list-group">
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>적립금 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        </div>
		                     </div>
		                </div>
		            	<div class="list-group-collapse sub-men">
		                	<a class="list-group-item list-group-item-action" href="#sub-men3" data-toggle="collapse" aria-expanded="false" aria-controls="sub-men3">
		                	<h4>활동관리</h4>
								<small class="text-muted"></small>
							</a>
		                    <div class="collapse" id="sub-men3" data-parent="#list-group-men">
		                    	<div class="list-group">
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>리뷰관리 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>질문관리 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>		
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>함께해요 관리 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>                        	
		                        </div>
		                     </div>
		                </div>		
		            	<div class="list-group-collapse sub-men">
		                	<a class="list-group-item list-group-item-action" href="#sub-men4" data-toggle="collapse" aria-expanded="false" aria-controls="sub-men4">
		                	<h4>정보관리</h4>
								<small class="text-muted"></small>
							</a>
		                    <div class="collapse" id="sub-men4" data-parent="#list-group-men">
		                    	<div class="list-group">
		                    	<!-- memberPw가 null인지 아닌지 즉, 소셜로그인을 했는지 아니면 일반 로그인을 했느지. -->
		                    		<c:choose>
		                    			<c:when test="${empty loginMember.memberPw }">
				                        	<a href="${path }/member/updateNaver.do" class="list-group-item list-group-item-action">
				                        		<h4>회원정보 변경 </h4>
				                        		<small class="text-muted"></small>
				                        	</a>		                    			
		                    			</c:when>
		                    			<c:otherwise>
				                        	<a href="${path }/member/update.do" class="list-group-item list-group-item-action">
				                        		<h4>회원정보 변경 </h4>
				                        		<small class="text-muted"></small>
				                        	</a>    			
		                    			</c:otherwise>
		                    		</c:choose>
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>비밀번호 변경 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>	
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>배송지/환불계좌 관리 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>결제수단 관리 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>이메일 수신 동의 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>
		                        	<a href="#" class="list-group-item list-group-item-action">
		                        		<h4>회원탈퇴 </h4>
		                        		<small class="text-muted"></small>
		                        	</a>		                        			                        			                        			                        		                        	
		                        </div>
		                     </div>
		                </div>		             			
					</div>
				</div>	