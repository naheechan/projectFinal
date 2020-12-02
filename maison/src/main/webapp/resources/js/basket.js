

//전체체크/전체해제
	function allChecked() {
		var checked = $("#allCheck").prop("checked")
		console.log(checked);
		console.log($("input:checkbox[name=basketChecked]").prop("checked"));
		if (checked == true) {
			$("input:checkbox[name=basketChecked]").prop("checked", true);
		}
		if (checked == false) {
			$("input:checkbox[name=basketChecked]").prop("checked", false);
		}
	};
	
	/*$(function(){
		
		$("input[name=amount]").bind('keyup mouseup',function(e){
			
			//수량변경된 배스킷번호랑 수량을 받아와야함
			var amount=$(this).val();
			var basketNo=$(this).next().val();
			
			console.log(basketNo+" : "+amount);
			
			//그 받아온 값을 넘겨줘서 업데이트 후 다시 배스킷정보를 받아와야함
			 	$.ajax({
	    		
	    		url: "/basket/upDown.do",
	    		data : {
		    			basketNo:basketNo,
		    			amount : amount
	    				},
	    		dataType : "json",
	    		//받아온 배스킷 정보를 다시 테이블에 쏴줌
	    		success : data=>{
	    			console.log(data)
	    		},
	    		error : function(){
	    			
	    		}
	    		
	    	});
			
			
			
			
			
			//배스킷 다시 불러온 후 합계 다시 정산하는 것
			var p=$(".pTotal");
			var prtotal=0;
			$(".pTotal").each(function(){
				var val=$(this).prop("innerHTML");
				
				var val2=Number((val.substring(0,val.length-1)).trim());
				prtotal+=val2;
			})
			$(".subTotal").html(prtotal+"원");
			
			$(".grandTotal").html(prtotal+"원");
			
		});
	});*/

    $(function(){ 
    	var p=$(".pTotal");
    	var prtotal=0;
    	$(".pTotal").each(function(){
    		var val=$(this).prop("innerHTML");
    		
    		var val2=Number((val.substring(0,val.length-1)).trim());
    		prtotal+=val2;
    	})
  	
    	console.log(prtotal);
    	$(".subTotal").html(prtotal+"원");
		
    	$(".grandTotal").html(prtotal+"원");
    	
    	
    }); 
					
   
								