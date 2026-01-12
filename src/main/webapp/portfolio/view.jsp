<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp"%>

<div class="sub-container">
	<div class="sub-left">
		<h3 class="subtit">포트폴리오</h3>
		<div class="btn-sns">
			<a href="">블로그</a> <a href="">페이스북</a> <a href="">인스타그램</a>
		</div>
	</div>
	<div class="board-view">
		<div class="board-header">
			<span class="date">Regdate : ${viewdto.regdate.substring(0,10) }</span>
			<strong>${viewdto.title }</strong> <span class="icon-view">views
				: ${viewdto.views }</span>
		</div>
		<div class="board-body">
			<p>즐거운 여행 다녀왔습니다.</p>
			<p>
				<img src="${pageContext.request.contextPath}/img/${viewdto.imgfile}" alt="">
			</p>
			<p>${viewdto.content }</p>
		</div>
		<div class="board-controller">
			<a href="" class="prev"> <strong>Previous</strong> <span>유럽여행</span>
			</a> <a href="" class="next"> <strong>Next</strong> <span>에베레스트
					여행</span>
			</a>
		</div>
		<div class="btn-board">
			<button type="button" class="submit"
				onclick="location.href='${pageContext.request.contextPath}/port/list.do'">목록</button>
			<button type="button" class="reset"
				onclick="updateGet(${viewdto.bno})">수정</button>
			<button type="button" class="list"
				onclick="deleteGet(${viewdto.bno})">삭제</button>
		</div>
	</div>
		
		<!-- 댓글 섹션 -->
<div class="comment-container">
    <h2>댓글</h2>
    
    <!-- 댓글 작성 폼 -->
    <div class="comment-form">
        <div class="form-group">
            <label for="userid">글쓴이</label>
            <input type="text" id="userid" name="userid" value="${sessionScope.userid}" readonly>
        </div>
        <div class="form-group">
            <label for="replytext">댓글내용</label>
            <textarea id="replytext" name="replytext" rows="3" placeholder="댓글을 입력하세요..."></textarea>
        </div>
        <div class="form-buttons">
            <button type="button" class="btn-register" id="btn-reply-submit">등록</button>
            <button type="button" class="btn-cancel" id="btn-reply-cancel">취소</button>
        </div>
    </div>
    
    <!-- 댓글 리스트 (최대 3개) -->
    <div class="comment-list">
        <h3>댓글 목록</h3>
        <c:forEach var="reply" items="${replyList}" varStatus="status">
            <c:if test="${status.index < 3}">
                <div class="comment-item">
                    <div class="comment-header">
                        <span class="comment-author">글쓴이: ${reply.userid}</span>
                        <span class="comment-date">${reply.regdate}</span>
                    </div>
                    <div class="comment-content">${reply.replytext}</div>
                    <div class="comment-actions">
                        <%-- 본인 댓글만 수정/삭제 버튼 표시 --%>
                        <c:if test="${sessionScope.userid == reply.userid}">
                            <button type="button" class="btn-edit" data-rno="${reply.bno}">수정</button>
                            <button type="button" class="btn-delete" data-rno="${reply.bno}">삭제</button>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

		
</div>
	

<script>
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    
	// jQuery 시작
	$(function() {
		// 블로그 삭제
		$(".list").on("click", function() {
			var bno = ${viewdto.bno};
			if(confirm("삭제할래요?")) {
				location.href = contextPath + "/port/delete.do?bno=" + bno;
			}
		});
		
		// 블로그 수정
		$(".reset").on("click", function() {
			var bno = ${viewdto.bno};
			if(confirm("수정할래요?")) {
				location.href = contextPath + "/port/update.do?bno=" + bno;
			}
		});
		
		// 댓글 등록 버튼 클릭
		$("#btn-reply-submit").on("click", function() {
			var userid = $("#userid").val();
			var blog_bno = ${viewdto.bno};
			var replytext = $("#replytext").val();
			
			console.log('=== 댓글 등록 시도 ===');
			console.log('userid:', userid);
			console.log('blog_bno:', blog_bno);
			console.log('replytext:', replytext);
			
			// 로그인 확인
			if(!userid || userid.trim() === '') {
				alert('로그인이 필요합니다.');
				location.href = contextPath + '/mem/login.do';
				return;
			}
			
			// 댓글 내용 확인
			if(!replytext || replytext.trim() === '') {
				alert('댓글 내용을 입력하세요.');
				$("#replytext").focus();
				return;
			}
			
			// blog_bno 확인
			if(!blog_bno || isNaN(blog_bno)) {
				alert('블로그 번호가 올바르지 않습니다.');
				console.error('blog_bno 오류:', blog_bno);
				return;
			}
			
			// jQuery AJAX로 댓글 등록
			$.ajax({
				type: 'POST',
				url: contextPath + '/port/replyWrite.do',
				data: {
					blog_bno: blog_bno,
					userid: userid,
					replytext: replytext
				},
				success: function(data) {
					console.log('서버 응답:', data);
					var response = data.trim();
					if(response === 'success') {
						alert('댓글이 등록되었습니다.');
						location.reload();  // 페이지 새로고침
					} else if(response === 'login_required') {
						alert('로그인이 필요합니다.');
						location.href = contextPath + '/mem/login.do';
					} else if(response === 'empty_content') {
						alert('댓글 내용을 입력하세요.');
						$("#replytext").focus();
					} else if(response === 'db_error') {
						alert('댓글 등록에 실패했습니다. 데이터베이스 오류가 발생했습니다.');
						console.error('DB 오류 응답:', response);
					} else if(response.indexOf('error:') === 0) {
						alert('댓글 등록 중 오류가 발생했습니다: ' + response);
						console.error('에러 응답:', response);
					} else {
						alert('댓글 등록에 실패했습니다. 응답: ' + response);
						console.error('실패 응답:', response);
					}
				},
				error: function(xhr, status, error) {
					console.error('AJAX 에러:', error);
					console.error('상태:', status);
					console.error('응답:', xhr.responseText);
					alert('오류가 발생했습니다: ' + error);
				}
			});
		});
		
		// 댓글 취소 버튼 클릭
		$("#btn-reply-cancel").on("click", function() {
			$("#replytext").val('');
		});
		
		// 댓글 수정 버튼 클릭 (이벤트 위임 사용)
		$(document).on("click", ".btn-edit", function() {
			// 이미 저장 모드인지 확인
			if($(this).text() === '저장') {
				var rno = $(this).data("rno");
				var $commentItem = $(this).closest(".comment-item");
				var $textarea = $commentItem.find(".edit-textarea");
				saveReply(rno, $textarea.val());
				return;
			}
			
			// 수정 모드로 전환
			var rno = $(this).data("rno");
			var $commentItem = $(this).closest(".comment-item");
			var $commentContent = $commentItem.find(".comment-content");
			var currentText = $commentContent.text().trim();
			
			// textarea 생성
			var $textarea = $('<textarea class="edit-textarea"></textarea>');
			$textarea.val(currentText);
			$textarea.css({
				'width': '100%',
				'padding': '10px',
				'border': '1px solid #ddd',
				'border-radius': '4px',
				'margin-bottom': '10px',
				'min-height': '80px'
			});
			
			// 기존 내용 숨기고 textarea 표시
			$commentContent.hide();
			$commentContent.after($textarea);
			
			// 수정 버튼을 저장 버튼으로 변경
			$(this).text('저장');
		});
		
		// 댓글 수정 취소 버튼 클릭
		$(document).on("click", ".btn-edit-cancel", function() {
			var $commentItem = $(this).closest(".comment-item");
			var $textarea = $commentItem.find(".edit-textarea");
			var $commentContent = $commentItem.find(".comment-content");
			
			// textarea 제거하고 원래 내용 표시
			$textarea.remove();
			$commentContent.show();
			
			// 버튼 원래대로
			var $editBtn = $commentItem.find(".btn-edit");
			$editBtn.text('수정');
		});
		
		// 댓글 저장 함수
		function saveReply(rno, content) {
			if(!content || content.trim() === '') {
				alert('댓글 내용을 입력하세요.');
				return;
			}
			
			$.ajax({
				type: 'POST',
				url: contextPath + '/port/replyUpdate.do',
				data: {
					bno: rno,
					replytext: content
				},
				success: function(data) {
					console.log('서버 응답:', data);
					var response = data.trim();
					if(response === 'success') {
						alert('댓글이 수정되었습니다.');
						location.reload();
					} else if(response === 'login_required') {
						alert('로그인이 필요합니다.');
						location.href = contextPath + '/mem/login.do';
					} else if(response === 'empty_content') {
						alert('댓글 내용을 입력하세요.');
					} else if(response === 'permission_denied') {
						alert('본인의 댓글만 수정할 수 있습니다.');
						console.error('권한 없음 응답:', response);
					} else {
						alert('댓글 수정에 실패했습니다. 응답: ' + response);
						console.error('실패 응답:', response);
					}
				},
				error: function(xhr, status, error) {
					console.error('AJAX 에러:', error);
					console.error('상태:', status);
					console.error('응답:', xhr.responseText);
					alert('오류가 발생했습니다: ' + error);
				}
			});
		}
		
		// 댓글 삭제 버튼 클릭
		$(document).on("click", ".btn-delete", function() {
			var rno = $(this).data("rno");
			
			if(!confirm("댓글을 삭제하시겠습니까?")) {
				return;
			}
			
			$.ajax({
				type: 'POST',
				url: contextPath + '/port/replyDelete.do',
				data: {
					bno: rno
				},
				success: function(data) {
					console.log('서버 응답:', data);
					var response = data.trim();
					if(response === 'success') {
						alert('댓글이 삭제되었습니다.');
						location.reload();
					} else if(response === 'login_required') {
						alert('로그인이 필요합니다.');
						location.href = contextPath + '/mem/login.do';
					} else if(response === 'permission_denied') {
						alert('본인의 댓글만 삭제할 수 있습니다.');
					} else {
						alert('댓글 삭제에 실패했습니다. 응답: ' + response);
					}
				},
				error: function(xhr, status, error) {
					console.error('AJAX 에러:', error);
					alert('오류가 발생했습니다: ' + error);
				}
			});
		});
	}); // end of $(function()
</script>
<%@ include file="../footer.jsp"%>




