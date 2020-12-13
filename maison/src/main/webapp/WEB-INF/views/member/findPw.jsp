<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="비밀번호 찾기"/>
</jsp:include>
<style>
	.jumbotron .container{
		text-align:center;
	}
	div#findPwContainer{
		display: flex;
		align-items: center;
		flex-direction: column;
		margin-top:60px;
		margin-bottom:30px;
	}
	
</style>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<section>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1>비밀번호 재설정</h1>
		</div>		
	</div>
	
	<div class="container" id="findPwContainer" >
		<div>
			<p style="font-size:30px">비밀번호 재설정에 필요한 정보를 입력하세요</p>
		</div>
			<form id="findPw" name="findPw">
				아이디 <br><input type="text" class="form-control" name="memberId" id="memberId" required style="width:400px;">
				이름 <br><input type="text" class="form-control" name="name" id="name" required>
				<div class="form-group">
					    <label for="datepicker">생년월일</label>
					    <input type="text" class="form-control" id="datepicker" name="birth" required  style="width:150px;">
					    <div id="checkBrith-container">
						    <p class="text-danger" id="notRegBrith" style="display:none">달력에서 생년월일을 선택해주세요</p>
					    </div>
					    <input type="hidden" id="brithCheck" name="brithCheck" value="0">
					    
				</div>
				<input type="button" class="btn" value="확인" onclick="findBtn();" return false; style="float:right"><br>
				<br>
				<div id="checkDiv" style="display:none">
					<input type="text" id="emailCheck" name="emailCheck" class="form-control"><br>
					<input type="hidden" id="pwCheck" name="pwCheck" ><input type="text" id="input" class="form-control" readonly style="width:400px;" dir="rtl"></span><br>
					<input type="button" value="인증번호 확인" onclick="equalCheck()" style="float:right"id="equalBtn" class="btn"return false;>				
					
				</div>
			</form>
			<a href="#myModal" class="btn btn-primary" data-toggle="modal" style="display:none" id="modalBtn">비밀번호 재설정하기</a>
			
			<form action="${path }/member/updatePw" id="updateForm">
				<div id="myModal" class="modal">
			    	 <div class="modal-dialog">
			         	 <div class="modal-content" style="height:400px;">
			           	    <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                    <h4 class="modal-title">Confirmation</h4>
			               </div>
				               <div class="modal-body">
				                    	새로운 비밀번호<i class="far fa-check-circle" style="color:white" id="pwfont"></i>  <input id="password" type="password" name="password" class="form-control" placeholder="비밀번호는 6~15자리 영어+숫자+특수문자">
				                    	비밀번호 확인<i class="far fa-check-circle" style="color:white" id="pwchfont"></i>  <input id="passwordch" type="password" name="passwordch" class="form-control" placeholder="비밀번호는 6~15자리 영어+숫자+특수문자">
				                    <input type="hidden" name="modalId" id="modalId">
					              	<div class="g-recaptcha" data-sitekey="6LdmOf4ZAAAAAH5qDHrHiRouhZjvPgTG_kJUbrpA" style="margin-left:160px;margin-top:20px;"></div>
		
				               </div>
				               <div class="modal-footer">
				                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				                    <button id="submitBtn"type="button" class="btn btn-primary">비밀번호 재설정</button>
	
			              	  </div>
							
			          	</div>
			    	 </div>
				</div>
				
			</form>
			
			
	</div>
</section>
<script>
	var count=0;
	$(function(){		
		var pwChk= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,15}$/;
		$("#password").keyup(function(){
			 if(pwChk.test($("#password").val())) {
				 $("#pwfont").prop("class","far fa-check-circle")
				 $("#pwfont").css("color","green");
			}else{
				$("#pwfont").prop("class","far fa-times-circle")
				$("#pwfont").css("color","red");
			} 
		});
		$("#passwordch").keyup(function(){
			if(pwChk.test($("#passwordch").val()) && $("#password").val()==$("#passwordch").val()) {
				 $("#pwchfont").prop("class","far fa-check-circle")
				 $("#pwchfont").css("color","green");
			}else{
				$("#pwchfont").prop("class","far fa-times-circle")
				$("#pwchfont").css("color","red");
			} 
		});
	})
	$(function() {
		$('#submitBtn').click(function() {
			var pwChk= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,15}$/;
			var captcha = 1;
				if(pwChk.test($("#password").val())) {
					if( $("#password").val()==$("#passwordch").val()){
						$.ajax({
				            url: '${path}/member/VerifyRecaptcha',
				            type: 'post',
				            data: {
				                recaptcha: $("#g-recaptcha-response").val()
				            },
				            success: function(data) {
				                switch (data) {
				                    case 0:
				                        console.log("자동 가입 방지 봇 통과");
				                        captcha = 0;
				                        $("#updateForm").submit();
				                       
				                		break;
				                    case 1:
				                        swal("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
				                        break;
				                    default:
				                        swal("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
				                   		break;
				                }
				            }
				        });
					}else{
						swal("비밀번호와 비밀번호확인이 일치하지 않습니다.");
					}
						
				}else{
					swal("비밀번호 형식에 맞게 작성해주세요");
				}
				

				if(captcha != 0) {
					return false;
				} 
		});
		});
	
	 $(document).ready(function(){
		    function alignModal(){
		        var modalDialog = $(this).find(".modal-dialog");
		        
		        // Applying the top margin on modal dialog to align it vertically center
		        modalDialog.css("margin-top", Math.max(0, ($(window).height() - modalDialog.height()) / 2));
		    }
		    // Align modal when it is displayed
		    $(".modal").on("shown.bs.modal", alignModal);
		    
		    // Align modal when user resize the window
		    $(window).on("resize", function(){
		        $(".modal:visible").each(alignModal);
		        
		    });   
		});
	function findBtn(){
		
		count++;
		$("#equalBtn").css("display","inline");
		$("#input").val(null);
		var result = Math.floor(Math.random() * 1000000)+100000;
		if(result>1000000){
		   result = result - 100000;
		}
		$("#pwCheck").val(result);

		
	    var queryString = $("#findPw").serialize() ;
	
	    $.ajax({
	        type : 'post',
	        url : '${path}/member/findPwSMTP',
	        data : queryString,
	        dataType : 'json',
	        error: function(xhr, status, error){
	            swal("빈칸을 다 입력해주세요");
	        },
	        beforeSend: function() {

                $('html').css("cursor","wait");   // 현재 html 문서위에 있는 마우스 커서를 로딩 중 커서로 변경

     		},
     		complete: function() {

                $('html').css("cursor","auto"); // 통신이 완료 된 후 다시 일반적인 커서 모양으로 변경

            },

	        success : function(data){
	            if(data==1){
	            	swal("사용자가 존재하지 않습니다", "입력하신 정보를 다시 확인해 주세요");
	            }else if(data==2){
	            	swal("등록하신 이메일로 인증번호를 발송하였습니다.");
/* 	            	$("#emailCheck").prop("type","text");
	            	$("#equalBtn").css("display","inline"); */
	            	$("#checkDiv").css("display","inline");
	            	$(function(){
	            		$("#input").css("color","black");
	            		var num = 60 * 5; // 몇분을 설정할지의 대한 변수 선언
	            		var myVar;
	            		function time(){
	            		    myVar = setInterval(alertFunc, 1000); 
	            		}
	            		time();	            	
	            		function alertFunc() {
	            			
	            		    var min = num / 60; 
	            		    min = Math.floor(min);
	            		     
	            		    var sec = num - (60 * min);
	            		
	            		    var $input = $('#input').val(min + ':' + sec);
	            		
	            		    if(num == 0){
	            		        clearInterval(myVar); // num 이 0초가 되었을대 clearInterval로 타이머 종료	       
	            		        swal("인증시간이 초과되었습니다.","다시 인증을 받아주세요");
	            		        $("#input").val("인증번호 인증시간이 초과되었습니다").css("color","red");
	            		        $("#equalBtn").css("display","none");
	            		        $("#memberId").val(null);
	            		        $("#name").val(null);
	            		        $("#datepicker").val(null);
	            		        $("#emailCheck").val(null);
	            		        
	            		    }else{
	            		    	if($("#emailCheck").val() == $("#pwCheck").val()){
	            		    		clearInterval(myVar);
	            		    		function equalCheck(){
		            		    	}
	            		    		
	            		    	}
	            		    		
	            		    		
	            		    }
	            		    num--;
	            		}
	            		
	            	});
	            }
	        }
	    });

	}
	 function equalCheck(){
 		console.log($("#emailCheck").val());
		console.log($("#pwCheck").val());
		$("#input").val(null);
		
	    if($("#emailCheck").val() == $("#pwCheck").val()){
	    	swal("인증이 완료되었습니다","비밀번호 재설정을 할수 있습니다.","success");
			$("#equalBtn").css("display","none");
	 		$("#input").val("인증이 완료되었습니다").css("color","green");
	 		$("#modalBtn").css("display","inline");
	 		$("#modalId").val($("#memberId").val());
	 		$("#modalBtn").trigger("click");
	 		

	    }else{
	    	swal("인증번호가 일치하지 않습니다.");
	    } 
		 
	 }
	 $("#close_modal").click(function() {
         $("#exampleModal").modal("hide");
     });

	$(function() {
		$("#datepicker").change(function(e) {
			$("#brithCheck").val("0");
			let checkBirth = $(e.target).val().trim();
			let regBirth = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
			if(regBirth.test(checkBirth)) {
				$("#checkBrith-container").children().css("display","none");
				$("#brithCheck").val("1");
			}else {
				$("#checkBrith-container").children().css("display","none");
				$("#notRegBrith").css("display","block");
			}
		});
		
		 $("#datepicker").datepicker({
	     	showOn:"both",
	     	buttonImage:"${path}/resources/images/calendarIcon.jpg",
	     	buttonImageOnly:true,
	     	changeMonth:true,
	     	changeYear:true,
	     	minDate:'-150y',
	     	nextText:'다음 달',
	     	prevText:'이전 달',
	     	yearRange:'c-150:c+0',
	     	dateFormat:'yy-mm-dd',
	     	showMonthAfterYear:true,
	     	dayNamesMin:['월','화','수','목','금','토','일'],
	     	monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	     });
		 
	 	
	});
	
	
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		