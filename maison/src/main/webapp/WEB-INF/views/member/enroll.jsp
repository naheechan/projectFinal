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
	function checkSubmit() {
		alert("아직");
		return false;
	}
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
    	$("#memberId").keyup(function(e) {
    		let checkId = $(e.target).val();
    		$("#disableId").css("display","block");
    		$("#ableId").css("display","block");
    		
    		$.ajax({
    			url:"${path}/member/ajax/checkMemberId",
    			type:"get",
    			dataType:"json",
    			data:{"checkId":checkId},
    			success:function(data){
    				console.log(data);
    			},
    			error:function(request,status,error) {
    				console.log(request);
    				console.log(status);
    				alert(error);
    			}
    		}); 
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
			    <input type="text" class="form-control" placeholder="영문,숫자 조합 4~10자리" id="memberId" name="memberId">
			    <p class="text-danger" id="disableId" style="display:none">아이디가 중복됩니다.</p>
			    <p class="text-success" id="ableId" style="display:none">사용가능한 아이디입니다.</p>
			    <input type="hidden" id="idCheck" name="idCheck" value="0">
		 	</div>
		 	<div class="form-group">
			    <label for="memberName">이름</label>
			    <input type="text" class="form-control" placeholder="2글자 이상" id="memberName" name="memberName">
		 	</div>
		 	<div class="form-group">
			    <label for="memberPw">비밀번호</label>
			    <input type="password" class="form-control" placeholder="영문,숫자,특수기호 조합 6~15자리" id="memberPw" name="memberPw">
		 	</div>
		 	<div class="form-group">
			    <label for="memberRePw">비밀번호 확인</label>
			    <input type="password" class="form-control" placeholder="비밀번호 재입력" id="memberRePw">
		 	</div>
		 	
		 	<!-- 주소부분 -->
		 	<div class="form-group" id="address-container">
			    <label>주소</label><br>
			 	<input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="우편번호">
				<input type="button" class="btn" onclick="findZipCode()" id="zipcodeBtn" value="우편번호 찾기"><br>
				<input type="text" class="form-control" id="address" name="address" placeholder="주소"><br>
				<input type="text" class="form-control" id="detailAddress" name="detailAddress" placeholder="상세주소">
				<input type="text" class="form-control" id="extraAddress" name="extraAddress" placeholder="참고항목">			 	
		 	</div>
		 	
		 	
		 	<div class="form-group">
			    <label for="email">이메일</label>
			    <input type="email" class="form-control" placeholder="이메일 입력" id="email" name="email">
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
			    <input type="radio" class="form-check-input" name="gender" value="N">공개안함
			  </label>
			</div>
			
			<div class="form-group">
			    <label for="datepicker">생년월일</label><br>
			    <input type="text" class="form-control" id="datepicker" name="birth">
		 	</div>			
		 	
		 	<div class="form-group">
			    <label for="phone">전화번호</label><br>
			    <input type="text" class="form-control" id="phone" placeholder="'-'없이 숫자만 입력" name="phone">
		 	</div>	
		 	
		 	<div id="submit-container">
			 	<button type="button" class="btn btn-danger">취소하기</button>
			 	<button type="submit" class="btn btn-primary">회원가입</button>
			</div>
		</div>
	</form>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		