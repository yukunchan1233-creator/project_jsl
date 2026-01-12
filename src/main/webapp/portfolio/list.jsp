<%-- 
    [포트폴리오 목록 페이지 - list.jsp]
    설명: 포트폴리오 목록을 보여주는 페이지입니다. 검색, 페이징, 찜 기능을 지원합니다.
    흐름: 사용자가 "/port/list.do" 접속 → BlogController → BlogSelectAll 서비스 →
          BlogDao → DB 조회 (검색/페이징 처리) → list.jsp로 forward → 목록 출력
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <%-- 검색 영역 --%>
        <div class="search-group">
            <div class="count">
                <%-- 총 게시글 수 표시 (BlogSelectAll 서비스에서 설정) --%>
                <span class="count">총게시글 : ${totalCount}</span>
            </div>
            <div class="search">
                <%-- 검색 폼: 제목 또는 내용으로 검색 가능 --%>
                <form name="my" method="post" action="${pageContext.request.contextPath}/port/list.do" onsubmit="return check()">
                    <select name="type">
                        <option value="">선택</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" name="keyword" value="${param.keyword}">
                    <button type="submit">검색</button>
                </form>
            </div>
        </div>
        
        <%-- 포트폴리오 목록 출력 --%>
        <c:forEach var="item" items="${list}">
	        <div class="search-content">
	            <%-- 등록일 표시 --%>
	            <div class="date">
	                <span>${item.regdate.substring(7,10) }</span>
	                <em>${item.regdate.substring(0,7) }</em>
	            </div>
	            <%-- 포트폴리오 이미지 --%>
	            <div class="search-img">
	                <img src="${pageContext.request.contextPath}/img/${item.imgfile}" alt="단품이미지">
	            </div>
	            <div class="search-text">
	                <div>
	                    <%-- 게시글 번호와 조회수 표시 --%>
	                    <span>No.${item.bno }</span> | <span>${item.views }</span>
	                </div>
	                <div>
	                    <%-- 제목 클릭 시 상세보기 페이지로 이동 --%>
	                    <a href="${pageContext.request.contextPath}/port/view.do?bno=${item.bno }"><h3>${item.title }</h3></a>
	                </div>
	                <div class="txt">
	                	<div style="height:72px; overflow:hidden;">
	                    ${item.content }
	                    </div>
	                    <p>
	                    	<%-- 상세보기 링크 --%>
	                    	<a href="${pageContext.request.contextPath}/port/view.do?bno=${item.bno }" class="more">MORE</a>
	                    	<%-- 찜 기능: JavaScript에서 AJAX로 처리 (data-blogbno 속성에 게시글 번호 저장) --%>
	                    	<a href="javascript:void(0);" class="wish" data-blogbno="${item.bno }">WISH</a>
	                    </p>
	                </div>
	            </div>
	        </div>
        </c:forEach>
        </div>
        
        <%-- 페이징 영역 --%>
        <div class="page">
            <div class="number">
            <c:if test="${startPage > 1 }">
	            <a href="${pageContext.request.contextPath}/port/list.do?keyword=${param.keyword}&page=${startPage-1}"><<</a>
	        </c:if>
	        <c:forEach begin="${startPage}" end="${endPage}" var="p">
	            <a href="${pageContext.request.contextPath}/port/list.do?keyword=${param.keyword }&page=${p}" 
	            	${p==currentPage?'class="active"':''}>${p}</a>
	         </c:forEach>
	           
	         <c:if test="${endPage < totalPages }">  
	            <a href="${pageContext.request.contextPath}/port/list.do?keyword=${param.keyword }&page=${endPage+1}">>></a>
	         </c:if>
            </div>
            <div class="writer">
                <%-- 글쓰기 버튼: 포트폴리오 작성 페이지로 이동 --%>
                <a href="${pageContext.request.contextPath}/port/write.do">글쓰기</a>
            </div>
        </div>
   
<script>
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    
    function check() {
        if(!my.keyword.value) {
            alert("검색어를 입력하세요");
            my.keyword.focus();
            return false;
        }
        return true;
    }
    
	$(".wish").on("click", function() {
		//로그인한 사람만 찜 할수 있다.
		var userid = "${sessionScope.userid}";
		var blogbno = $(this).data("blogbno");
		console.log(userid);
		console.log(blogbno);
		if(!userid){
			alert("블로그 찜은 로그인이 필요합니다.");
			return;
		}
		//동기식이건, 비 동기식이던 아이디와 블로그 번호를 서버로 넘겨줘야 insert하겠지.
		$.ajax({
			 type: 'post',
			 data: {userid:userid,blogbno:blogbno},
			 url: contextPath + '/port/mywish.do',
			 success:function(res) {
				 alert(res);
			 },error:function() {
				 alert("오류발생");
			 }
		 })
	})
</script>
    
<%@ include file="../footer.jsp" %>




