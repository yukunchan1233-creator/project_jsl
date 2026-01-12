<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<style>
/* 포트폴리오 페이지 스타일 */
.portfolio-container {
    width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

.portfolio-header {
    margin-bottom: 30px;
}

.portfolio-header h2 {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

/* 정렬 옵션 */
.sort-options {
    display: flex;
    gap: 10px;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 2px solid #e1e1e1;
}

.sort-options a {
    padding: 10px 20px;
    background: #f5f5f5;
    color: #333;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.3s;
    border: 1px solid #ddd;
}

.sort-options a:hover {
    background: #fa9660;
    color: #fff;
    border-color: #fa9660;
}

.sort-options a.active {
    background: #fa9660;
    color: #fff;
    border-color: #fa9660;
}

/* 제품 목록 테이블 */
.product-list-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.product-list-table thead {
    background: #f7f8fc;
}

.product-list-table th {
    padding: 15px;
    text-align: center;
    font-weight: bold;
    color: #333;
    border-bottom: 2px solid #ddd;
}

.product-list-table td {
    padding: 20px 15px;
    border-bottom: 1px solid #e1e1e1;
    vertical-align: middle;
}

.product-list-table tr:hover {
    background: #f9f9f9;
}

/* 제품 이미지 */
.product-image {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid #ddd;
}

/* 제품 정보 */
.product-info {
    text-align: left;
    padding-left: 20px;
}

.product-title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
    line-height: 1.4;
}

.product-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: center;
    font-size: 14px;
    color: #666;
    margin-top: 8px;
}

.product-meta span {
    display: flex;
    align-items: center;
    gap: 5px;
}

/* 제품 찜 행 */
.product-wish-row {
    margin-top: 10px;
}

.wish-checkbox {
    display: flex;
    align-items: center;
    gap: 5px;
}

.wish-checkbox input[type="checkbox"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
    accent-color: #fa9660;
}

.wish-checkbox label {
    cursor: pointer;
    font-size: 14px;
    color: #666;
}

/* 가격 */
.product-price {
    font-size: 24px;
    font-weight: bold;
    color: #fa9660;
    text-align: center;
}

/* 후기 및 별점 섹션 */
.review-rating-section {
    text-align: left;
    padding-left: 20px;
}

.review-count {
    font-size: 14px;
    color: #666;
    margin-bottom: 8px;
}

.rating-display {
    display: flex;
    align-items: center;
    gap: 10px;
}

.rating-score {
    font-size: 18px;
    font-weight: bold;
    color: #fa9660;
}

.star-rating {
    display: flex;
    gap: 2px;
}

.star {
    font-size: 20px;
    line-height: 1;
}

.star.filled {
    color: #ffc107; /* 노란색 별 */
}

.star.empty {
    color: #ddd; /* 회색 별 */
}

/* 공홈go 아이콘 */
.official-link-box {
    text-align: center;
}

.official-link-icon {
    display: inline-block;
    padding: 10px 20px;
    background: #0f253c;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer; /* 마우스 올리면 손가락 커서 */
    transition: all 0.3s;
}

.official-link-icon:hover {
    background: #1a3a5a;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    cursor: pointer; /* 호버 시에도 손가락 커서 유지 */
}

/* 빈 목록 메시지 */
.empty-message {
    text-align: center;
    padding: 60px 20px;
    color: #999;
    font-size: 16px;
}

.empty-message p {
    margin: 10px 0;
}
</style>

<div class="portfolio-container">
    <div class="portfolio-header">
        <h2>${subcategory} 포트폴리오</h2>
        
        <!-- 정렬 옵션 -->
        <div class="sort-options">
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=${subcategory}&sort=popular" 
               class="${sortType == 'popular' || sortType == null || sortType == '' ? 'active' : ''}">
                인기상품순
            </a>
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=${subcategory}&sort=price_low" 
               class="${sortType == 'price_low' ? 'active' : ''}">
                낮은가격순
            </a>
            <a href="${pageContext.request.contextPath}/portfolio.do?sub=${subcategory}&sort=price_high" 
               class="${sortType == 'price_high' ? 'active' : ''}">
                높은가격순
            </a>
        </div>
    </div>
    
    <!-- 제품 목록 테이블 (항상 표시) -->
    <table class="product-list-table">
        <thead>
            <tr>
                <th style="width: 200px;">이미지</th>
                <th style="width: 400px;">제품 정보</th>
                <th style="width: 300px;">후기 및 별점</th>
                <th style="width: 150px;">구매</th>
                <c:if test="${sessionScope.userid == 'admin'}">
                    <th style="width: 150px;">관리</th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty list || list.size() == 0}">
                    <tr>
                        <td colspan="${sessionScope.userid == 'admin' ? '5' : '4'}" style="text-align: center; padding: 60px 20px; color: #999;">
                            등록된 제품이 없습니다.
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="product" items="${list}">
                        <tr>
                            <!-- 제품 이미지 -->
                            <td style="text-align: center;">
                                <img src="${pageContext.request.contextPath}/${product.image_path}" 
                                     alt="${product.product_name}" 
                                     class="product-image"
                                     onerror="this.src='${pageContext.request.contextPath}/images/image_1.jpg'">
                            </td>
                            
                            <!-- 제품 정보: 제목(윗줄) + 관심(찜, wish)(아래줄) -->
                            <td>
                                <div class="product-info">
                                    <!-- 윗줄: 제목 -->
                                    <div class="product-title">${product.product_name}</div>
                                    <!-- 아래줄: 관심(찜) -->
                                    <div class="product-wish-row">
                                        <span class="wish-checkbox">
                                            <input type="checkbox" id="wish_${product.pno}" name="wish" value="${product.pno}">
                                            <label for="wish_${product.pno}">관심(찜)</label>
                                        </span>
                                    </div>
                                </div>
                            </td>
                            
                            <!-- 후기 및 별점 -->
                            <td>
                                <div class="review-rating-section">
                                    <div class="review-count">후기 ${product.review_count}개</div>
                                    <div class="rating-display">
                                        <%
                                            // 별점 계산 (임시: review_count가 있으면 평균 4.0~5.0 사이 랜덤, 없으면 0)
                                            model.ProductDto prod = (model.ProductDto) pageContext.getAttribute("product");
                                            double avgRating = 0.0;
                                            if(prod != null && prod.getReview_count() > 0) {
                                                // 임시로 review_count 기반으로 별점 생성 (실제로는 DB에서 가져와야 함)
                                                // 예: 후기가 많을수록 높은 점수
                                                int reviewCount = prod.getReview_count();
                                                if(reviewCount >= 100) {
                                                    avgRating = 4.5 + (Math.random() * 0.5); // 4.5 ~ 5.0
                                                } else if(reviewCount >= 50) {
                                                    avgRating = 4.0 + (Math.random() * 0.5); // 4.0 ~ 4.5
                                                } else if(reviewCount >= 20) {
                                                    avgRating = 3.5 + (Math.random() * 0.5); // 3.5 ~ 4.0
                                                } else {
                                                    avgRating = 3.0 + (Math.random() * 1.0); // 3.0 ~ 4.0
                                                }
                                                // 소수점 첫째자리까지
                                                avgRating = Math.round(avgRating * 10.0) / 10.0;
                                            }
                                            pageContext.setAttribute("avgRating", avgRating);
                                            
                                            // 별 개수 계산 (0~5)
                                            int filledStars = (int) Math.round(avgRating);
                                            if(filledStars > 5) filledStars = 5;
                                            if(filledStars < 0) filledStars = 0;
                                            pageContext.setAttribute("filledStars", filledStars);
                                        %>
                                        <span class="rating-score">${avgRating}</span>
                                        <div class="star-rating">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= filledStars}">
                                                        <span class="star filled">★</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="star empty">☆</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            
                            <!-- 공홈go 아이콘 -->
                            <td class="official-link-box">
                                <c:choose>
                                    <c:when test="${not empty product.buy_link}">
                                        <a href="${product.buy_link}" 
                                           target="_blank" 
                                           class="official-link-icon"
                                           title="공식 홈페이지에서 구매하기">
                                            공홈go
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999; font-size: 14px;">링크 없음</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <!-- 관리자용 수정/삭제 버튼 -->
                            <c:if test="${sessionScope.userid == 'admin'}">
                                <td style="text-align: center;">
                                    <button type="button" 
                                            class="admin-btn edit-btn" 
                                            onclick="location.href='${pageContext.request.contextPath}/admin/product/edit.do?pno=${product.pno}&sub=${subcategory}'"
                                            style="padding: 8px 15px; margin: 0 5px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;">
                                        수정
                                    </button>
                                    <button type="button" 
                                            class="admin-btn delete-btn" 
                                            onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='${pageContext.request.contextPath}/admin/product/delete.do?pno=${product.pno}&sub=${subcategory}'; }"
                                            style="padding: 8px 15px; margin: 0 5px; background: #f44336; color: white; border: none; border-radius: 5px; cursor: pointer;">
                                        삭제
                                    </button>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
        <!-- 관리자용 추가 버튼 -->
        <c:if test="${sessionScope.userid == 'admin'}">
            <tfoot>
                <tr>
                    <td colspan="${sessionScope.userid == 'admin' ? '5' : '4'}" style="text-align: right; padding: 20px;">
                        <button type="button" 
                                class="admin-btn add-btn" 
                                onclick="location.href='${pageContext.request.contextPath}/admin/product/add.do?sub=${subcategory}'"
                                style="padding: 12px 25px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold;">
                            + 상품 추가
                        </button>
                    </td>
                </tr>
            </tfoot>
        </c:if>
    </table>
</div>

<%@ include file="footer.jsp" %>

<script>
// wish 체크박스 클릭 이벤트 (선택사항 - 나중에 찜 기능 구현 시 사용)
$(function() {
    $('input[name="wish"]').click(function() {
        var pno = $(this).val();
        var isChecked = $(this).is(':checked');
        
        // TODO: 찜 기능 구현 시 AJAX로 서버에 전송
        if(isChecked) {
            console.log('제품 ' + pno + '를 찜 목록에 추가');
        } else {
            console.log('제품 ' + pno + '를 찜 목록에서 제거');
        }
    });
});
</script>
