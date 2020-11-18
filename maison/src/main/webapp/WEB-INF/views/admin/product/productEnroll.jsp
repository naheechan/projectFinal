<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="상품등록" />
</jsp:include>

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
    <form class="signup-form" action="/register" method="post">

      <!-- form header -->
      <div class="form-header">
        <h1>상품등록</h1>
      </div>

      <!-- form body -->
      <div class="form-body">

        <!-- Category -->
        <div class="horizontal-group">
          <div class="form-group left">
            <label for="category" class="label-title">카테고리 [대]*</label>
            <select class="form-control" id="largeCate" name="category" onchange="categoryChange()">
            	<option value="">선택하세요</option>
            	<option value="주방">주방</option>
            	<option value="욕실">욕실</option>
            	<option value="세탁실">세탁실</option>
            	<option value="현관">현관</option>
            	<option value="창고">창고</option>
            </select>
          </div>
          <div class="form-group right">
            <label for="category" class="label-title">카테고리 [중]*</label>
            <select class="form-control" id="mediumCate" name="category">
            <option value="">선택하세요</option>
            </select>
          </div>
        </div>
        <!-- Ajax -->
        <div class="horizontal-group">
          <div class="form-group left">
          	<span id="cateText">선택한 카테고리:</span>
          </div>
          <div class="form-group right">
			<a id="createbtn" href="#">카테고리등록</a>
          </div>
        </div>
        
		<!-- Name -->
        <div class="form-group">
          <label for="productName" class="label-title">상품이름 *</label>
          <input type="text" id="productName" class="form-input" placeholder="enter product name" required="required">
        </div>
		
		<!-- Summary -->
        <div class="form-group">
          <label for="text" class="label-title">상품요약설명 *</label>
          <input type="text" id="productSummary" class="form-input" placeholder="enter product summary" required="required">
        </div>
        
         <!-- Image -->
        <div class="horizontal-group">
          <div class="form-group left" >
            <label for="productImg" class="label-title">상품이미지 *</label>
            <input type="file" id="productImg" size="80">
          </div>
          <!-- ProductStatus -->
          <div class="form-group right">
            <label for="productStatus" class="label-title">판매상태 *</label><br>
            <input type="radio" id="productStatusY" name="status" value="예" checked>예
            <input type="radio" id="productStatusN" name="status" value="아니오">아니오
          </div>
          <!-- mediumCate -->
          <div class="form-group right">
            <input type="hidden" id="mediumCate" class="form-input">
          </div>
		</div>
		
		
        <!-- Price & StockCount -->
        <div class="horizontal-group">
          <div class="form-group left" >
             <label for="price" class="label-title">상품가격 *</label>
            <input type="number" id="price" class="form-input" placeholder="원">
          </div>
          <div class="form-group right">
            <label for="productStock" class="label-title">재고수량 *</label>
            <input type="range" min="0" max="1000" step="10"  value="0" id="productStock" class="form-input" onChange="change();" style="height:28px;width:78%;padding:0;">
            <br>
            <span id="range-label">0</span>
          </div>
        </div>	
        
        <!--editor  -->
        
        
	</div>
      <!-- form-footer -->
      <div class="form-footer">
        <span>* required</span>
        <button type="submit" class="btn">등록</button>
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
    
    
    <!-- select option fn -->
    <script>
    function categoryChange() {
        var kitchen= ["주방세제", "홍대", "영등포", "여의도"];
        var bath = ["치약", "칫솔", "폼클렌징"];
        var laundry = ["세제", "섬유유연제", "표백제"];
        var door = ["에프킬라","방향제"];
		var storage = ["마스크","기저귀"];
       
        var selectItem = $("#largeCate").val();
        
        var changeItem;
          
        if(selectItem == "주방"){
          changeItem = kitchen;
        }
        else if(selectItem == "욕실"){
          changeItem = bath;
        }
        else if(selectItem == "세탁실"){
          changeItem =  laundry;
        }
        else if(selectItem == "현관"){
            changeItem = door;
          }
          else if(selectItem == "창고"){
            changeItem =  storage;
          }
         
        $("#mediumCate").empty();
         
        for(var count=0; count<changeItem.size(); count++){                
                        var option = $("<option>"+changeItem[count]+"</option>");
                        $("#mediumCate").append(option);
                    }
    }
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
  width:650px;
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
