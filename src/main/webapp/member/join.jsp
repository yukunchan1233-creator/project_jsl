<%-- 
    [회원가입 페이지 - join.jsp]
    설명: 새로운 회원을 등록하는 폼 페이지입니다.
    흐름: 사용자가 정보 입력 → JavaScript 유효성 검사 → AJAX로 아이디 중복 체크 → 
          "회원가입" 버튼 클릭 → /mem/membersave.do로 POST 요청 → MemberController → 
          MemberSave 서비스 → MemberDao → DB 저장 → 메인 페이지로 리다이렉트
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>
    
    <%-- 회원가입 폼 영역1 --%>
    <div class="sub-container">
        <div class="join-wrapper">
            <div class="join-card">
                <h2 class="join-title">회원가입</h2>
                <%-- 
                    회원가입 폼
                    - name="my": JavaScript에서 폼을 참조하기 위한 이름
                    - id="myform": jQuery에서 폼을 참조하기 위한 ID
                    - action과 method는 JavaScript에서 동적으로 설정됩니다 (my.js 참조)
                --%>
                <form name="my" id="myform" class="join-form">
                    <%-- 프로필사진 업로드 --%>
                    <div class="profile-section">
                        <div class="profile-preview">
                            <img id="profile-preview-img" src="${pageContext.request.contextPath}/images/image_1.jpg" alt="프로필 미리보기">
                            <div class="profile-overlay">
                                <label for="imgFile" class="profile-upload-btn">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                        <polyline points="17 8 12 3 7 8"></polyline>
                                        <line x1="12" y1="3" x2="12" y2="15"></line>
                                    </svg>
                                    <span>사진 변경</span>
                                </label>
                            </div>
                        </div>
                        <input type="file" name="imgFile" id="imgFile" accept="image/*" style="display: none;">
                        <p class="profile-hint">프로필 사진을 등록해주세요 (선택사항)</p>
                    </div>
                    
                    <div class="form-group">
                        <label for="writer" class="form-label">사용자명</label>
                        <input type="text" name="writer" id="writer" class="form-input" placeholder="사용자명을 입력하세요">
                        <p class="error-msg writer-msg"></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="userid" class="form-label">아이디</label>
                        <input type="text" name="userid" id="userid" class="form-input" placeholder="아이디를 입력하세요">
                        <p class="error-msg userid-msg"></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" name="password" id="password" class="form-input" placeholder="비밀번호를 입력하세요">
                        <p class="error-msg password-msg"></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="pw2" class="form-label">비밀번호 확인</label>
                        <input type="password" name="passwordcheck" id="pw2" class="form-input" placeholder="비밀번호를 다시 입력하세요">
                        <p class="error-msg pw2-msg"></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" name="email" id="email" class="form-input" placeholder="이메일을 입력하세요">
                        <p class="error-msg email-msg"></p>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone" class="form-label">전화번호</label>
                        <input type="text" name="phone" id="phone" class="form-input" placeholder="전화번호를 입력하세요">
                        <p class="error-msg phone-msg"></p>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn-primary" id="btn-submit">회원가입</button>
                        <button type="button" class="btn-secondary" id="btn-reset">다시쓰기</button>
                        <button type="button" class="btn-outline" onclick="javascript:history.go(-1)">되돌아가기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    
    // 프로필사진 미리보기
    $(function() {
        $("#imgFile").on("change", function(e) {
            var file = e.target.files[0];
            if(file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $("#profile-preview-img").attr("src", e.target.result);
                };
                reader.readAsDataURL(file);
            }
        });
    });
    </script>
    
<%@ include file="../footer.jsp" %>




