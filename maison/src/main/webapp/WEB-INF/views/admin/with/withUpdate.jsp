<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>  
<%@ page import="com.kh.maison.with.model.vo.WithBoard, java.util.*" %>
<%
	String[] shipment = ((WithBoard)request.getAttribute("withBoard")).getWbShip();
	List<String> shipments = new ArrayList();
	if(shipment!=null){
		shipments = Arrays.asList(shipment);
	}
%>      
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>함께해요 게시판 관리 > 게시글 수정</title>
<!-- plugins:css -->
<link rel="stylesheet" href="${path }/resources/admin/vendors/mdi/css/materialdesignicons.min.css">
<link rel="stylesheet" href="${path }/resources/admin/vendors/base/vendor.bundle.base.css">
<!-- endinject -->
<!-- plugin css for this page -->
<link rel="stylesheet" href="${path }/resources/admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet" href="${path }/resources/admin/css/style.css">
<!-- endinject -->
<link rel="shortcut icon" href="${path }/resources/admin/images/favicon.png" />
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src = "${path }/ckeditor/ckeditor.js"></script>
<style>
	#update-div{
		border:1px solid lightgray;
		padding:2%;
	}
	.form-group.required .control-label:after{
	   color: #d00;
	   content: "*";
	   position: absolute;
	   margin-left: 6px;
	}
	#info-div2{
		margin-top:1%;
		margin-bottom:1%;
		padding:2%;
		background-color:#F9F9FA;
	}
</style>
</head>
<body>
<div class="container-scroller">
	<!-- Start nav -->
	<jsp:include page="/WEB-INF/views/admin/navbar.jsp"/>
	<!-- End nav -->
	<div class="container-fluid page-body-wrapper">
		<!-- Start sidebar -->
		<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"/>
		<!-- End sidebar -->	
		<div class="main-panel">
			<div class="content-wrapper">
				<!-- 첫번째 row div 시작 -->
				<div class="row">
		            <div class="col-md-12 grid-margin">
		              <div class="d-flex justify-content-between flex-wrap">
		                <div class="d-flex align-items-end flex-wrap">
		                  <div class="mr-md-3 mr-xl-5">
		                    <h2>함께해요 게시글 수정</h2>
		                    <br>
		                    <p class="mb-md-0">${withBoard.wbTitle }</p>
		                  </div>

		                </div>
		                <div class="d-flex justify-content-between align-items-end flex-wrap">
		                  <div class="d-flex">
		                    <i class="mdi mdi-home text-muted hover-cursor"></i>
		                    <p class="text-muted mb-0 hover-cursor">&nbsp;/&nbsp;대시보드&nbsp;/&nbsp;</p>
		                    <p class="text-primary mb-0 hover-cursor">함께해요 게시글 수정</p>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <!-- 첫번째 row div 끝 -->	
		         <!-- 두번째 row div 시작 -->
		          <div class="row">
		          	<div class="col-lg-12 grid-margin stretch-card">
		              <div class="card">
		                <div class="card-body">
		                  <h4 class="card-title">함께해요 게시판 검색</h4>
		                  <div class="table-responsive pt-3">
										<form action="${path }/admin/withUpdateEnd.do" method="post">
			<!-- 희찬이랑 합치게 되면 여기 value에 ${loginMember.memberId }들어가야함. -->
			<input type="hidden" value="user01" name="memberId">
			<input type="hidden" value="${withBoard.wbNo }" name="wbNo">
			<div id="update-div">
				<div class="form-group required">
					<label for="wbTitle" style="font-weight:bold;" class="control-label">상품명</label>
					<input type="text" id="wbTitle" class="form-control" name="wbTitle" value="${withBoard.wbTitle }"required>
				</div>	
				<div class="form-row">
					<div class="form-group required col-md-4">
						<label for="wbType" style="font-weight:bold;" class="control-label">분류선택</label>
						<select id="wbType" class="form-control" name="wbType" required>
							<c:choose>
								<c:when test="${withBoard.wbType eq 'free'}">
									<option selected value="free">나눔하기</option>
									<option value="sell">중고거래</option>
								</c:when>
								<c:when test="${withBoard.wbType eq 'sell'}">
									<option selected value="sell">중고거래</option>
									<option value="free">나눔하기</option>
								</c:when>								
							</c:choose>
						</select>
					</div>
					<div class="form-group required col-md-8">
						<label for="wbPrice" style="font-weight:bold;" class="control-label">판매 가격</label>
						<input type="text" value="${withBoard.wbPrice }" id="wbPrice" placeholder="₩(원)" class="form-control" name="wbPrice" style="text-align:right;" required>
					</div>
				</div>	
				<div class="form-group">
					<p style="font-weight:bold;">상품상태</p>
					<c:choose>
						<c:when test="${withBoard.wbUse eq 'A'}">
							<c:set var="wbUseA" value="checked"/>
						</c:when>
						<c:when test="${withBoard.wbUse eq 'B'}">
							<c:set var="wbUseB" value="checked"/>
						</c:when>
						<c:when test="${withBoard.wbUse eq 'C'}">
							<c:set var="wbUseC" value="checked"/>
						</c:when>											
					</c:choose>			
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="A"
							${wbUseA !=null ? wbUseA : ""}>
							미개봉
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="B"
							${wbUseB !=null ? wbUseB : ""}>
							거의 새 것
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbUse" value="C"
							${wbUseC !=null ? wbUseC : ""}>
							사용감 있음
						</label>
					</div>
				</div>	
				<div class="form-group required">
					<label style="font-weight:bold;" class="control-label">배송 방법</label>			
					<br>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbShip" value="off" <%=shipments.contains("off")?"checked":""%>>
							직거래
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbShip" value="on" <%=shipments.contains("on")?"checked":""%>>
							택배 거래 
						</label>
					</div>
				</div>	
				<div class="form-group">
					<label for="" style="font-weight:bold;">판매자 정보</label>
					
					<br>
					<!-- ${loginMember.email}, ${loginMmeber.phone}
						DB에 따로 들어가는게 아니라 작성자 데이터 가지고 요리해서 띄워주는거.-->
					<span><c:out value="이메일 들어가는 자리"/></span>&nbsp;&nbsp; | &nbsp; 
					<span id="wbPhoneNum"><c:out value="전화번호 들어가는 자리"/></span>
					&nbsp;
					<br>
					<div class="form-check-inline">
						<c:set var="phoneChk" value="${withBoard.wbPhone }"/>
						<label class="form-check-label">
							<input type="checkbox" class="form-check-input" name="wbPhone" id="wbPhone" value="Y" ${phoneChk == 'Y' ? checked : ""}>
							휴대전화번호 노출 동의
						</label>
					</div>
				</div>											
			</div>	
			<div id="info-div2">
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
				>${withBoard.wbContent }</textarea>
				<script>
					CKEDITOR.replace("wbContent",{
						filebrowserUploadUrl : "${path }/with/imageUpload.do",
						height:'500px',
						startupFocus : false
					});
					$("#withForm").submit(function(e){
						 var messageLength = CKEDITOR.instances['wbContent'].getData().replace(/<[^>]*>/gi, '').length;
	                     if( !messageLength ) {
	                         swal( '내용을 반드시 입력해주세요.' );
	                         e.preventDefault();
	                     }
					})
				</script>
			</div>	
			<button type="button" class="btn btn-light" style="float:right;" onclick="location.href='${path}/admin/with/board.do';">돌아가기</button>
			<button type="submit" class="btn" style="float:right;background-color:#F2BB9C; margin-right:2%;">수정하기</button>
		</form>
		                  </div>
		                </div>
		              </div>
			      	</div>
		          </div>
		          <!-- 두번째 row div 끝 -->		
			</div>
			<jsp:include page="/WEB-INF/views/admin/footer.jsp"/>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/admin/jses.jsp"/>
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
				swal("판매 가격은 숫자만 입력하실 수 있습니다.");
				$(e.target).val('');
			}
		})
	});
</script>	
</body>
</html>