<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<!-- Start With -->
<div class="with-list-box">
	<div class="container">
		<div style="width:800px">
			<textarea id = "description" name = "description" rows = "5" cols = "80"
			placeholder = "내용을 입력하세요."></textarea>
			<script>
				CKEDITOR.replace("description",{
					filebrowserUploadUrl : "${path }/with/imageUpload.do"
				});
			</script>
		</div>

			
			
		
	</div> 
</div>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	