<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../header.jsp" %>

    <div class="subvisual">
        <div class="sub-inner">
            <div class="sub-title">
                <h2>MY Favorite</h2>
                <p>Goooooooooood Man</p>
            </div>
        </div>
    </div>
    
    <div class="sub-container">
        <c:forEach var="item" items="${wishlist}">
	        <div class="search-content">
		        <div>
		        	<input type="checkbox" class="blogCheckBox" value="${item.wish_bno }">
		        </div>
	            <div class="date">
	                <span>${item.regdate.substring(8,10) }</span>
	                <em>${item.regdate.substring(0,7) }</em>
	            </div>
	            <div class="search-img">
	                <img src="${pageContext.request.contextPath}/img/${item.imgfile}" alt="단품이미지">
	            </div>
	            <div class="search-text">
	                <div>
	                    <span>No.${item.bno}</span> | <span>${item.views}</span>
	                </div>
	                <div>
	                    <a href="${pageContext.request.contextPath}/port/view.do?bno=${item.bno}"><h3>${item.title}</h3></a>
	                </div>
	                <div class="txt">
	                	<div style="height:72px; overflow:hidden;">
	                   		 ${item.content }
	                    </div>
	                    <p>
	                    	<button class="more deleteBtn" data-wish_bno="${item.wish_bno}">Delete</button>
	                    </p>
	                </div>
	            </div>
	        </div>
        </c:forEach>
        </div>
        
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
                <button id="deleteSelected">선택삭제</button>
            </div>
        </div>
   
<script>
    // context path를 JavaScript 변수로 설정
    var contextPath = "${pageContext.request.contextPath}";
    
	function check() {
		if(!my.type.value) {
			alert("검색방법을 선택해 주세요");
			return false;
		}
		if(!my.keyword.value) {
			alert("검색단어를 입력하세요")
			my.keyword.focus();
			return false;
		}
		return true;
	}
	
	$(".deleteBtn").on("click", function() {
		var wishBno = $(this).data("wish_bno")
		var $this = $(this);
		
		$.ajax({
			 type: 'post',
			 data: {wishBno:wishBno},
			 url: contextPath + '/mem/mywishDelete.do',
			 success:function(res) {
				 if(res.trim() === "success"){
					 $this.closest(".search-content").remove();
				 }else {
					 alert("삭제실패");
				 }
			 },error:function() {
				 alert("오류발생");
			 }
		 })
	})
	
</script>    
    
<%@ include file="../footer.jsp" %>




