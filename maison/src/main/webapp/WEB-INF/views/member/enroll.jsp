<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="회원가입"/>
</jsp:include>
<!-- 다음지도 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
	//submit할때 유효성검사
	function checkSubmit() {
		if($("#idCheck").val()=="0") alert("아이디를 정확히 입력해주세요");
		else if($("#nameCheck").val()=="0") alert("이름을 정확히 입력해주세요");
		else if($("#pwCheck").val()=="0") alert("비밀번호를 정확히 입력해주세요");
		else if($("#rePwCheck").val()=="0") alert("비밀번호 확인을 해주세요");
		else if($("#brithCheck").val()=="0") alert("생년월일을 정확히 입력해주세요");
		else if($("#phoneCheck").val()=="0") alert("전화번호를 정확히 입력해주세요");
		else return true;
		
		return false; 
	}
	
	//다음 주소 api
    function findZipCode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
	
	//아이디 유효성검사 함수
	function regId(str) {
		let reg1 = /^[a-zA-Z0-9]+$/;
		let reg2 = /[a-zA-Z]/g;
		let reg3 = /[0-9]/g;
		return (reg1.test(str) && reg2.test(str) && reg3.test(str));
	}
	//비밀번호 유효성검사 함수
	function regPw(str) {
		let reg1 = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]+$/;
		let reg2 = /[a-zA-Z]/g;
		let reg3 = /[0-9]/g;
		let reg4 = /[~!@#$%^&*()_+|<>?:{}]/g;
		return (reg1.test(str) && reg2.test(str) && reg3.test(str) && reg4.test(str));
	}
	
    $(function() {
    	
    	//아이디 유효성+중복체크
    	$("#memberId").keyup(function(e) {
    		$("#idCheck").val("0");
    		let checkId = $(e.target).val().trim();
    		if(checkId.length<4 || checkId.length>10) {
    			$("#checkId-container").children().css("display","none");
    			$("#notEnoughId").css("display","block");
    		}else {
    			if(regId(checkId)) {
    				$.ajax({
    	    			url:"${path}/member/ajax/checkMemberId",
    	    			type:"post",
    	    			data:{"checkId":checkId},
    	    			success:function(data){
    	    				if(data.result==1) {
    	    					//아이디 사용가능
    	    					$("#checkId-container").children().css("display","none");
    	    					$("#ableId").css("display","block");
    	    					//hidden input에 플래그값 넣어줌
    	    					$("#idCheck").val("1");
    	    				}else if(data.result==0){
    	    					//아이디 중복
    	    					$("#checkId-container").children().css("display","none");
    	    					$("#disableId").css("display","block");
    	    				}
    	    			},
    	    			error:function(error) {
    	    				alert(error);
    	    			}
    	    		}); 
    			}else {
    				$("#checkId-container").children().css("display","none");
    				$("#notRegId").css("display","block");
    			}
    		}
    		
    	});
    	
    	//이름 유효성체크
    	$("#memberName").keyup(function(e) {
    		$("#nameCheck").val("0");
    		if($(e.target).val().trim().length<2) {
    			//이름 길이 짧음
    			$("#checkName-container").children().css("display","none");
    			$("#notEnoughName").css("display","block");
    		}else {
    			//이름 길이 충분
    			$("#checkName-container").children().css("display","none");
    			$("#nameCheck").val("1");
    		}
    	});
    	
    	//비밀번호 유효성체크
    	$("#memberPw").keyup(function(e) {
    		$("#pwCheck").val("0");
    		let checkPw = $(e.target).val().trim();
    		if(checkPw.length<6 || checkPw.length>15) {
    			//길이 짧음
    			$("#checkPw-container").children().css("display","none");
    			$("#notEnoughPw").css("display","block");
    		}else {
    			if(regPw(checkPw)) {
    				//정규식 만족함
        			$("#checkPw-container").children().css("display","none");
        			$("#ablePw").css("display","block");
        			$("#pwCheck").val("1");
    			}else {
    				//정규식 만족안됨
        			$("#checkPw-container").children().css("display","none");
        			$("#notRegPw").css("display","block");
    			}
    		}
    	});
    	
    	//비밀번호 재입력 체크
    	$("#memberRePw").keyup(function(e) {
    		$("#rePwCheck").val("0");
    		let checkRePw = $(e.target).val().trim();
    		let checkPw = $("#memberPw").val().trim();
    		if(checkPw.length!=0 && checkRePw==checkPw) {
    			$("#checkRePw-container").children().css("display","none");
    			$("#ableRePw").css("display","block");
    			$("#rePwCheck").val("1");
    		}else {
    			$("#checkRePw-container").children().css("display","none");
    			$("#notEnoughRePw").css("display","block");
    		}
    	});
    	
    	//생년월일 유효성체크
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
    	
    	//전화번호 유효성체크
    	$("#phone").keyup(function(e) {
    		$("#phoneCheck").val("0");
    		let checkPhone = $(e.target).val().trim();
    		let regPhone = /^0\d{9,12}$/;
    		if(regPhone.test(checkPhone)) {
    			$("#checkPhone-container").children().css("display","none");
    			$("#phoneCheck").val("1");
    		}else {
    			$("#checkPhone-container").children().css("display","none");
    			$("#notRegPhone").css("display","block");
    		}
    	});
    	
    	//데이트피커 설정
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

<style>
	.jumbotron .container{
		text-align: center;
	}
	#address-container #zipcode{
		width: 50vh;
		display: inline-block;
	}
	#address-container #address{
		width: 100vh;
	}
	#address-container #detailAddress{
		width: 50vh;
		display: inline-block;
	}
	#address-container #extraAddress{
		width: 50vh;
		display: inline-block;
	}
	#datepicker{
		width: 50vh;
		display: inline-block;
	}
	#submit-container {
		display: flex;
		justify-content: center;
	}
	#agreeEmail {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		margin-top: 10vh;
		margin-bottom: 10vh;
	}
	#agreeEmail>img {
		width: 200px;
	}
	.border {
	    display: inline-block; 
	    width: 90vh;
	    height: 33vh;
	    margin: 6px;
	    padding: 10px;
	 }
	 .checked {
	 	width: 20px;
	 }
</style>
<section>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1>회원가입</h1>
		</div>		
	</div>
	<form action="${path }/member/enrollEnd" method="POST" onsubmit="return checkSubmit();">
		<div id="enroll-container" class="container">
			<div class="form-group">
			    <label for="memberId">아이디</label>
			    <input type="text" class="form-control" placeholder="영문,숫자 조합 4~10자리" id="memberId" name="memberId" required>
			    <div id="checkId-container">
				    <p class="text-danger" id="notEnoughId" style="display:none">아이디를 4~10글자로 입력해주세요.</p>
				    <p class="text-danger" id="notRegId" style="display:none">영어+숫자 조합만 가능합니다.</p>
				    <p class="text-danger" id="disableId" style="display:none">사용할 수 없는 아이디 입니다.</p>
				    <p class="text-success" id="ableId" style="display:none">사용가능한 아이디입니다.</p>
			    </div>
			    <input type="hidden" id="idCheck" name="idCheck" value="0">
		 	</div>
		 	<div class="form-group">
			    <label for="memberName">이름</label>
			    <input type="text" class="form-control" placeholder="2글자 이상" id="memberName" name="memberName" required>
			    <div id="checkName-container">
				    <p class="text-danger" id="notEnoughName" style="display:none">이름을 2글자 이상으로 입력해주세요.</p>
			    </div>
			    <input type="hidden" id="nameCheck" name="nameCheck" value="0">
		 	</div>
		 	<div class="form-group">
			    <label for="memberPw">비밀번호</label>
			    <input type="password" class="form-control" placeholder="영문,숫자,특수기호 조합 6~15자리" id="memberPw" name="memberPw" required>
			    <div id="checkPw-container">
				    <p class="text-danger" id="notEnoughPw" style="display:none">비밀번호를 6~15글자로 입력해주세요.</p>
				    <p class="text-danger" id="notRegPw" style="display:none">영어+숫자+특수기호 조합만 가능합니다.</p>
				    <p class="text-success" id="ablePw" style="display:none">사용가능한 비밀번호입니다.</p>
			    </div>
			    <input type="hidden" id="pwCheck" name="pwCheck" value="0">
		 	</div>
		 	<div class="form-group">
			    <label for="memberRePw">비밀번호 확인</label>
			    <input type="password" class="form-control" placeholder="비밀번호 재입력" id="memberRePw" required>
			    <div id="checkRePw-container">
				    <p class="text-danger" id="notEnoughRePw" style="display:none">비밀번호가 일치하지 않습니다.</p>
				    <p class="text-success" id="ableRePw" style="display:none">비밀번호가 일치합니다.</p>
			    </div>
			    <input type="hidden" id="rePwCheck" name="rePwCheck" value="0">
		 	</div>
		 	
		 	<!-- 주소부분 -->
		 	<div class="form-group" id="address-container">
			    <label>주소</label><br>
			 	<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호" required>
				<input type="button" class="btn" onclick="findZipCode()" id="zipcodeBtn" value="우편번호 찾기"><br>
				<input type="text" class="form-control" id="address" name="address" placeholder="주소" required><br>
				<input type="text" class="form-control" id="detailAddress" name="detailAddress" placeholder="상세주소" required>
				<input type="text" class="form-control" id="extraAddress" name="extraAddress" placeholder="참고항목">			 	
		 	</div>
		 	
		 	
		 	<div class="form-group">
			    <label for="email">이메일 - 회원가입시 메일 인증이 필요하니 꼭 <mark>사용중인 메일</mark>을 적어주세요.</label>
			    <input type="email" class="form-control" placeholder="이메일 입력" id="email" name="email" required>
		 	</div>
		 	<div class="form-group">
			    <label>성별</label>
		 	</div>
		 	<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="M">남
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="F">여
			  </label>
			</div>
			<div class="form-check-inline disabled">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="N" checked>공개안함
			  </label>
			</div>
			
			<div class="form-group">
			    <label for="datepicker">생년월일</label><br>
			    <input type="text" class="form-control" id="datepicker" name="birth" required>
			    <div id="checkBrith-container">
				    <p class="text-danger" id="notRegBrith" style="display:none">달력에서 생년월일을 선택해주세요</p>
			    </div>
			    <input type="hidden" id="brithCheck" name="brithCheck" value="0">
		 	</div>			
		 	
		 	<div class="form-group">
			    <label for="phone">전화번호</label><br>
			    <input type="text" class="form-control" id="phone" placeholder="'-'없이 숫자만 입력" name="phone" required>
			    <div id="checkPhone-container">
				    <p class="text-danger" id="notRegPhone" style="display:none">전화번호를 '-'없이 숫자만 입력해주세요.</p>
			    </div>
			    <input type="hidden" id="phoneCheck" name="phoneCheck" value="0">
		 	</div>	
		 	
		 	<div id="agreeEmail">
		 		<img src="${path }/resources/images/agreeEmail.png" class="mx-auto d-block" alt="email.png">
		 		<div class="border">
		 			<p><b>MAISON</b>에서 고객님의 이메일에 '주기알림 서비스'를 보내는것에 동의하십니까?</p><br>
		 			<p><b>주기알림 서비스란</b></p>
		 			<p>&nbsp;- 고객님이 <b>MAISON</b>에서 구매하시는 물품에 한해 물품이 모두 소진되었을 시점에<br>
		 				&nbsp;&nbsp;&nbsp;이메일을 통해 해당상품의 링크를 보내어서 불필요한 시간낭비를 덜어주는 서비스입니다.</p><br>
		 			<p><b>필수제공 항목</b></p>
		 			<img class="checked" src="${path }/resources/images/checkedIcon.png">
		 			<span>이메일</span>
		 		</div>
		 		<div class="form-check">
				  <label class="form-check-label">
				    <input type="checkbox" class="form-check-input" name="emailStatus" value="Y" checked>주기알람 서비스 동의하기
				  </label>
				</div>
		 	</div>
		 	
		 	<div id="submit-container">
			 	<button type="button" class="btn btn-danger" onclick="location.href='${path}/'">취소하기</button>
			 	<button type="submit" class="btn btn-primary">회원가입</button>
			</div>
		</div>
	</form>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		