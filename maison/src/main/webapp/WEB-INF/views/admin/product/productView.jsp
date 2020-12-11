<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="상품등록" />
</jsp:include>
<script src="${ path }/ckeditor/ckeditor.js"></script>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="상품등록" />
</jsp:include>

<!-- Start -->
<div class="shop-list-box">
	<div class="container">
		<div class="row">
			<div class="col-xl-5 col-lg-5 col-md-6"></div>
		</div>
	</div>
</div>
<!-- End -->
    <form class="signup-form" action="" method="post"   enctype="multipart/form-data">

      <!-- form header -->
      <div class="form-header">
        <h1>상품등록</h1>
      </div>

      <!-- form body -->
      <div class="form-body">
<%--        <c:forEach items="${list}" var="list" begin="1" end="1">
 --%>
        <!-- Category -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="category" class="label-title">카테고리 [대]*</label>
            <select class="form-control" id="largeCate" name="largeCate" readonly>
            	<option value="${list.largeCate}">${list.largeCate}</option>
           
            </select>
          </div>
          <div class="form-group right" id="category1">
            <label for="category" class="label-title">카테고리 [중]*</label>
            <select class="form-control" id="mediumCate" name="mediumCate" readonly>
            <option value="${list.mcName}">${list.mcName }</option>
            </select>
          </div>
        <!-- Ajax -->
        <div class="horizontal-group">
          <div class="form-group left">
          	<span id="cateText">선택한 카테고리:</span>
          	<span id="cateText1">${list.largeCate } ></span>
          	<span id="cateText2">${list.mcName }</span>
          </div>
          <div class="form-group right">
			<a id="createbtn">카테고리등록</a>
          </div>
        </div>
        
		<!-- Name -->
        <div class="form-group">
          <label for="productName" class="label-title">상품이름 *</label>
          <input type="text" name="productName" id="productName" class="form-input" placeholder="enter product name"  
          value="${list.productName }" readonly>
        </div>
		
		<!-- Summary -->
        <div class="form-group">
          <label for="text" class="label-title">상품요약설명 *</label>
          <input type="text" name="productSummary" id="productSummary" class="form-input" placeholder="enter product summary"
          value="${list.productSummary }" readonly>
        </div>
        
        <!--editor  -->
        	<div class="form-group">
        	<label for="productContent" class="label-title">상품상세페이지 *</label>
        	<textarea id="productContent" name="productContent" rows="10" cols="80" 
        	placeholder="내용을 입력하세요" >${list.productContent}</textarea>
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
            <input type="file" name="imageFile" id="productImg" size="80" accept=".jpg, .jpeg, .png, .bmp" data-width="300" data-height="300">
          </div>
          </div>
          
        <!-- Price & StockCount -->
        <div class="horizontal-group">
          <div class="form-group left" >
             <label for="price" class="label-title">상품가격 *</label>
            <input type="number" name="price" id="price" class="form-input" placeholder="원"  value="${list.price }" readonly>
          </div>
          <div class="form-group right">
            <label for="productStock" class="label-title">재고수량 *</label>
            <input type="range" min="0" max="1000" step="10"  value="0" name="productStock" id="productStock" class="form-input" value="${list.productStock }" 
            onChange="change();" style="height:28px;width:78%;padding:0;" readonly>
            <br>
            <span id="range-label">${list.productStock }</span>
          </div>
        </div>	
        
        <!-- ProductStatus -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="productStatus" class="label-title">판매상태 *</label><br>
            <input type="radio" id="productStatusY" name="productStatus" ${list.productStatus eq 'Y'?'checked':'' } >예
            <input type="radio" id="productStatusN" name="productStatus" ${list.productStatus eq 'N'?'checked':''}>아니오
          </div>
          <!-- DefCycle -->
          <div class="form-group left">
          <label for="defCycle" class="label-title">주기일 *</label><br>
            <input type="number" name="defCycle" id="defCycle" class="form-input"  value="${list.defCycle }" readonly>
          </div>

		<!-- mediumCate -->
        <div class="form-group right">
          <input type="hidden" name="mediumCate" id="mediHidden" class="form-input" value="">
        </div>
        </div></div>
      <!-- form-footer -->
      <div class="form-footer">
        <span>* required</span>
        <button type="button" class="btn" id="viewSubmit">수정</button>
      </div>
    <%-- </c:forEach> --%>
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
    
    <script>
   
   		$("#viewSubmit").click(function(){
   			
    		if(confirm("수정하시겠습니까?")){
    			location.href="${path}/admin/product/update.do";
    		}
   		});
	   		
    	//상품이미지 보이게
    	
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



</style>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
