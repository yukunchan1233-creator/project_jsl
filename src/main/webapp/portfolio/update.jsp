<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
    
    <div class="subvisual">
        <div class="sub-inner">
            <div class="sub-title">
                <h2>PORTFOLIO</h2>
                <p>Goooooooooood Man</p>
            </div>
        </div>
    </div>
    
    <div class="sub-container">
        <div class="writebox">
            <form name="my" method="post" action="${pageContext.request.contextPath}/port/updatepro.do" enctype="multipart/form-data" onsubmit="return check()">
            <input type="hidden" name="bno" value="${viewdto.bno }">
                <table class="border-table">
                    <tr>
                        <th>글쓴이</th>
                        <td><input type="text" name="name" value="${viewdto.name }" readonly></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" id="title" value="${viewdto.title }"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>
                        	<button type="button" id="btn-ai">AI글쓰기</button>
                        	<select name="lang" id="btn-translate" style="padding:6px 12px;display:inline-block;width:120px;">
                        		<option value="">언어선택</option>
                        		<option value="jp">일본어</option>
                        		<option value="en">영어</option>
                        		<option value="ch">중국어</option>
                        	</select>
                        	<span style="display:block; padding:10px 0;">
                        	<textarea name="content" id="content">${viewdto.content}</textarea>
                        	</span>
                        </td>
                    </tr>
                    <tr>
                        <th>첨부파일</th>
                        <td>
                            <input type="file" name="imgFile">
                            <img src="${pageContext.request.contextPath}/img/${viewdto.imgfile }" alt="" style="width:36px; height:36px;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="submit">수정글 저장</button>
                            <button type="reset" class="reset" onclick="alert('모두 지우고 다시쓸래요?')">다시쓰기</button>
                            <button type="button" class="list" onclick="location.href='${pageContext.request.contextPath}/port/list.do'">목록</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    
<script>
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    
	function check() {
		if(!my.title.value) {
			alert("제목입력");
			my.title.focus();
			return false;
		}
		if(!my.content.value) {
			alert("내용입력");
			my.content.focus();
			return false;
		}
		alert("수정완료");
		return true;
	}
	
	$("#btn-ai").click(function() {
		let title = $("#title").val();
		if(!title) {
			alert("제목 입력");
			return;
		}
		$.ajax({
			type:"post",
			url: contextPath + "/port/aiWrite.do",
			data:{title:title},
			success:function(data) {
				$("#content").val(data.content);
			},
			error: function() {
				alert("AI 통신에러");
			}
		})
	})
	
	$("#btn-translate").on("change",function() {
		let lang = $(this).val();
		let content = $("#content").val();
		if(!lang) {
			alert("번역할 언어를 선택");
			return;
		}
		if(!content) {
			alert("내용 입력");
			return;
		}
		$.ajax({
			type:"post",
			url: contextPath + "/port/aiTranslate.do",
			data:{lang:lang,content:content},
			success:function(data) {
				$("#content").val(data.translated);
			},error:function() {
				alert("AI 통신에러");
			}
		})
	})
</script>
    
<%@ include file="../footer.jsp" %>




