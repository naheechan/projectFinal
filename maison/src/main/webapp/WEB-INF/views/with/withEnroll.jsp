<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 등록"/>
</jsp:include>
<script type="text/javascript" src="${path }/resources/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>

<!-- Start With -->
<div class="with-list-box">
	<div class="container">
		
			
				<form action="<%=request.getContextPath() %>/submit" method="post" id="noticeWriteForm">
					<br>
					<div class="form-row">
						<div class="form-group">
							<select name="category" class="form-control" id="selcatd" style="width:200px;">
								<option value="">카테고리</option>
								<option value="share">나눔하기</option>
								<option value="sell">중고거래</option>
							</select>
						</div>
						&nbsp;&nbsp;&nbsp;
						<div class="form-group">
							<input class="form-control" style="width:500px;" type="text" placeholder="제목을 입력해주세요." id="title" name="title">						
						</div>
					</div>
					<br>
					<br>
					<textarea name="smartEditor" id="smartEditor"></textarea> 
					<input type="button" id="savebutton" value="서버전송"/>
				</form>
			
			
		
	</div> 
</div>
<!-- End With -->
<script type="text/javascript">
var oEditors = []; 
nhn.husky.EZCreator.createInIFrame({ 
	oAppRef : oEditors, 
	elPlaceHolder : "smartEditor", 
	sSkinURI : "<%=request.getContextPath() %>/resources/se2/SmartEditor2Skin.html",
	fCreator : "createSEditor2", 
	htParams : { bUseToolbar : true, 
		bUseVerticalResizer : false, 
		bUseModeChanger : false } 
	}); 
	$(function() { 
		$("#savebutton").click(function() { 
			oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); 
			var selcatd = $("#selcatd > option:selected").val(); 
			var title = $("#title").val(); 
			var content = document.getElementById("smartEditor").value;; 
			if (selcatd == "") { 
				alert("카테고리를 선택해주세요."); 
				return; 
			} 
			if (title == null || title == "") { 
				alert("제목을 입력해주세요."); 
				$("#title").focus(); 
				return; 
			} 
			if(content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br/>' || content == '<p>&nbsp;</p>'){ 
				alert("본문을 작성해주세요."); 
				oEditors.getById["smartEditor"].exec("FOCUS"); 
				return; 
			} 
			var result = confirm("발행 하시겠습니까?"); 
			if(result){ 
				alert("발행 완료!"); 
				$("#noticeWriteForm").submit(); 
			}else{ 
				return; 
			} 
		}); 
	})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	