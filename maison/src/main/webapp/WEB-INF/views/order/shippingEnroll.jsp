<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div id="u_skip">
        <a href="#pop_wrap"><span class="blind">본문바로가기</span></a>
    </div>
    <!-- //u_skip -->
<link type="text/css" rel="stylesheet" href="https://ssl.pstatic.net/static.pay/u/c/static/202012171558/css/setting/popup_setting.css">

<div id="pop_wrap">
    <!-- pop_header -->
    <div style="background-color: rgb(234,234,234);height: 50px;text-align: center;">
        <span style="width: 60px;height: 49px;"><img src="${path }/resources/images/logo2.png" class="logo" style="width: 60px; height:49px; float: left;"></span>
        <h1 class="text-info" style="padding-top: 10px;">배송지 등록/수정</h1>
        <span><button type="button" class="popup_img popup_close" onclick="window.close();" style="float: right;"><span class="blind">팝업 닫기</span></button></span>
    </div>

    <!-- //pop_header -->
    <div id="pop_container">
        <div id="pop_content">
            <div class="setting_popup_title">
                <h2 class="h_title">배송지 정보 상세</h2>
            </div>
            <table class="tbl_delivery_info">
                <caption><span class="blind">배송지 정보 입력 폼</span></caption>
                <colgroup>
                    <col class="cell_title">
                    <col>
                </colgroup>
              	<form action="${path }/order/insertShippingEnrollEnd.do">
                <tbody>
                <tr>
                    <th class="cell_title">배송지명</th>
                    <td>
                        <!-- [D] 텍스트 입력을 위해 input으로 focus가 이동 된 경우, span.basic_input에 클래스 focus 추가 -->
                        <!-- [D] 텍스트 입력 불가 시, span.basic_input에 클래스 disabled 추가 및 input.ip_text에 disabled="disabled" 추가 -->
                        <span class="_editable_input _input basic_input" style="width: 133px">
                            <label for="addressName" class="lb_text blind">배송지명 입력</label>
                            <input type="text" name="sdName" id="addressName" class="ip_text" maxlength="150">
                            <input type="hidden" id="hash" class="ip_text" value="">
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="cell_title">수령인 <em class="mark_necessity"><span class="blind">필수입력</span></em></th>
                    <td>
                        <span class="_editable_input _input basic_input" style="width: 133px">
                            <!-- [D] input.ip_text에 텍스트 입력 시 label.lb_text에 클래스 blind 추가 -->
                            
                            <input type="text" name="receiver" id="receiver" class="ip_text" value="" maxlength="150">
                        </span>
                    </td>
                </tr>
                <tr>
                    <th class="cell_title">주소 <em class="mark_necessity"><span class="blind">필수입력</span></em></th>
                    <td>
                                <span class="_input basic_input" style="width: 64px">
								<label for="zipCode" class="lb_text blind">우편번호 입력</label>
								<input type="text" name="orZipcode" id="zipCode" class="ip_text">
							</span>
							<button type="button" class="btn" onclick="findAddress();">주소찾기</button>
                        <p class="address_detail">
                                    <span class="_input basic_input" style="width: 338px">
									<label for="baseAddress" class="lb_text blind">배송지 새주소</label>
									<input type="text" name="orAddress" id="baseAddress" class="ip_text">
									<input type="hidden" id="roadNameAddressYn" value="">
								</span>
                        </p>
                        <p class="address_detail">
                                    <span class="_editable_input _input basic_input" style="width: 338px">
								
									
									<input type="text" name="orDetailAddress" id="detailAddress" class="ip_text" value="" maxlength="100">
								</span>
                        </p>
                    </td>
                </tr>
                <tr>
                    <th class="cell_title">연락처 <em class="mark_necessity"><span class="blind">필수입력</span></em></th>
                    <td>
                        <span class="_editable_input _input basic_input" style="width: 130px">
							<label for="telNo1Second" class="lb_text blind">연락처</label>
							<input type="text" name="orPhone" id="telNo1Second" class="ip_text" maxlength="11" value="">
						</span>
                        
                    </td>
                </tr>
                
                <!-- <tr>
                    <th class="cell_title">기본배송지</th>
                    <td>
                        <span class="default_delivery">
                        [D] 체크박스 클릭 시 span.setting_checkbox에 클래스 checked 추가 및 input에 checked="checked" 추가
                        <span>
                            <input type="checkbox" name="status" id="baseAddressYn" value="">
                        </span>
                        <label for="baseAddressYn" class="lb_text">기본 배송지로 설정</label>
                        </span>
                    </td>
                </tr> -->
                <!-- <script>
                	$(function(){
                		$("#enrollFrm").click(function(){
	                		if($("[name=status]").is(":checked")){
	                			$("[name=status]").val('y');
	                		}else{
	                			$("[name=status]").val('n');
	                		}
                			
                		})
                	})
                </script> -->
                </tbody>
            </table>
            <div class="delivery_notice">
                <p class="desc">· 입력/수정하신 배송지는 배송지 목록에 저장됩니다.</p>
            </div>
        </div>
    </div>
	 <div id="pop_footer">
	        <button type="button" class="button" onclick="javascript:window.close();return false;">닫기</button>
	        <button type="submit" class="_btn_save button" id="enrollFrm">저장</button>
   	 </div>
    </form>
</div>

<script>
								function findAddress() {
									new daum.Postcode(
											{
												oncomplete : function(data) {
													// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

													// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
													// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
													var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
													var extraRoadAddr = ''; // 도로명 조합형 주소 변수

													// 법정동명이 있을 경우 추가한다. (법정리는 제외)
													// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
													if (data.bname !== ''
															&& /[동|로|가]$/g
																	.test(data.bname)) {
														extraRoadAddr += data.bname;
													}
													// 건물명이 있고, 공동주택일 경우 추가한다.
													if (data.buildingName !== ''
															&& data.apartment === 'Y') {
														extraRoadAddr += (extraRoadAddr !== '' ? ', '
																+ data.buildingName
																: data.buildingName);
													}
													// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
													if (extraRoadAddr !== '') {
														extraRoadAddr = ' ('
																+ extraRoadAddr
																+ ')';
													}
													// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
													if (fullRoadAddr !== '') {
														fullRoadAddr += extraRoadAddr;
													}

													// 우편번호와 주소 정보를 해당 필드에 넣는다.
													console.log(data.zonecode);
													console.log(fullRoadAddr);

													$("[name=orZipcode]").val(data.zonecode);
													$("[name=orAddress]").val(fullRoadAddr);

													/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
													document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
													document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
												}
											}).open();
								}
							</script>

	
	

</body>
</html>