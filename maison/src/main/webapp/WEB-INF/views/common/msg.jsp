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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>시스템 메세지</title>
</head>
<body>
	<script>

	if("${warn}"==1) {
		swal("${msg }", "${extraMsg}", "warning")
		.then((value)=>{      
	       location.replace('${pageContext.request.contextPath }${loc}');
	    });
	}else {
	    swal("${msg }")
	    .then((value)=>{      
	       location.replace('${pageContext.request.contextPath }${loc}');
	    });
	}

	</script>

</body>
</html>