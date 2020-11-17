<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="함께해요"/>
</jsp:include>

<jsp:include page="/WEB-INF/views/common/menuTitle.jsp">
	<jsp:param name="menuTitle" value="공지해요"/>
</jsp:include>

<!-- Start With -->
<table class="table" border="1" summary="">
<caption>글쓰기 폼</caption>
<colgroup>
	<col style="width:130px;">
	<col style="width:auto;">
</colgroup>
<tbody>
<tr>
	<th scope="row">제목</th>
    	<td>
    		<select id="board_category" name="board_category" fw-filter="" fw-label="" fw-msg="">
				<option value="1">공지</option>
		
			</select>  
		</td>
</tr>
<tr class="">

<tr class="displaynone">
<td colspan="2" class="clear">
                        
            <script type="text/javascript" src="//editor.cafe24.com/js/nneditor.js?c=ko"></script>		<style type="text/css">			@import "https://editor.cafe24.com/css/style.css?ver=r3.4.0.20200729.1";			@import "https://editor.cafe24.com/css/styleie8.css?ver=r3.4.0.20200729.1";		</style>		<script type="text/javascript" src="https://editor.cafe24.com/lang/ko.js?version=r3.4.0.20200729.1" charset="UTF-8"></script><script type="text/javascript" src="https://editor.cafe24.com/js/nneditorUtils.dev.js?version=r3.4.0.20200729.1" charset="UTF-8"></script><script type="text/javascript" src="https://editor.cafe24.com/js/nneditorRange.dev.js?version=r3.4.0.20200729.1" charset="UTF-8"></script><script type="text/javascript" src="https://editor.cafe24.com/js/nneditorCore.dev.js?version=r3.4.0.20200729.1" charset="UTF-8"></script>
            <script type="text/javascript">
                
                

                //Editor Height
                NN.Config.height=400;

                var oNN_content = new NNEditor();
                oNN_content.build();

                if (typeof $Editor != "object") {
                    $Editor = {
                        _obj : {},

                        push : function(obj, id) {
                            this._obj[id] = obj;
                        },

                        get : function(id) {
                            return this._obj[id];
                        },

                        reset : function(id) {
                            this._obj[id].getText().value = "";
                            this._obj[id].getIFDoc().body.innerHTML = this._obj[id].Config.START_HTML;
                        },

                        contents : function(id, context) {
                            this._obj[id].getText().value = context;
                            this._obj[id].getIFDoc().body.innerHTML = this._obj[id].view.parsing(2);
                        }
                    };
                }

                $Editor.push(oNN_content, "content");
			</script>            
            <input type="hidden" id="content_hidden" fw-filter="isSimplexEditorFill" fw-label="내용" value="oNN_content">
        
                            </td>
                </tr>

</tbody>

<tbody>
<tr class="">

</tbody>
</table>
<!-- End With -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>		