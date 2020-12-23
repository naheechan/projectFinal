<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="질문해요"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="질문해요"/>
</jsp:include>
<script src = "${path}/resources/ckeditor/ckeditor.js"></script>

<div>
	<br>
	<div class="container">
		<div class="col-lg-12">
			<div class="row">
				<form action="${path}/qnaBoard/insertQna.do" id="qnaForm" name="frm" method="post">
					<div class="form-inline form-group" style="margin-top:25px;margin-bottom:25px;" >
				      <label for="phone_num" class="col-sm-0 control-label">제목:</label>
				      <div class="col-sm-11">
				       <input type="text" class="form-control" required id="qnaTitle" name="qnaTitle" style="width:500px;">
				      </div>
		     		</div>
					<input type="hidden"  name="memberId" id="memberId" value="${loginMember.memberId}">
					
					<div style="width:1000px">
						<textarea id = "qnaContent" name = "qnaContent" rows = "40" cols = "100"
						placeholder = "내용을 입력하세요." class="required"></textarea>
						<script>
							CKEDITOR.replace("qnaContent",{
								filebrowserUploadUrl : "${path }/qnaBoard/imageUpload.do"
							});
							$("#qnaForm").submit( function(e) {
					            var messageLength = CKEDITOR.instances['qnaContent'].getData().replace(/<[^>]*>/gi, '').length;
					            if( !messageLength ) {
					                alert( '질문의 내용을 입력해주세요' );
					                e.preventDefault();
					            }
					        });
						</script>
					</div>
					<br>
			</div>
		</div>
		<div class="col-lg-12">
			<div class="row">
				<input type="hidden"  name="qnaSecret" id="qnaSecret" value="open">
				<div class="form-inline form-group" style="margin-bottom:25px;" >
					<label>
						<input type="checkbox" id="qnaSecretchk" name="qnaSecretchk" value="open" class="form-check-input" style="position:relative;top: 2px;">비밀글 설정
					</label>
		     	</div>
				<div class="form-inline form-group" style="margin-bottom:25px;" >	
					<label id="passLabel" style="cursor:pointer;margin-left:10px;" class="col-sm-0 control-label">
					비밀번호 : <input type="password" id="qnaPw" name="qnaPw"maxlength='4' minlength="1" pattern="[0-9]{4,4}$" placeholder="4자리 숫자입력" title="4자리 숫자" style="width:200px;margin-left:10px" class="form-control">&nbsp;<i class="fas fa-eye-slash" id="eye"></i>			
						<input type="text" id="msg" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; width:300px" readonly>
					</label>
				</div>

			<div class="col-lg-12" style="margin-bottom:20px">
			
						<button id="qnaEnroll" class="btn" style="margin-left:900px;background:#FCF7E1">글작성</button>
			
			</div>
	
		</form>
	
		<script>
		$("#qnaEnroll").click(function(){
			if($("#qnaPw").val()==""){
				$("#qnaSecret").val("open");
			}
		})
		$("#passLabel").hide();
		var pwChk=/^[0-9]{4,4}$/;
		$("#qnaPw").keyup(function(){

			if(pwChk.test($("#qnaPw").val())) {

				$("#msg").val("사용가능한 비밀번호입니다.");
				$("#msg").css("color","green");
			}else{
				$("#msg").val("비밀번호는 4자리 숫자로입력해주세요");
				$("#msg").css("color","red");
			}
		})	;
		 $("#qnaSecretchk").change(function(){
		        if($("#qnaSecretchk").is(":checked")){
		        	
					$("#qnaSecret").val("secret");
	
					$("#passLabel").show();
		        }else{
		        	$("#qnaSecret").val("open");
		        	$("#passLabel").hide();
		        }
		    });
		 $("#eye").click(function(){
			 if(($("#qnaPw").attr("type"))=="password"){
				 
				 $("#qnaPw").prop("type","text");
				 $("#eye").prop("class","fas fa-eye");
			 }else{
				 $("#qnaPw").prop("type","password");
				 $("#eye").prop("class","fas fa-eye-slash");
			 }
		 })
		</script>
			</div>
			</div>
			
	</div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 
