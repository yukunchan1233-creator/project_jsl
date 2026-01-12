<%-- 
    [로그인 페이지 - login.jsp]
    설명: 사용자 로그인을 처리하는 페이지입니다. 일반 로그인과 구글 로그인을 지원합니다.
    흐름: 사용자가 아이디/비밀번호 입력 → "로그인" 버튼 클릭 → AJAX로 /mem/loginpro.do 요청 →
          MemberController → MemberLogin 서비스 → MemberDao → DB 조회 → 비밀번호 검증 →
          세션 생성 → 성공 시 메인 페이지로 이동
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
    
    <div class="sub-container">
        <div class="login-wrapper">
            <div class="login-card">
                <h2 class="login-title">로그인</h2>
                <%-- 로그인 폼 --%>
                <form id="myform" class="login-form">
                    <div class="form-group">
                        <input type="text" name="userid" id="loginUserid" placeholder="아이디" class="form-input">
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" id="password" placeholder="비밀번호" class="form-input">
                    </div>
                    <div class="form-options">
                        <label class="checkbox-label">
                            <input type="checkbox" name="useridcheck" id="saveid">
                            <span>아이디 저장</span>
                        </label>
                    </div>
                    <%-- 로그인 에러 메시지가 표시되는 영역 --%>
                    <div id="errmsg" class="error-message"></div>
                    <button type="button" class="btn-login" id="btn-login">로그인</button>
                    
                    <div class="login-divider">
                        <span>또는</span>
                    </div>
                    
                    <div class="google-login-wrapper">
                        <div id="google-signin-button"></div>
                    </div>
                    
                    <div class="login-links">
                        <a href="" class="link-text">아이디·비밀번호 찾기</a>
                        <span class="divider">|</span>
                        <a href="${pageContext.request.contextPath}/mem/join.do" class="link-text">회원가입</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

<!-- Google Identity Services 라이브러리 -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script type="text/javascript">
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    if(!contextPath || contextPath === "/") contextPath = "/hometraining";
    
    // Google Identity Services 초기화
    window.onload = function() {
        google.accounts.id.initialize({
            client_id: "888481044220-hncob4mhcr6t027h49p85vdd2u1aamoe.apps.googleusercontent.com",
            callback: handleCredentialResponse
        });
        
        // 구글 로그인 버튼 렌더링asdasda
        google.accounts.id.renderButton(
            document.getElementById("google-signin-button"),
            {
                type: "standard",
                size: "large",
                theme: "outline",
                text: "signin_with",
                shape: "rectangular",
                logo_alignment: "left"
            }
        );
        
        // 자동 로그인 프롬프트 비활성화
        google.accounts.id.prompt();
    };
    
    // 구글 로그인 성공 콜백
    function handleCredentialResponse(response) {
        // ID 토큰을 서버로 전송
        $.ajax({
            url: contextPath + '/mem/googleLogin.do',
            type: 'POST',
            data: {
                credential: response.credential
            },
            success: function(result) {
                if(result === 'success') {
                    alert('구글 로그인 성공!');
                    window.location.href = contextPath + '/main.do';

                } else {
                    alert('구글 로그인 실패: ' + result);
                }
            },
            error: function(xhr, status, error) {
                alert('구글 로그인 중 오류가 발생했습니다.');
                console.error(error);
            }
        });
    }
</script>
<%@ include file="../footer.jsp" %>




