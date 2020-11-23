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
	            	<h5 style="color:#F2BB9C;">함께해요 > <c:out value="${withBoard.wbNo }"/>번 게시물</h5>	
	                <h2>
	                	<c:if test="${withBoard.wbType eq 'free' }">
	                		[나눔]
	                	</c:if>
	                	<c:if test="${withBoard.wbType eq 'sell' }">
	                		[중고]
	                	</c:if>	
	                	<c:out value="${withBoard.wbTitle }"/>
	                	<c:if test="${withBoard.wbStatus eq 'N'}">
							<span style="color:#FA7B00;border:1px solid rgba(251,100,0,0.9);padding:1px;">판매중</span>
						</c:if>
	                </h2>
	                
	                <h4><c:out value="${withBoard.memberId }"/></h4>
					<c:set var="dateTempParse"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${withBoard.wbDate }"/></c:set>
	                <h5><c:out value="${dateTempParse }"/></h5>
        	</div>
        	<div class="col-lg-12" style="text-align:right;">
        		<h5>댓글 갯수 몇개 </h5>
        	</div>		
		</div> 
		<div class="row data-div2">
			<div class="col-lg-12" >
				<c:set var="priceFormat"><fmt:formatNumber value="${withBoard.wbPrice }"/></c:set>
				<h2 style="font-weight:bold;"><c:out value="${priceFormat }"/> 원</h2>
				<br>
				<table class="table">
					<tbody>
						<tr>
							<td>상품상태</td>
							<td>
								<c:choose>
									<c:when test="${withBoard.wbUse eq 'A' }">
										미개봉
									</c:when>
									<c:when test="${withBoard.wbUse eq 'A' }">
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
							<td>
								
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
		<p style="float:left;"><i class="far fa-comment-dots"></i>&nbsp;댓글
		2<!-- 여기에 댓글 갯수 jstl로 불러오기 -->
		</p>
		<a style="float:right;">신고&nbsp;<i class="fa fa-bullhorn"></i></a>
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
			var a ='';
			$.each(data,function(key,value){
				var dateForm = new Date(value.wcAddDate);
				if(value.wcLevel==1){
					a+='<div class="media">';
					a+='<div class="media-body">';
					a+='<input type="hidden" name="reply_wcNo" value="'+value.wcNo+'">'
					a+='<span style="float:right;">'+getFormatDate(dateForm)+'</span>';
					a+='<h4 class="media-heading title">'+value.memberId+'</h4>';
					a+='<p class="komen">';
					a+=value.wcContent+'<br>';
					a+='<a style="float:right;" name="reply_reply" href="'+'#'+'">reply</a>';
					a+='<a name="reply_edit" href="#">edit</a>';
					a+='&nbsp;&nbsp;<a name="reply_remove" href="#">remove</a>';
					a+='</p></div></div><br>';					
				}
				else{
					a+='<div class="geser">';
					a+='<div class="media">';
					a+='<div class="media-body">';
					a+='<input type="hidden" name="reply_wcNo" value="'+value.wcNo+'">'
					a+='<span style="float:right;">'+getFormatDate(dateForm)+'</span>';
					a+='<h4 class="media-heading title">ㄴ&nbsp;'+value.memberId+'</h4>';
					a+='<p class="komen">';
					a+=value.wcContent+'<br>';
					a+='<a name="reply_edit" href="#">edit</a>';
					a+='&nbsp;&nbsp;<a name="reply_remove" href="#">remove</a>';
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
				console.log('SUCCESS');
					commentList();
				$('div').remove('.reply_div');
			}
		}
	})
};

	
</script>
<!-- End WithView Detail -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	