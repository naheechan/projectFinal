<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.kh.maison.with.model.vo.WithBoard, java.util.*" %>
<%
	String[] shipment = ((WithBoard)request.getAttribute("withBoard")).getWbShip();
	List<String> shipments = new ArrayList();
	if(shipment!=null){
		shipments = Arrays.asList(shipment);
	}
%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요 상세화면"/>
</jsp:include>
<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="함께해요"/>
</jsp:include>
<style>
	.with-view-box{
		margin-top:2%;
		margin-bottom:2%;
	}
	.data-div2{
		border:1px solid lightgray;
		padding:3%;
	}
	.title {
    font-size: 14px;
    font-weight:bold;
	}
	.komen {
	    font-size:14px;
	}
	.geser {
	    margin-left:55px;
	    margin-top:5px;
	}
</style>
<!-- Start WithView Detail -->
<div class="with-view-box">
	<div class="container">
		<div class="row">
			<div class="col-lg-12" style="text-align:left;">
					<input type="hidden" id="pInput1" value="${withBoard.wbTitle }">
					
					<input type="hidden" id="pInput3" value="${withBoard.wbNo }">
					
	            	<h5 style="color:#F2BB9C;">함께해요 > <c:out value="${withBoard.wbNo }"/>번 게시물</h5>	
	                <h2>
	                	<c:if test="${withBoard.wbType eq 'free' }">
	                		[나눔]
	                	</c:if>
	                	<c:if test="${withBoard.wbType eq 'sell' }">
	                		[중고]
	                	</c:if>	
	                	
	                	<c:if test="${withBoard.wbStatus eq 'N'}">
	                		<c:out value="${withBoard.wbTitle }"/>
						</c:if>
	                	<c:if test="${withBoard.wbStatus eq 'Y'}">
	                		<span style="color:rgba(210,210,210,0.9);text-decoration-line:line-through;"><c:out value="${withBoard.wbTitle }"/></span>
						</c:if>
	                	<c:if test="${withBoard.wbStatus eq 'P'}">
	                		<c:out value="${withBoard.wbTitle }"/>
						</c:if>
	                </h2>
	                
	                <h4 id="pInput2">
	                	<c:out value="${withBoard.memberId }"/>
	                	<span style="background:#D2D2D2;padding:2px;border-radius:2px;">
	                		구매문의
	                	</span>
	                </h4>
					<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${withBoard.wbDate }"/></c:set>
	                <h5><c:out value="${dateTempParse }"/></h5>
        	</div>
        	<div class="col-lg-12" style="text-align:right;">
        		<h5 class="commentCount">댓글 갯수 </h5>
        	</div>		
		</div> 
		<div class="row data-div2">
			<div class="col-lg-12" >
				<h2>
				<c:set var="priceFormat"><fmt:formatNumber value="${withBoard.wbPrice }"/></c:set>
				<span style="font-weight:bold;"><c:out value="${priceFormat }"/> 원</span>
				&nbsp;
       			<c:if test="${withBoard.wbStatus eq 'N'}">
					<span style="color:#FA7B00;border:1px solid rgba(251,100,0,0.9);padding:1px;">판매중</span>
				</c:if>
	            <c:if test="${withBoard.wbStatus eq 'Y'}">
					<span style="color:rgba(210,210,210,0.9);border:1px solid rgba(210,210,210,0.9);padding:1px;">판매완료</span>							
				</c:if>
	            <c:if test="${withBoard.wbStatus eq 'P'}">
					<span style="color:#09CE20;border:1px solid #09CE20;padding:1px;">예약중</span>
				</c:if>				
				
				</h2>
				<br>
				<table class="table">
					<tbody>
						<tr>
							<td>상품상태</td>
							<td colspan="2">
								<c:choose>
									<c:when test="${withBoard.wbUse eq 'A' }">
										미개봉
									</c:when>
									<c:when test="${withBoard.wbUse eq 'B' }">
										거의 새 것
									</c:when>
									<c:otherwise>
										사용감 있음 
									</c:otherwise>									
								</c:choose>
							</td>
						</tr>
						<tr>
							<td>배송방법</td>
							<td colspan="2">
								
									<input type="checkbox" id="offShipment" name="wbShip" value="off" <%=shipments.contains("off")?"checked":""%> disabled="disabled">
									<label for="offShipment">직거래</label>
									&nbsp;
								
									<input type="checkbox" id="onShipment "name="wbShip" value="on" <%=shipments.contains("on")?"checked":""%> disabled="disabled">
									<label for="onShipment">택배거래</label>
																
							</td>
						</tr>
						<tr>
							<td>판매자 정보</td>
							<td>
								<c:choose>
									<c:when test="${withBoard.wbPhone eq 'N' }">
									<%-- memberId에서 조인해서 이메일 똭 --%>
										ganam0820@naver.com
									</c:when>
									<c:when test="${withBoard.wbPhone eq 'Y' }">
										ganam0820@naver.com | 01012341234
									</c:when>
								</c:choose>
								<!-- c:if로 ${loginMember.memberId }랑 withBoard.memberId가 일치할때만 얘가 뜨게 하기. -->
							</td>
							<td>	
								<form name="wbStatusUpdateForm" action="${path }/with/withStatusUpdate.do">
									<input type="hidden" value="${withBoard.wbNo }" name="wbNo">
									<select class="form-control" name="wbStatus" id="wbStatus">
										<c:choose>
											<c:when test="${withBoard.wbStatus eq 'N' }">
												<option selected value="N">판매중</option>
												<option value="P">예약중</option>
												<option value="Y">판매완료</option>
											</c:when>
											<c:when test="${withBoard.wbStatus eq 'P' }">
												<option selected value="P">예약중</option>
												<option value="N">판매중</option>
												<option value="Y">판매완료</option>												
											</c:when>
											<c:when test="${withBoard.wbStatus eq 'Y' }">
												<option selected value="Y">판매완료</option>
												<option value="N">판매중</option>												
												<option value="P">예약중</option>
											</c:when>											
										</c:choose>									
									</select>
								</form>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>
			<div class="col-lg-12" id="imgShow" style="text-align:center;">
				<textarea id="imgContent" hidden="hidden"><c:out value="${withBoard.wbContent }"/></textarea>
			</div>
		</div> 
		<br>
		<p style="float:left;" class="commentCount"><i class="far fa-comment-dots"></i>&nbsp;댓글
		2<!-- 여기에 댓글 갯수 jstl로 불러오기 -->
		</p>
		<a style="float:right;" id="reportWith">신고&nbsp;<i class="fa fa-bullhorn"></i></a>
		<br>
		<hr/>
		<div class="row">
			<div class="col-lg-12 ">
				<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
					<form name="commentInsertForm">
						<!-- value에 ${loginMember.memberId }넣기 
						${loginMember != null}조건 넣기 null이면 댓글을 쓰시려면 로그인하세요. 이런식으로 조건-->
						<input type="hidden" value="user01" name="memberId">
						<input type="hidden" value="${withBoard.wbNo }" name="wbNo" class="board_id"/>
						<label for="wcContent" style="font-weight:bold;">user01</label>
									
						<div class="form-row">
							<div class="form-group col-md-10">
								<textarea class="form-control" name="wcContent" id="reply_content" rows="3" cols="25" style="resize:none;">
									<%-- <c:out value="${loginMember.memberId }"/> --%>
								</textarea>
							</div>
							<div class="form-group col-md-2">
								<button class="btn" name="commentInsertBtn" id="reply_save" type="button" style="width:100%;height:100%;">등록</button>
							</div>
						</div>
					</form>
				</div>
				<div class="commentList">
<!-- 				 <div class="media">
				    <div class="media-body">
				      <h4 class="media-heading title">Fahmi Arif</h4>
				      <p class="komen">
				          kalo bisa ya ndak usah gan biar cepet<br>
				        <a href="#">reply</a>
				      </p>
				    </div>
				</div> -->
<!-- 				<div class="geser">
					 <div class="media">
	
					    <div class="media-body">
					      <h4 class="media-heading title">Fahmi Arif</h4>
					      <p class="komen">
					          kalo bisa ya ndak usah gan biar cepet<br>
					        <a href="#">reply</a>
					      </p>
					    </div>
					</div>
				</div> -->	
				</div>						
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12 ">
			<!-- 글쓰기 버튼은 내가 작성자가 아니어도 뜨게 -->
				<button type="button" class="btn" style="background:#F2BB9C;" onclick="location.href='${path }/with/withEnroll.do'">
					<i class='fas fa-pen'></i>&nbsp;글쓰기
				</button>&nbsp;
			<!-- 수정삭제는 ${withBoard.memberId }랑 ${loginMember.memberId }랑 일치하면 뜨게해줘야 함. -->
				<button type="button" class="btn" onclick="location.href='${path }/with/withUpdate.do?wbNo=${withBoard.wbNo }'">수정하기</button>&nbsp;
				<button type="button" class="btn" onclick="location.href='${path }/with/withRemove.do?wbNo=${withBoard.wbNo }'">삭제하기</button>
			</div>
		</div>     	
	</div>
</div>
<script>
//게시글 번호
var bno = $(".board_id").val();
//댓글 등록 버튼 클릭시
$('[name=commentInsertBtn]').click(function(){
	var insertData = $('[name=commentInsertForm]').serialize();
	commentInsert(insertData);
});
//댓글 등록 
function commentInsert(insertData){
	$.ajax({
		url:'${path }/with/replyEnroll.do',
		type:'post',
		data:insertData,
		success : function(data){
			if(data==1){
				console.log('SUCCESS');
					commentList();
				$('[name=wcContent]').val('');
			}
		}
	})
};
//yyyy/MM/dd 변환
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '년 ' + month + '월 ' + day+'일';       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
//댓글 띄우기
function commentList(){
	$.ajax({
		url:'${path }/with/replyList.do',
		type:'get',
		data:{'bno':bno},
		success:function(data){
			var dataLeng= Object.keys(data).length;
			$('.commentCount').html('<i class="far fa-comment-dots"></i> &nbsp;댓글 '+dataLeng);
			var a ='';
			$.each(data,function(key,value){
				var dateForm = new Date(value.wcAddDate);
				if(value.wcLevel==1){
					a+='<div class="media'+value.wcNo+'">';
					a+='<div class="media-body">';
					a+='<input type="hidden" name="reply_wcNo" value="'+value.wcNo+'">'
					a+='<span style="float:right;">'+getFormatDate(dateForm)+'</span>';
					a+='<h4 class="media-heading title">'+value.memberId+'</h4>';
					a+='<p class="komen">';
					a+=value.wcContent+'<br>';
					if(value.wcDel=='Y'){
						a+='<a style="float:right;" name="reply_reply" href="'+'#'+'">reply</a>';
					/* edit랑 remove는 ${loginMember.memberId }랑 value.memberId랑 일치할때만 보이게 조건 추가 필요함 */
					
						a+='<a name="reply_edit" onclick="commentUpdate('+value.wcNo+',\''+value.wcContent+'\');">edit</a>';
						a+='&nbsp;&nbsp;<a name="reply_remove" onclick="commentDelete('+value.wcNo+');">remove</a>';
					}
					a+='</p></div></div><br>';					
				}
				else{
					a+='<div class="geser">';
					a+='<div class="media'+value.wcNo+'">';
					a+='<div class="media-body">';
					a+='<input type="hidden" name="reply_wcNo" value="'+value.wcNo+'">'
					a+='<span style="float:right;">'+getFormatDate(dateForm)+'</span>';
					a+='<h4 class="media-heading title">ㄴ&nbsp;'+value.memberId+'</h4>';
					a+='<p class="komen">';
					a+=value.wcContent+'<br>';
					/* edit랑 remove는 ${loginMember.memberId }랑 value.memberId랑 일치할때만 보이게 조건 추가 필요함 */
					if(value.wcDel=='Y'){
						a+='<a name="reply_edit" onclick="commentUpdate('+value.wcNo+',\''+value.wcContent+'\');">edit</a>';
						a+='&nbsp;&nbsp;<a name="reply_remove" onclick="commentDelete('+value.wcNo+');">remove</a>';						
					}
					a+='</p></div></div></div><br>';	
				}
				
			});
			$(".commentList").html(a);
		}
	});
}

$(document).ready(function(){
	$("#imgShow").html($("#imgContent").val());
	commentList();
});

//reply 눌렀을때 대댓글 작성 div 띄우기
$(document).on("click","a[name='reply_reply']",function(){
	/* user01 loginMember session에 저장해놓은거 써야함. */
	var par= $(this).parent().parent().parent();
	var sib= $(this).parent().siblings("input[name='reply_wcNo']").val();
	console.log(sib);
	var b = '';
	b+='<div style="margin-left:55px;">'
	b+='<form name="commentInsertFormSecond">';
	b+='<input type="hidden" value="'+sib+'" name="wcParent"/>';
	b+='<input type="hidden" value="'+'user01'+'" name="memberId"/>';
	b+='<input type="hidden" value="'+bno+'" name="wbNo"/>';
	b+='<label for="wcContent" style="font-weight:bold;">'+'ㄴ&nbsp;'+'user01'+'</label>';
	b+='<div class="form-row"><div class="form-group col-md-9">';
	b+='<textarea class="form-control" name="wcContent" rows="3" cols="25" style="resize:none;"></textarea>';
	b+='</div>';
	b+='<div class="form-group col-md-2">';
	b+='<button class="btn" name="second" type="button" style="width:100%;height:100%;">대댓글</button>';
	b+='</div></div></form></div>';
	$(par).after(b);
	$("a").remove("[name='reply_edit']");
	$("a").remove("[name='reply_remove']");
})
//대댓글 등록 버튼 클릭시
$(document).on("click","button[name=second]",function(){
	var insertDataSecond = $('[name=commentInsertFormSecond]').serialize();
	commentInsertSecond(insertDataSecond);	
})
//대댓글 등록 
function commentInsertSecond(insertDataSecond){
	$.ajax({
		url:'${path }/with/replyEnrollSecond.do',
		type:'post',
		data:insertDataSecond,
		success : function(data){
			if(data==1){
				commentList();
				$('div').remove('.reply_div');
			}
		}
	})
};

//댓글 삭제
function commentDelete(wcNo){
	$.ajax({
		url:'${path }/with/replyRemove.do?no='+wcNo,
		type:'post',
		success:function(data){
			if(data==1) commentList();
		}
	})
}

//댓글 수정 
//a태그에서 onclick function으로 wcNo, wcContent, memberId, wcLevel4개 보내줌
function commentUpdate(wcn,wcc){

	var c ='';
		c+='<div>';
		c+='<form name="commentUpdateForm">';
		/* 잊지말자 아이디는 세션값을 저장해둔 애로 불러오는거다*/
		c+='<input type="hidden" value="'+'user01'+'" name="memberId"/>';
		c+='<input type="hidden" value="'+wcn+'" name="wcNo"/>';
		c+='<label for="wcContent" style="font-weight:bold;">'+'user01'+'</label>';
		c+='<div class="form-row"><div class="form-group col-md-10">';
		c+='<textarea class="form-control" name="content_'+wcn+'" rows="3" cols="25" style="resize:none;">'+wcc+'</textarea>';
		c+='</div>';
		c+='<div class="form-group col-md-2">';
		c+='<button class="btn" type="button" style="width:100%;height:45%;margin-bottom:4%;background:#FCF7E1;"';
		c+='onclick="commentUpdateCancle();">취소</button>';
		c+='<button class="btn" type="button" style="width:100%;height:45%;background:#F2BB9C;"';
		c+='onclick="commentUpdateProc('+wcn+');">수정</button>';
		c+='</div></div></form></div>';
		
		$('.media'+wcn).html(c);
}

//댓글수정 취소
function commentUpdateCancle(){
	commentList();
}
//댓글수정 
function commentUpdateProc(wcNo){
	var updateContent = $('[name=content_'+wcNo+']').val();
	$.ajax({
		url : '${path }/with/replyUpdate.do',
		type : 'post',
		data : {'content' : updateContent , 'cno' : wcNo},
		success : function(data){
			if(data == 1) commentList();
		}
	})
}

//판매상태 변경 
$(function(){
	$('#wbStatus').on('change',function(){
		$(this).closest('form[name=wbStatusUpdateForm]').submit();
	})
})

//신고하기 자식창켜기 
var openWin;

$('#reportWith').click(function(){
	//window.name = "부모창 이름";
	window.name = "parentForm";
	//window.open("open할 window","자식창 이름","팝업창 옵션");
	openWin = window.open('${path }/with/reportEnroll.do?bno='+bno,'신고하기','width=440,height=320,scrollbars=no,left=200,top=50,resizable=no');
	//제목(pInput1), 작성자(pInput2), wbNo(pInput3)
	// 보안상의 이유로 프론트에서 자식창을 열면서 바로 부모창의 값을 자동으로 전달해주는건 불가능
	// 부모창의 
});


	
</script>
<!-- End WithView Detail -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	