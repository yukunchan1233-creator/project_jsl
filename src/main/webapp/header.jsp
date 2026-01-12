<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOMETRAINING</title>
<link href="${pageContext.request.contextPath}/css/mystyle.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script>
// contextPath를 header에서 먼저 설정 (my.js가 로드되기 전에)
var contextPath = "${pageContext.request.contextPath}";
// jslhrd가 ROOT(/)로 설정되어 있으면 hometraining으로 강제 설정
if(!contextPath || contextPath === '/') {
	contextPath = '/hometraining';
}
</script>
<script src="${pageContext.request.contextPath}/js/my.js"></script>
</head>
<body>
    <div class="gnb_group">
        <!-- 로고 -->
        <h1 class="logo"><a href="${pageContext.request.contextPath}/main.do"><span>HOME</span>TRAINING</a></h1>
        
        <!-- 메인 메뉴 (유산소운동, 근력운동) -->
        <nav class="main_nav">
            <ul class="nav_1depth">
                <li>
                    <a href="">유산소운동</a>
                    <ul class="nav_2depth">
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=런닝머신">런닝머신</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=사이클">사이클</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=로잉머신">로잉머신</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=스텝퍼">스텝퍼</a></li>
                    </ul>
                </li>
                <li>
                    <a href="">근력운동</a>
                    <ul class="nav_2depth">
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=벤치프레스">벤치프레스</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=덤벨">덤벨</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=바벨">바벨</a></li>
                        <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=케이블머신">케이블머신</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        
        <!-- 우측 사용자 메뉴 (로그인, 회원가입, 검색, 마이페이지) -->
        <nav class="user_nav">
            <ul>
                <c:choose>
                    <c:when test="${empty sessionScope.userid}">
                        <li><a href="${pageContext.request.contextPath}/mem/login.do">로그인</a></li>
                        <li class="separator">|</li>
                        <li><a href="${pageContext.request.contextPath}/mem/join.do">회원가입</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/mem/logout.do">로그아웃</a></li>
                        <li class="separator">|</li>
                        <li><a href="${pageContext.request.contextPath}/mem/mypage.do">마이페이지</a></li>
                        <c:if test="${sessionScope.userid == 'admin'}">
                            <li class="separator">|</li>
                            <li><a href="${pageContext.request.contextPath}/portfolio.do?sub=런닝머신" style="color: #fa9660; font-weight: bold;">관리자</a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <li class="separator">|</li>
                <li class="icon-item">
                    <a href="javascript:void(0);" class="search-icon" title="검색">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <path d="m21 21-4.35-4.35"></path>
                        </svg>
                    </a>
                </li>
                <c:if test="${not empty sessionScope.userid}">
                    <li class="icon-item">
                        <a href="${pageContext.request.contextPath}/mem/mypage.do" class="user-icon" title="마이페이지">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>

