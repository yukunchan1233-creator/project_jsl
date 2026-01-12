<%-- 
    [메인 페이지 - index.jsp]
    설명: 웹사이트의 첫 화면으로, 최신 포트폴리오 목록을 보여줍니다.
    흐름: 사용자가 "/" 또는 "/main.do" 접속 → MainController → BlogSelectIndex 서비스 → BlogDao → DB 조회 → JSP 출력
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- header.jsp를 포함하여 상단 메뉴와 공통 레이아웃을 가져옵니다 --%>
<%@ include file="header.jsp" %>
    
    <%-- 메인 비주얼 영역: 큰 제목과 부제목을 표시 --%>
    <%-- 메인 비주얼 영역: 베스트 상품 슬라이더 --%>
<div class="mainvisual">
    <div class="visual-inner">
        <%-- 왼쪽 화살표 --%>
        <button class="slider-btn prev-btn" id="prevBtn">‹</button>
        
        <%-- 슬라이더 컨테이너 --%>
        <div class="slider-container">
            <div class="slider-wrapper">
                <%-- 슬라이드 1 --%>
                <div class="slide active">
                    <div class="slide-link">
                        <img src="${pageContext.request.contextPath}/images/bansok_bench.png" alt="베스트 상품 1" style="display: block;">
                        <div class="slide-content">
                            <h2>첫번째 베스트 상품</h2>
                            <p>반석 가정용 벤치프레스</p>
                            <%-- 버튼 클릭 시 상세 페이지로 이동 --%>
                            <%-- 실제 상품 번호로 변경 필요: detail.jsp?pno=상품번호 --%>
                            <a href="${pageContext.request.contextPath}/detail.jsp?pno=1" class="slide-btn">미들클라임 자세히 보기</a>
                        </div>
                    </div>
                </div>
                
                <%-- 슬라이드 2 --%>
                <div class="slide">
                    <div class="slide-link">
                        <img src="${pageContext.request.contextPath}/images/egozin_dumbel.jpg">
                        <div class="slide-content">
                            <h2>두 번째 베스트 상품</h2>
                            <p>상품 설명</p>
                            <%-- 버튼 클릭 시 상세 페이지로 이동 --%>
                            <%-- 실제 상품 번호로 변경 필요: detail.jsp?pno=상품번호 --%>
                            <a href="${pageContext.request.contextPath}/detail.jsp?pno=2" class="slide-btn">자세히 보기</a>
                        </div>
                    </div>
                </div>
                
                <%-- 슬라이드 3 --%>
                <div class="slide">
                    <div class="slide-link">
                        <img src="${pageContext.request.contextPath}/images/egozin_dumbel.jpg">
                        <div class="slide-content">
                            <h2>세 번째 베스트 상품</h2>
                            <p>상품 설명</p>
                            <%-- 버튼 클릭 시 상세 페이지로 이동 --%>
                            <%-- 실제 상품 번호로 변경 필요: detail.jsp?pno=상품번호 --%>
                            <a href="${pageContext.request.contextPath}/detail.jsp?pno=3" class="slide-btn">자세히 보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%-- 오른쪽 화살표 --%>
        <button class="slider-btn next-btn" id="nextBtn">›</button>
        
        <%-- 인디케이터 (선택사항) --%>
        <div class="slider-indicators">
            <span class="indicator active" data-slide="0"></span>
            <span class="indicator" data-slide="1"></span>
            <span class="indicator" data-slide="2"></span>
        </div>
    </div>
</div>

    <%-- 카테고리 아이콘 섹션 --%>
    <div class="category-icons">
        <div class="category-icons-inner">
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=벤치프레스" class="category-icon" title="벤치프레스">
                <div class="icon-circle">
                    <img src="${pageContext.request.contextPath}/images/benchpress_icon.png" alt="벤치프레스">
                </div>
                <span>벤치프레스</span>
            </a>
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=사이클" class="category-icon" title="사이클">
                <div class="icon-circle">
                    <img src="${pageContext.request.contextPath}/images/cycle_icon.jpg" alt="사이클">
                </div>
                <span>사이클</span>
            </a>
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=런닝머신" class="category-icon" title="런닝머신">
                <div class="icon-circle">
                    <img src="${pageContext.request.contextPath}/images/running_icon.png" alt="런닝머신">
                </div>
                <span>런닝머신</span>
            </a>
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=덤벨" class="category-icon" title="덤벨">
                <div class="icon-circle">
                    <img src="${pageContext.request.contextPath}/images/dumbel_icon.png" alt="덤벨">
                </div>
                <span>덤벨</span>
            </a>
        </div>
    </div>
    
    <%-- 컨테이너 영역: 포트폴리오 목록을 표시 --%>
    <div class="container">
        <%-- 
            JSTL forEach를 사용하여 서버에서 전달받은 list를 반복 출력합니다.
            ${list}는 MainController에서 BlogSelectIndex 서비스를 통해 설정된 request 속성입니다.
            varStatus를 사용하여 최대 3개만 출력합니다.
        --%>
        <c:forEach var="item" items="${list }" varStatus="status">
        	<c:if test="${status.index < 3}">
		        <div class="box">
		            <div class="over">
		            	<%-- 포트폴리오 이미지 표시 --%>
		            	<img src="${pageContext.request.contextPath}/img/${item.imgfile }">
		            </div>
		            <a href="${pageContext.request.contextPath}/port/view.do?bno=${item.bno}">
		                <%-- 포트폴리오 제목 표시 --%>
		                <h3 class="portTitle">${item.title }</h3>
		                <%-- 포트폴리오 내용의 처음 20자만 표시 (substring(0,20)) --%>
		                <p class="txt" style="height:100px; overflow: hidden;">${item.content.substring(0,20) }</p>
		            </a>
		        </div>
        	</c:if>
        </c:forEach>
    </div>
    
<%-- footer.jsp를 포함하여 하단 푸터를 가져옵니다 --%>
<%@ include file="footer.jsp" %>
