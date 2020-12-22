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
		if($("#brithCheck").val()=="0") swal("생년월일을 정확히 입력해주세요");
		else if($("#phoneCheck").val()=="0") swal("전화번호를 정확히 입력해주세요");
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
	
    $(function() {
    	
	  	//생년월일 유효성체크
		$("#datepicker").change(function(e) {
			$("#brithCheck").val("0");
			let checkBirth = $(e.target).val().trim();
			let regBirth = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;
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
	#submit-container {
		display: flex;
		justify-content: center;
	}
	#submit-container button {
		padding: 2vh;
		margin: 5vh;
	}
</style>
<section>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<h1>간단 회원가입</h1>
			<h2>네이버로 최초 로그인시 간단한 정보입력을 통해서 회원가입을 완료하실수있습니다.</h2>
		</div>		
	</div>
	
	<form action="${path }/member/enrollEnd" method="POST" onsubmit="return checkSubmit();">
		<div id="enroll-container" class="container">
		
			<input type="hidden" id="memberId" name="memberId" value="${memNaver.memberId }">
			<input type="hidden" id="memberName" name="memberName" value="${memNaver.memberName}">
			<input type="hidden" id="email" name="email" value="${memNaver.email}">
			<input type="hidden" id="gender" name="gender" value="${memNaver.gender}">
	
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
			    <label for="datepicker">생년월일</label><br>
			    <input type="text" class="form-control" id="datepicker" name="birth" autocomplete="off" required>
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