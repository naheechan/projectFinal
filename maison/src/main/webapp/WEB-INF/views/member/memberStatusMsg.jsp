<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시스템 메세지</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script>
/* 		swal({
			  title: "정말 탈퇴하시겠습니까?",
			  text: "회원탈퇴 시 모든 정보가 삭제되며, 복구되지 않습니다. 탈퇴하시겠습니까?!",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				swal("탈퇴처리가 성공적으로 완료되었습니다.","지금까지 메종을 이용해주셔서 감사합니다.","success")
				.then((value)=>{		
					location.replace('${path }${loc}');
				});
			  } else {
					swal("탈퇴처리가 유보되었습니다.","메종과 계속 함께해주셔서 감사합니다.","info")
					.then((value)=>{		
						location.replace('${path }');
					});
			  }
			}); */
		swal({
			title : "정말 탈퇴하시겠습니까?",
			text : "회원탈퇴 시 모든 정보가 삭제되며, 복구되지 않습니다.",
			icon : "warning",
			buttons: ["취소", "확인"],
			dangerMode : true,
		})
		.then((willDelete)=>{
			if(willDelete){
				swal("탈퇴처리가 완료되었습니다.","지금까지 메종을 이용해주셔서 감사합니다.","success")
				.then((value)=>{
					location.replace('${path}/member/memberStatusNo?memberId=${memberId}&withdrawCom=${withDrawCom}');
				});
			}else{
				swal("탈퇴처리가 유보되었습니다.","메종과 계속 함께해주셔서 감사합니다.","info")
				.then((value)=>{		
					location.replace('${path }');
				});		
			}
		})
	</script>
</body>
</html>