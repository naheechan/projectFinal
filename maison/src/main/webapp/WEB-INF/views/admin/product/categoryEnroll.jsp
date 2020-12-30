<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<style>
	body{
		background:#D9C8A9;
	}
	.form-control{
		width:90%;
	}
	h2{
		color:#ffffff;
	}
	#Catecontainer{
		padding:10%;
		margin-bottom:10%;
		margin:auto;
        width: 450px;
        height: 250px;
        border: 1px solid #F2BB9C;
        padding-left:10px;
        position:relative;
        background:#FCF7E1;
	}
	#btn{
		float:right;
		position:relative;
		top:50px;
		color:#F2BB9C;
	}
	input{
		font-size:15px;
		line-height:25px;
	}
	select[name='largeCate']{
		font-size:15px;
		height:30px;
	}
	select[name='mediumCate']{
		font-size:15px;
		display: inline-block;
	     vertical-align: top;
	     border: solid #DCDFE3 1px;
	     margin-bottom:5%;
	     width:100px;
	}
	#Catecontainer{
		border:#F2BB9C solid 1px;
	}
	label{
		float:left;
		margin:0 0 0 3%;
	}
	i{
		color:red;
	}
	#CateArea{
		position:relative;
		top:50px
		left:80px;
	}
	#largeCate{
		position:absolute;
		left:130px;
	}
	label[name='mediumCate']{
		position:absolute;
		left:240px;	
	}
	#mediumCate{
		position:absolute;
		left:370px;
	}
	label[name='mcName']{
		position:relative;
		top:30px;
	}
	#mcName{
		position:relative;
		top:50px;
		left:20px;
	}
	#checkText{
		display:inline-block;
		margin:15% 0 0 5%;
	}
</style>
<!-- Start -->
<div class="shop-list-box">
	<div class="container">
<h2>카테고리 추가등록</h2><br>
<div id="Catecontainer">
<form action="${ path }/admin/product/enrollCate.do" name="submitForm" method="post">
<div id="CateArea" class="form-group required">
<label for="category" class="label-title">카테고리 [대]<i>*</i></label>
            <select class="form-group left" id="largeCate" name="largeCate"  style='float:left;' readonly>
            	<option value="">선택하세요</option>
            	<option value="주방">주방</option>	
            	<option value="욕실">욕실</option>
            	<option value="세탁실">세탁실</option>
            	<option value="현관">현관</option>
            	<option value="창고">창고</option>
            </select>
            
<label for="category" class="label-title" name="mediumCate">카테고리 [중]<i>*</i></label>
<select class="form-group right" id="mediumCate" name="mediumCate" size="5" style='float:right;' readonly>
	<option value="">선택하세요</option>
</select>
</div>
<br><br><br><br>
<label for="mcName" class="label-title" name="mcName">추가할 카테고리<i>*</i></label>
<input type="text"  name="mcName" id="mcName" size="54" required>
<br>
<span id="checkText"></span>
<br>
<a  class="btn" id="btn" name="addCate">등록</button>
</div>
</form>
</div>
<script>

$(function(){
	selectMediCate();
	
	/* mediumcate값과 input값 비교해서 span띄우기 보류 
	$("#mcName").blur(function(){
		var inputCate = $(this).val();
		var selectCate = $(this).parent().find("select").eq(1).children();
		var mdCate=selectCate.attr('value');
		$(this).parent().find("select").eq(1).children().each(function(){
			if(this.value==inputCate){
				$("span").append("입력하신 카테고리는 이미 존재합니다.");
				
			}
		})
	}); */
			
		
	
	$("#btn").click(function(){
		if($("#largeCate").val()==""){
				swal("","카테고리[대]를 선택하세요");
				return;
		}else{
			if($("#mcName").val()==""){
				swal("","추가할 카테고리를 입력하세요");
				return;
			}
		}
		if($("#checkText").attr('style').split(":")[1]==' green;'){
		//var insertCate = $('[name=submitForm]').serialize();
		//enrollCate(insertCate);
			enrollCate();
		}else{
			swal("","같은 이름의 카테고리명이 있습니다.","info");
		};
	});
	
	function selectMediCate(){
		$("#largeCate").change(function(){
			var largeCate = $("#largeCate").val();

			$.ajax({
				url:"${path}/admin/product/selectMedicate.do",
				data:{"large":largeCate},
				type:"post",
				dataType:"json",
				success:function(data){
					
					var mc = $("#mediumCate");
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
				},
				error:function(){
					
				}
			})
		})
	}
	function enrollCate(){
		var largeCate=$("#largeCate option:selected").val();
		var mcName=$("#mcName").val();
		$.ajax({
			url:"${ path }/admin/product/enrollCate.do",
			type:"post",
			data:{"largeCate":largeCate,"mcName":mcName},
			success:function(data){
				if(data==1){
					
					swal("","카테고리 추가 등록 성공","success");
					setTimeout(function() {
					self.close();
						}, 1000);
					
				}else{
					swal("","카테고리 추가 등록이 실패하였습니다.","info");
				}
			},
			error:function(){
				
			}
		})

	};
	
	//update 시 중복된 값 있으면 span에 띄우고 없으면 update시키기
	$(document).on("keyup","[name=mcName]",function(e){
		var name = $("#mcName").val();
		$.ajax({
			url:"${path}/admin/mypage/product/cateCheck.do",
			data:{name:name},
			type:"post",
			dataType:"json",
			success:function(data){
				
				if(data!=null){
					$("#checkText").text("해당 카테고리는 현재 존재합니다.");
					$("#checkText").css('color','tomato');
				}
			},
			error:function(data){
				
				$("#checkText").text("현재 카테고리는 사용가능합니다.");
				$("#checkText").css('color','green');
			}
		});
	});
	
	
})	

</script>
