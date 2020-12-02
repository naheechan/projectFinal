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
  config.height{
  	height:500px;
  }

</style>
<script src = "${path}/ckeditor/ckeditor.js"></script>
<!-- Start With -->
<section>
<br>
<div class="row justify-content-center">
<div class="col-10">
<form action="${path }/notice/noticeUpdateEnd.do" method="post" id="noticeForm">
	<div id="data-div">
		<div class="form-group required">
		    <label for="noticeTitle" class="control-label" >제목</label>
		    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" 
		    value="${n.noticeTitle }">
		    <input type="hidden" name="noticeNo" value="${n.noticeNo }">
		</div>
		<div class="form-group required">
		    <label for="noticeTitle" class="control-label">내용</label>
		   <textarea name="noticeContent" id="noticeContent">${n.noticeContent }</textarea>
		</div>
		<input type="submit" class="btn btn-info" id="savebutton" value="수정" />
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
	height: 500
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		