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
<script src = "${path}/ckeditor/ckeditor.js"></script>
<!-- Start With -->
<section>
<br>
<div class="row justify-content-center">
<div class="col-10">
<form action="${path }/notice/noticeAddEnd.do" method="post" id="noticeForm">
	<div id="data-div">
		<div class="form-group required">
		    <label for="noticeTitle" class="control-label" >제목</label>
		    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" 
		    placeholder="제목을 입력하세요.">
		</div>
		<div class="form-group required">
		    <label for="noticeTitle" class="control-label">내용</label>
		   <textarea name="noticeContent" id="noticeContent"></textarea>
		</div>
		<input type="submit" class="btn btn-success" id="savebutton" value="등록" />
	</div>


</form>
	</div>
</div>
<br>
</section>
<!-- End With -->
<script>


CKEDITOR.replace("noticeContent",{
	filebrowserUploadUrl : "${path }/notice/imageUpload.do",
	height:500
});


 $("#noticeForm").submit(function(e){
    var messageLength = CKEDITOR.instances['noticeContent'].getData().replace(/<[^>]*>/gi, '').length;
         if( !messageLength ) {
             alert( '내용을 반드시 입력해주세요.' );
             e.preventDefault();
         }
}) 

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