<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="질문해요"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="질문해요"/>
</jsp:include>

	
	<div class="container">
		<div class="row">
			<div class="col-lg-12" style="text-align:left;margin-bottom:30px">
				<div class="form-inline form-group" style="margin-top:25px;margin-bottom:25px;" >
				      <label for="phone_num" class="col-sm-0 control-label">제목:</label>
				      <div class="col-sm-11">
				       <input type="text" class="form-control"  value="${qnaBoard.qnaTitle }" readonly  style="width:500px;">
				      </div>
		     	</div>
		     	<hr>

			</div>
			<div class="col-lg-12" id="imgShow" style="text-align:left;">
          		 <textarea id="qnaContent" hidden="hidden"><c:out value="${qnaBoard.qnaContent}"/></textarea>
         
        	</div>
		</div>
		
		<form id="commentForm" name="commentForm" method="post">
	    <br><br>
	        <div>
	            <div>
	                <span><strong>Comments</strong></span> <span id="cCnt"></span>
	            </div>
	            <div>
	                <table class="table">                    
	                    <tr>
	                        <td>
	                         	<input type="hidden" value="${qnaNo}" name="bno">	
	                            <textarea style="width: 1100px" rows="3" cols="30" id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
	                            <br>
	                            <div>
	                                <button class="btn" name="commentInsertBtn">등록</button>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	        </div>
	     
  	  </form>
  	    <div class="container">
        <div class="commentList"></div>
    	</div>

	</div>
	
	<script>
		var bno="${qnaNo}";
		var string="작성자 : 관리자"
		$('[name=commentInsertBtn]').click(function(){
		   var insertData = $("#commentForm").serialize();
		   commentInsert(insertData);
		});
		//댓글등록
		function commentInsert(insertData){
			   $.ajax({
			      url:'${path }/qnaBoard/commentEnroll.do',
			      type:'post',
			      data:insertData,
			      success : function(data){
			         if(data==1){
			            console.log('SUCCESS');
			             //  commentList();
			            $("#content").val('');
			         }
			      }
			   })
			};
			
			//댓글 자동 불러오기	
			$(function(){
				    
				getCommentList();
				    
			});	
			//댓글 리스트
			function getCommentList(){
	    
				$.ajax({
			        url : '${path }/qnaBoard/commentList.do',
			        type : 'get',
			        data : {'bno':bno},
			        success : function(data){
			            var a =''; 
			            $.each(data, function(key, value){ 
			               a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
			               a += '<div class="commentInfo'+value.qcNo+'">'+'<h4>작성자 : 관리자</h4>';
			               a += '<div class="commentContent'+value.qcNo+'"> <p> '+value.qcContent +'</p>';
			               a += '</div></div></div>';
			            });
			            
			            $(".commentList").html(a);
			        }
			    });
			}


		
	
			
				
		
	</script>
	
 <script>

 $(document).ready(function() {
	 	$("#imgShow").html($("#qnaContent").val());
});
 
 </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		