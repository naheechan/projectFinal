<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="path" value="${pageContext.request.contextPath }"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소통해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>


<script src = "${path}/ckeditor/ckeditor.js"></script>
<!-- Start With -->
<form action="${path }/notice/noticeAddEnd.do" method="post" id="noticeFrm">
	<table class="col-md-12 table">
		<tr>
			<th>제목</th>
			<td><input type="text" name="noticeTitle" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="noticeContent" id="noticeContent"></textarea>
			
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" class="btn btn-success" id="savebutton" value="글쓰기" />
			</td>
		</tr>	
		
	
	
	</table>


</form>
<!-- End With -->
<script>


CKEDITOR.replace("noticeContent",{
	filebrowserUploadUrl : "${path }/notice/imageUpload.do"
});
<%-- $(function(){
    //전역변수선언
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "smarteditor",
        sSkinURI: "/se2/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
    });
     
    //전송버튼 클릭이벤트
    $("#savebutton").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증
         
        //폼 submit
        $("#frm").submit();
    })
})

var oEditors = []; 
nhn.husky.EZCreator.createInIFrame({ 
	oAppRef : oEditors, 
	elPlaceHolder : "smarteditor", 
	sSkinURI : "<%=request.getContextPath() %>/resources/se2/SmartEditor2Skin.html",
	fCreator : "createSEditor2", 
	htParams : { bUseToolbar : true, 
		bUseVerticalResizer : false, 
		bUseModeChanger : false } 
	}); 
	$(function() { 
		$("#savebutton").click(function() { 
			oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []); 
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
				oEditors.getById["smarteditor"].exec("FOCUS"); 
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
	}) --%>
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		