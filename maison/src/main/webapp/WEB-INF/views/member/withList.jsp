<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 관리"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요 관리  / 적립금 관리"/>
</jsp:include>
<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Start Mypage wishList-->
<section>
	<div class="container">
		<div class="row">
			<!-- SideMenu div -->
			<div class="col-lg-3 col-md-5">
				<jsp:include page="/WEB-INF/views/member/mypageSide.jsp"/>
			</div>
			<div class="col-lg-9 col-md-7">		
				<br/>
				<h2>함께해요 관리</h2>
				<hr>			
				<div class="data-div">
					<div class="row">
						<div class="col-lg-12">
							<div class="table-main table-responsive">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td>
												<span>
													<input type="hidden" value="${loginMember.memberId }" id="hidenId"> 
													<span style="font-size:1.5rem;color:black;"><strong><c:out value="${loginMember.memberName }"/></strong></span> 님의 총 게시글은 
													<span style="font-size:1.1rem;color:#d00;" id="boardCountSpan"><c:out value="${withBoardTotalCount }"/></span>개 이며, 총 댓글은
													<span style="font-size:1.1rem;color:#d00;" id="commentCountSpan"><c:out value="${withCommentTotalCount }"/></span>개 입니다.
												</span>
												

											</td>
										</tr>
									</tbody>
								</table>
							</div>	
							<br>
							<div class="special-menu text-left">
			                    <a style="font-size:1.1rem" id="bringallwith">작성글&nbsp;&nbsp;</a> | &nbsp;
			                    <a style="font-size:1.1rem" id="bringallcomment">작성댓글&nbsp;&nbsp;</a> | &nbsp;
			                    <a style="font-size:1.1rem" id="bringcommentedwith">댓글 단 글</a>
			                </div>	
			               	<div class="table-main table-responsive">
								<table class="table table-hover">
									<thead id="tbl-withList-thead" style="text-align:center;">
										
										
										
									</thead>
									<tbody id="tbl-withList-tbody">
										
									
									
									</tbody>
								</table>
							</div>				
						</div>
						
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div id="button-div">
								

							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div id="pageBar-div">
							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- End Mypage wishList -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		
<script>
//페이지 로딩되자마자 내 게시글 가져와서 띄우고, 작성글 a태그 색깔 바꾸기
$(document).ready(function(){
	bringAllWithBoard();
})

//멤버아이디
var hidenId = $("#hidenId").val();

//작성글 불러오는 함수
function bringAllWithBoard(){
	$.ajax({
		url:'${path }/member/bringAllWithBoard.do',
		type:'get',
		data:{'memberId':hidenId},
		dataType:'json',
		success:function(data){
			//0이 리스트, 1이 totalContents, 2가 pageBar
			var ah='';
			var ab='';
			var b='';
			var c='';
			var d ='';

			$.each(Object.values(data)[0],function(index,item){
				var dateForm = new Date(item.wbDate);
				ab+='<tr>';
				ab+='<td>'+item.wbNo+'</td>';
				ab+='<td><input type="checkbox" name="checkfordelete" value="'+item.wbNo+'"></td>';
				ab+='<td><a href="${path }/with/withView.do?no='+item.wbNo+'">'+item.wbTitle+'</a></td>';
				ab+='<td style="text-align:center;">'+getFormatDate(dateForm)+'</td>';
				ab+='<td style="text-align:center;">'+item.wbCount+'</td>';
				ab+='</tr>';
			})
			ah+='<th colspan=3>제목</th>';
			ah+='<th>작성일</th>';
			ah+='<th>조회</th>';
			$("#tbl-withList-thead").html(ah);
			$("#tbl-withList-tbody").html(ab);
			//마치 a태그가 선택된것처럼 보이게 다른거 선택했을때 반드시 색 빼주기
			$("#bringallwith").css('color','#F2BB9C');
			$("#bringallcomment").css('color','#666666');
			$("#bringcommentedwith").css('color','#666666');
			//상단에 총 게시글수에 올려주기 
 			b+=Object.values(data)[1];
			$("#boardCountSpan").html(b);
			//상단에 총 댓글수에 올려주기
/* 			d+=Object.values(data)[3];
			$("#commentCountSpan").html(d); */
			//페이지바 
			c+='<br/>';
			c+=Object.values(data)[2];
			c+='<br/>';
			$("#pageBar-div").html(c);
			d+='<br/>';
			d+='<button type="button" class="btn" style="float:right;margin-left:1%;" onclick="bringAllBoardDelete()">삭제하기</button>';
			d+='<button type="button" class="btn" style="background:#F2BB9C;float:right;"';
			d+='onclick="writeWithBoard()">';
			d+='<i class="fas fa-pen"></i>&nbsp;글쓰기';
			d+='</button>&nbsp;';
			$("#button-div").html(d);
		}	
	})
}


//bringallcomment버튼 클릭했을때 아래 내용 바꾸기
$(function(){
	$("#bringallcomment").on('click',function(){
		var d = $("#hidenId").val();
		bringAllComment(d);
		
	})
});

//작성글에서 체크박스에 체크한 애 삭제하고, 작성글 페이지 리로드
function bringAllBoardDelete(){
	var lists = [];
	$("input[name='checkfordelete']:checked").each(function(i){
		lists.push($(this).val());
	});
	$.ajax({
		url:'${path }/member/deleteBringAllWith.do',
		data:{'checkfordelete':lists},
	   contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   cache: false,
	   success:function(data) {
		   if(data==1){
	       	swal("성공적으로 삭제되었습니다.","함께해요 관리 페이지를 리로드합니다.","success");
	    	bringAllWithBoard();   
		   }
	     },
	   error:function(e){
		   swal("게시글 삭제실패!","관리자에게 문의하세요.","error");
	   }
	})
	
}

//모든 댓글 불러오기
function bringAllComment(d){
	$.ajax({
		url : '${path }/member/bringAllWithComment.do',
		type:'post',
		data:{'memberId':d},
		success:function(data){
			var ah='';
			var ab='';
			var b='';
			var c='';
			var g ='';
			var f='';
			$.each(Object.values(data)[0],function(index,item){
				var dateForm = new Date(item.wcAddDate);
				ab+='<tr>';
				ab+='<td><input type="checkbox" name="checkStatus" value="'+item.wcNo+'"></td>';
				ab+='<td>'+item.wcContent+'</td>';
				ab+='<td class="targetTd'+item.wbNo+'"></td>'; 
				deletedWithBoard(item.wbNo);
				ab+='<td style="text-align:center;">'+getFormatDate(dateForm)+'</td>';
				ab+='</tr>';				
			})
			ah+='<th colspan=3>댓글</th>';
			ah+='<th>작성일</th>';
			$("#tbl-withList-thead").html(ah);
			$("#tbl-withList-tbody").html(ab);
			//마치 a태그가 선택된것처럼 보이게 다른거 선택했을때 반드시 색 빼주기
			$("#bringallwith").css('color','#666666');
			$("#bringallcomment").css('color','#F2BB9C');
			$("#bringcommentedwith").css('color','#666666');
			//페이지바 
			c+='<br/>';
			c+=Object.values(data)[2];
			c+='<br/>';
			$("#pageBar-div").html(c);
			//리로드될때 상단에 댓글 갯수 변경 되게
			g+=Object.values(data)[1];
			$("#commentCountSpan").html(g);
			//버튼
			f+='<br/>';
			f+='<button type="button" class="btn" style="float:right;margin-left:1%;" onclick="bringAllCommentDelete();">삭제하기</button>';
			f+='<button type="button" class="btn" style="background:#F2BB9C;float:right;"';
			f+='onclick="writeWithBoard()">';
			f+='<i class="fas fa-pen"></i>&nbsp;글쓰기';
			f+='</button>&nbsp;';
			$("#button-div").html(f);		

		}
	})
}

//작성댓글에서 체크박스 체크한 애 삭제하고, 작성댓글 페이지 리로드
function bringAllCommentDelete(){
	var d = $("#hidenId").val();
	var lists = [];
	$("input[name='checkStatus']:checked").each(function(i){
		lists.push($(this).val());
		console.log(lists);
	});
	$.ajax({
		url:'${path }/member/deleteBringAllWithComment.do',
		data:{'checkStatus':lists},
	   contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   cache: false,
	   success:function(data) {
		   if(data==1){
	       	swal("성공적으로 삭제되었습니다.","함께해요 관리 페이지를 리로드합니다.","success");
	       	bringAllComment(d); 
		   }
	     },
	   error:function(e){
		   swal("댓글 삭제실패!","관리자에게 문의해주세요.","error");
	   }
	})
	
}

//글쓰기로 바로 이동하기
function writeWithBoard(){
	  window.location.href = "${path }/with/withEnroll.do";
}


//댓글에 관련된 게시글 삭제 여부 가져오기
function deletedWithBoard(wbNo){
	var ac="";
	$.ajax({
		url:'${path }/member/deletedWithBoard.do',
		type:'post',
		data:{'wbNo':wbNo},
		success:function(data){
			if(data.wbDel=='Y'){
				ac+='<a href="${path }/with/withView.do?no='+data.wbNo+'">게시글 바로가기</a>';
			}else{
				ac+='삭제된 게시글';
			}
			$(".targetTd"+wbNo).html(ac);
		},
		error:function(e){
			console.log('에러발생 - 관리자에게 문의하세요.');
		}
	});
}


//bringallwith버튼 클릭했을때 아래 내용 다시 작성글로 바꾸기
$(function(){
	$("#bringallwith").on('click',function(){
		bringAllWithBoard();
	})
});

//bringcommentedwith댓글단글 버튼 누르면 댓글단글 보이기
$(function(){
	$("#bringcommentedwith").on('click',function(){
		var d = $("#hidenId").val();
		bringCommentedWith(d);
	})
})

function bringCommentedWith(d){
	$.ajax({
		url:'${path }/member/bringCommentedWith.do',
		type:'post',
		data:{'memberId':d},
		success:function(data){
			var ah='';
			var ab='';
			var b='';
			var c='';
			var d ='';
			var f='';
			$.each(Object.values(data)[0],function(index,item){
				var dateForm = new Date(item.wbDate);
				ab+='<tr>';
				ab+='<td>'+item.wbNo+'</td>';
				ab+='<td>'+item.wbTitle+'</td>';
				ab+='<td style="text-align:center;">'+item.memberId+'</td>';
				ab+='<td style="text-align:center;">'+getFormatDate(dateForm)+'</td>';
				ab+='<td style="text-align:center;">'+item.wbCount+'</td>';
				ab+='</tr>';				
			})
			ah+='<th colspan=2>제목</th>';
			ah+='<th>작성자</th>';
			ah+='<th>작성일</th>';
			ah+='<th>조회</th>';
			$("#tbl-withList-thead").html(ah);
			$("#tbl-withList-tbody").html(ab);
			//마치 a태그가 선택된것처럼 보이게 다른거 선택했을때 반드시 색 빼주기
			$("#bringallwith").css('color','#666666');
			$("#bringallcomment").css('color','#666666');
			$("#bringcommentedwith").css('color','#F2BB9C');
			//페이지바 
			c+='<br/>';
			c+=Object.values(data)[2];
			c+='<br/>';
			$("#pageBar-div").html(c);
			//버튼
			f+='<br/>';
			f+='<button type="button" class="btn" style="background:#F2BB9C;float:right;"';
			f+='onclick="writeWithBoard()">';
			f+='<i class="fas fa-pen"></i>&nbsp;글쓰기';
			f+='</button>&nbsp;';
			$("#button-div").html(f);
		}
	})
}

//yyyy/MM/dd 변환
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '- ' + month + '- ' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

</script>