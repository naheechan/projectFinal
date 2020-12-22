<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="상품수정" />
</jsp:include>
<script src="${ path }/ckeditor/ckeditor.js"></script>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="상품수정" />
</jsp:include>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Start -->
<div class="shop-list-box">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 col-lg-5 col-md-6"></div>
		</div>
	</div>
</div>
<!-- End -->
<c:forEach var="list" items="${list }">
    <form class="signup-form" id="Frm" action="${path}/admin/product/updateEnroll.do?no=${list.productNo}" method="post" enctype="multipart/form-data">
</c:forEach>
      <!-- form header -->
      <div class="form-header">
        <h1>상품수정</h1>
      </div>

      <!-- form body -->
      <div class="form-body">

        <!-- Category -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="category" class="label-title">카테고리 [대]*</label>
            <select class="form-control" id="largeCate" name="largeCate" >
            	<option value="">선택하세요</option>	
            <c:forEach items="${largeCate }" var="list">
            	<option value="${list.largeCate}">${list.largeCate}</option>
            </c:forEach>
           
            </select>
          </div>
          <div class="form-group right" id="category1">
            <label for="category" class="label-title">카테고리 [중]*</label>
            <select class="form-control" id="mediumCate" name="mediumCate">
            <option value="">선택하세요</option>
            </select>
          </div>
        <!-- Ajax -->
        <div class="horizontal-group">
          <div class="form-group left">
          	<span id="cateText">선택한 카테고리:</span>
          	<span id="cateText1"></span>
          	<span id="cateText2"></span>
          </div>
          <div class="form-group right">
			<a id="createbtn">카테고리등록</a>
          </div>
        </div>
        <c:forEach var="list" items="${list }">
		<!-- Name -->
        <div class="form-group">
          <label for="productName" class="label-title">상품이름 *</label>
          <input type="text" name="productName" id="productName" class="form-input" placeholder="enter product name" required="required"
          value="${list.productName }">
        </div>
		
		<!-- Summary -->
        <div class="form-group">
          <label for="text" class="label-title">상품요약설명 *</label>
          <input type="text" name="productSummary" id="productSummary" class="form-input" placeholder="enter product summary" required="required"
          value="${list.productSummary}">
        </div>
        
        <!--editor  -->
        	<div class="form-group">
        	<label for="productContent" class="label-title">상품상세페이지 *</label>
        	<textarea id="productContent" name="productContent" rows="10" cols="80" 
        	placeholder="내용을 입력하세요" required="required">${list.productContent}</textarea>
        	<script>
        	$(function(){
        		CKEDITOR.replace("productContent",{
					filebrowserUploadUrl : "${path}/admin/product/imageUpload.do"});     		
        		$productContent = CKEDITOR.instances.description.getData();
        		if(CKEDITOR.instances.description.getData().length<1){
        			return;
        		}
        	})
        	</script>
        </div>
        
         <!-- Image -->
        <div class="horizontal-group">
          <div class="form-group left" >
            <label for="productImg" class="label-title">상품이미지 *</label>
            <input type="file" name="imageFile" id="productImg" size="80" accept=".jpg, .jpeg, .png, .bmp" data-width="300" data-height="300" required="required">
          </div>
          </div>
          
        <!-- Price & StockCount -->
        <div class="horizontal-group">
          <div class="form-group left" >
             <label for="price" class="label-title">상품가격 *</label>
            <input type="number" name="price" id="price" class="form-input" placeholder="원" required="required"
            value="${list.price}">
          </div>
          <div class="form-group right">
            <label for="productStock" class="label-title">재고수량 *</label>
            <input type="range" min="0" max="1000" step="10"  value="0" name="productStock" id="productStock" class="form-input" 
            required="required" onChange="change();" style="height:28px;width:78%;padding:0;">
            <br>
            <span id="range-label">${list.productStock }</span>
          </div>
        </div>	
        
        <!-- ProductStatus -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="productStatus" class="label-title">판매상태 *</label><br>
            <input type="radio" id="productStatusY" name="productStatus" value="Y" <c:if test="${list.productStatus eq 'Y'}">checked="checked"</c:if>>예
            <input type="radio" id="productStatusN" name="productStatus" value="N" <c:if test="${list.productStatus eq 'N'}">checked="checked"</c:if>>아니오
          </div>
          <!-- DefCycle -->
          <div class="form-group left">
          <label for="defCycle" class="label-title">주기일 *</label><br>
            <input type="number" name="defCycle" id="defCycle" class="form-input" required="required" value="${list.defCycle}">
          </div>
		</c:forEach>
		<!-- mediumCate -->
        <div class="form-group right">
          <input type="hidden" name="mediumCate" id="mediHidden" class="form-input" value="">
        </div>
        </div></div>
      <!-- form-footer -->
      <div class="form-footer">
        <span>* required</span>
        <button type="button" id="updatebtn" class="btn">수정</button>
      </div>
      </div>
    </form>
      

    <!-- Script for range input label -->
    <script>
      var rangeLabel = document.getElementById("range-label");
      var productStock = document.getElementById("productStock");

      function change() {
      rangeLabel.innerText = productStock.value + "개";
      }
    </script>
    
    <!-- category등록 -->
    <script>
   
    		$("#createbtn").click(function(){
    			alert("카테고리를 추가로 등록하시겠습니까?");
    		
    			window.open("${path}/admin/product/moveEnrollCate.do", "카테고리등록", "width=550, height=450, toolbar=no, menubar=no, scrollbars=no, resizable=no");
    			
    		})
   
    </script>
    <!-- select option fn -->
    <script>
    
    $(function(){
    	$("#largeCate").change(function(){
        var url = "${path}/admin/product/category.do";
    	var value = $("#largeCate").val();
    	$.ajax({
    		url:url,
    		type:"post",
    		data: {data: value},
    		dataType:"json",
    		success:function(data){
    			var mc = $("#mediumCate");
    			//list로받음
    			console.log(data);
    			
    			console.log(data[0].mediumCate);
	    		$("#mediHidden").attr("value",data[0].mediumCate);
    			
    			if(data.length>0){
    				mc.empty();
    				for(var i=0;i<data.length;i++){
    					 var option = $("<option value = '"+data[i].mcName + "'>"+data[i].mcName +"</option>");
    					
    		               mc.append(option); 
    		               
    				}
    			}else{
    				mc.empty();
    				mc.append("<option value=' '>선택</option>");
    			}
    			if($("#largeCate").change(function(){
    					$("#cateText1").empty();
	    				$("#cateText2").empty();
	    			}));
    			$("#cateText1").append(value);
    			var name = $("#mediumCate").val();
    			$("#cateText2").append(">"+name);
    		}
    		 ,error:function(request,error){
    			console.log("ajax통신 실패");
    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    		} 
    	});
    
    	});
    	//hidden에 mediumCate값 넣기
    	$("#mediumCate").change(function(){
    		var medival = $("#mediumCate").val();
    		$("#cateText2").empty();
    		console.log(medival);
   			 var url = "${path}/admin/product/medicategory.do";
   		    	$.ajax({
   		    		url:url,
   		    		type:"post",
   		    		data: {mcName: medival},
   		    		dataType:"json",
   		    		success:function(data){
   		    			var mc = $("#mediumCate");
   		    			console.log("ajax 통신 성공"+data);
   		    			console.log("ajax mediumCate hidden"+data.mediumCate);

   		    			$("input[type=hidden]").attr('value',data.mediumCate);
 		    			console.log(data.mediumCate);
 		    			
   		    			$("#cateText2").append(">"+medival);
   		    			if($("#largeCate").change(function(){
   		    				
   		    				$("#cateText2").empty();
   		    			}));
   		    			if($("#mediumCate").change(function(){
   		    				
	   		    			$("#cateText2").empty();
   		    			}));
   					},
   					error:function(){
   						console.log("ajax통신실패");	
   						console.log("medival in jsp"+medival);
   					}
  				})
    	});
    	
    	$("#updatebtn").click(function(){
			var pName=$("#productName");
			var pSummary = $("#productSummary");
			var price = $("#price");
			var img=$("#productImg");
			var defCycle=$("#defCycle");
    		var option= $("#largeCate option:selected").val();
    		if(option==""){
    			swal("Are you sure?","카테고리를 선택해주세요.","info");
    		}else{
	    		if(!pName.val()==""&&!pSummary.val()==""&&!img.val()==""&&!price.val()==""&&!defCycle.val()==""){
    				$("#Frm").submit();
	    		}else{
	    			swal("Are you sure?","빈칸이 있으면 수정하실 수 없습니다.","info");
	    		}
    		}
    	})
    	
   		$("#productName").click(function(){
   			$(this).attr("value","");
   		});
    	$("#productSummary").click(function(){
   			$(this).attr("value","");
   		});
    	$("#price").click(function(){
   			$(this).attr("value","");
   		});
    	$("#defCycle").click(function(){
   			$(this).attr("value","");
   		});
    	
});
    </script>
    
    <!-- 파일업로드사이즈제한  -->
    <script>
    	$(document).on('change','input[type=file]',function(){
    		var $width = $(this).attr('data-width');
    		var $height = $(this).attr('data-height');
    		var $target = $(this);
    		
    		if(window.FileReader){
    			var reader = new FileReader();
    			reader.onload = function(e){
    				$img = $('<img>').attr({'src':e.target.result,"id":'temp_img'}).css({"height":"300px","width":"300px","display":"none"});
    				$('body').append($img);
    				let img=new Image();
    				img.onload=function(e){
        				if(e.target.width != $width && e.target.height != $height){          
        					alert('파일사이즈는 ('+$width+'x'+$height+')입니다.');
        					$target.val('');
        					$('#temp_img').remove();
        					return;
        				}
    				}
    				img.src=e.target.result;
    				    				
    			}
    			reader.readAsDataURL($(this)[0].files[0]);//파일을 img태그에 보여줄 수 있도록 base64로 url생성
    		}
    	})
    
    </script>
    
<style>

/*---------------------------------------*/
/* Font */
/*---------------------------------------*/
@import url('https://fonts.googleapis.com/css?family=Roboto');


/*---------------------------------------*/
/* Register Form */
/*---------------------------------------*/
body {
  background:linear-gradient(to bottom, #ffffff 20%, #FCF7E1 50%, #ffffff 80%);
}

.signup-form {
  font-family: "Roboto", sans-serif;
  width:750px;
  margin:30px auto;
  background:linear-gradient(to right, #ffffff 0%, #fafafa 50%, #ffffff 99%);
  border-radius: 10px;
}

/*---------------------------------------*/
/* Form Header */
/*---------------------------------------*/
.form-header  {
  background-color: #EFF0F1;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
}

.form-header h1 {
  font-size: 30px;
  text-align:center;
  color:#666;
  padding:20px 0;
  border-bottom:1px solid #cccccc;
}

/*---------------------------------------*/
/* Form Body */
/*---------------------------------------*/
.form-body {
  padding:10px 40px;
  color:#666;
}

.form-group{
  margin-bottom:20px;
}

.form-body .label-title {
  color:#1BBA93;
  font-size: 17px;
  font-weight: bold;
}

.form-body .form-input {
    font-size: 17px;
    box-sizing: border-box;
    width: 100%;
    height: 34px;
    padding-left: 10px;
    padding-right: 10px;
    color: #333333;
    text-align: left;
    border: 1px solid #d6d6d6;
    border-radius: 4px;
    background: white;
    outline: none;
}



.horizontal-group .left{
  float:left;
  width:49%;
}

.horizontal-group .right{
  float:right;
  width:49%;
}

input[type="file"] {
  outline: none;
  cursor:pointer;
  font-size: 17px;
}

#range-label {
  width:15%;
  padding:5px;
  background-color: #1BBA93;
  color:white;
  border-radius: 5px;
  font-size: 17px;
  position: relative;
  top:-8px;
}


::-webkit-input-placeholder  {
  color:#d9d9d9;
}

/*---------------------------------------*/
/* Form Footer */
/*---------------------------------------*/
.signup-form .form-footer  {
  background-color: #EFF0F1;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
  padding:10px 40px;
  text-align: right;
  border-top: 1px solid #cccccc;
  clear:both;
}

.form-footer span {
  float:left;
  margin-top: 10px;
  color:#999;  
  font-style: italic;
  font-weight: thin;
}

.btn {
   display:inline-block;
   padding:10px 20px;
   background-color: #1BBA93;
   font-size:17px;
   border:none;
   border-radius:5px;
   color:#bcf5e7;
   cursor:pointer;
}

.btn:hover {
  background-color: #169c7b;
  color:white;
}

#createbtn{
	float:right;
	color:#F2BB9C;
	font-weight:bold;
	
}
#createbtn:hover{
	color:#1BBA93;
	font-weight:bold;
}

</style>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
