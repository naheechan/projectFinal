<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.kh.maison.common.crypto.AES256Util,com.kh.maison.member.model.vo.Member" %>
<!-- loginMember의 값들은 암호화가 된채로 넘어온다. 그러므로 aes와 session값을 가지고 decrypt처리해준다. -->
<%
	AES256Util aes = new AES256Util();
	Member m = (Member)session.getAttribute("loginMember");
	String dEmail = aes.decrypt(m.getEmail());
	String dPhone = aes.decrypt(m.getPhone());
%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 등록"/>
</jsp:include>

<!-- ckeditor쓰는 법 
	1. <script src = "${path}/ckeditor/ckeditor.js"></script>추가
	2. id가 홍길동인 textarea 만들기.
    3. <script>
			CKEDITOR.replace("홍길동",{
			filebrowserUploadUrl : "${path }/파일업로드 컨트롤러 매핑값"
		});
		</script>
	4. 샘플용 fileUpload controller는 com.kh.maison.with.controller.WithController에 있습니다.
	cf) ckeditor관련 파일들은 views 밑에 있어요!!
-->
<script src = "${path}/ckeditor/ckeditor.js"></script>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>
<style>
	#data-div{
		border:1px solid lightgray;
		padding:2%;
	}
	#info-div{
		margin-top:1%;
		margin-bottom:1%;
		padding:2%;
		background-color:#F9F9FA;
	}
	.form-group.required .control-label:after{
	   color: #d00;
	   content: "*";
	   position: absolute;
	   margin-left: 6px;
	}
</style>

<!-- Start With Enroll-->
<div class="with-list-box">
	<div class="container">
		<form action="${path }/with/withEnrollEnd.do" method="post" id="withForm">
			<input type="hidden" value="${loginMember.memberId }" name="memberId">
			<div id="data-div">
				<div class="form-group required">
					<label for="wbTitle" style="font-weight:bold;" class="control-label">상품명</label>
					<input type="text" id="wbTitle" class="form-control" name="wbTitle" required>
				</div>
				<div class="form-row">
					<div class="form-group required col-md-4">
						<label for="wbType" style="font-weight:bold;" class="control-label">분류선택</label>
						<select id="wbType" class="form-control" name="wbType" required>
							<option selected>선택하기</option>
							<option value="free">나눔하기</option>
							<option value="sell">중고거래</option>
						</select>
					</div>
					<div class="form-group required col-md-8">
						<label for="wbPrice" style="font-weight:bold;" class="control-label">판매 가격</label>
						<input type="text" readonly id="wbPrice" placeholder="₩(원)" class="form-control" name="wbPrice" style="text-align:right;" required>
					</div>
				</div>
				<div class="form-group">
					<p style="font-weight:bold;">상품상태</p>			
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="A">
							미개봉
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="B">
							거의 새 것
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="C">
							사용감 있음
						</label>
					</div>
				</div>
				<div class="form-group required">
					<label style="font-weight:bold;" class="control-label">배송 방법</label>			
					<br>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbShip" value="off">
							직거래
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbShip" value="on">
							택배 거래 
						</label>
					</div>
				</div>
				<div class="form-group">
					<label for="" style="font-weight:bold;">판매자 정보</label>			
					<br>
					<span><%=dEmail%></span>&nbsp;&nbsp; | &nbsp; 
					<span id="wbPhoneNum"><%=dPhone %></span>
					&nbsp;
					<br>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbPhone" id="wbPhone" value="Y">
							휴대전화번호 노출 동의
						</label>
					</div>
				</div>
			</div>
			<div id="info-div">
				거래전 필독! 주의하세요!
				<br>
				* 직거래는 반드시 사람이 많고 치안이 안전한 곳에서 해주세요.
				<br>
				* 거래 기록이 남는 계좌이체가 거래 기록이 남지 않는 현금거래보다 안전합니다.
				<br>
				* 거래 전 연락처 및 계좌번호를 사이버캅과 더치크로 조회해 주시기 바랍니다.
				<br>
				* 메종은 통신판매중개자로 통신판매자의 당사자가 아닙니다. 회원과 구매 회원 간의 상품거래 정보 및 거래에 관여하지 않으며 어떠한 의무와 책임도 부담하지 않습니다.
			</div>
			<div class="form-group">
				<textarea id = "wbContent" name = "wbContent" rows = "20" cols = "80"
				></textarea>
				<script>
					CKEDITOR.replace("wbContent",{
						filebrowserUploadUrl : "${path }/with/imageUpload.do",
						height:'500px',
						startupFocus : false
					});
					$("#withForm").submit(function(e){
						 var messageLength = CKEDITOR.instances['wbContent'].getData().replace(/<[^>]*>/gi, '').length;
	                     if( !messageLength ) {
	                         alert( '내용을 반드시 입력해주세요.' );
	                         e.preventDefault();
	                     }
					})
				</script>
			</div>
			<button type="reset" class="btn btn-light" style="float:right;">다시쓰기</button>
			<button type="submit" class="btn" style="float:right;background-color:#F2BB9C; margin-right:2%;">등록하기</button>
		</form>	
	</div> 
</div>
<!-- End With -->
<script>
	$(document).ready(function(){
		/* 상품상태 체크박스 셋중에서 하나만 선택 */
		$('input[type="checkbox"][name="wbUse"]').click(function(){
			if($(this).prop('checked')){
				$('input[type="checkbox"][name="wbUse"]').prop('checked',false);
				$(this).prop('checked',true);
			}
		})
		/* 배송방법은 둘다 선택가능하게 할거라서 script필요 없음. 
			대신에 배송방법이 직거래면 직거래 어느 지역에서 할지 선택해서 넣을 수 있음.*/
			
		//전화번호, 이메일 양방향 암호화 해제.
	});
	
	/* 분류선택에서 나눔하기를 누르면 판매가격에 자동으로 0원 readonly로,
		중고거래를 누르면 판매가격에 원이 생기면서 숫자를 입력할 수 있게 함.*/
	$(function(){
		$("#wbType").change(function(){
			var selected = $(this).val();
			if(selected=='free'){
				$("#wbPrice").val('0');
				$("#wbPrice").attr('readonly',true);
			}else{
				$("#wbPrice").attr('readonly',false);
				$("#wbPrice").val('');
				$("#wbPrice").prop('placeholder','₩(원)');
			}
		});

		/* 판매 금액 칸에 input type은 text지만 실제로는 숫자만 들어가게 하는 정규식.
			숫자가 아닌 값을 입력하면 알림이 뜸.*/
		$("#wbPrice").blur(e=>{
			let price = $(e.target).val();
			let regPrice = /^[0-9]*$/;
			if(!regPrice.test(price)){
				alert("판매 가격은 숫자만 입력하실 수 있습니다.");
				$(e.target).val('');
			}
		})
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	