<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../header.jsp" %>

<style>
.product-form-container {
    width: 800px;
    margin: 40px auto;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.product-form-container h2 {
    font-size: 28px;
    color: #333;
    margin-bottom: 30px;
    text-align: center;
}

.form-group {
    margin-bottom: 25px;
}

.form-group label {
    display: block;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
    font-size: 14px;
}

.form-group input[type="text"],
.form-group input[type="number"],
.form-group input[type="url"],
.form-group select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    box-sizing: border-box;
}

.form-group input[type="file"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.form-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    min-height: 100px;
    resize: vertical;
    box-sizing: border-box;
}

.form-group .help-text {
    font-size: 12px;
    color: #666;
    margin-top: 5px;
}

.form-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 30px;
}

.btn {
    padding: 12px 30px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-submit {
    background: #2196F3;
    color: white;
}

.btn-submit:hover {
    background: #1976D2;
}

.btn-cancel {
    background: #999;
    color: white;
}

.btn-cancel:hover {
    background: #777;
}

.preview-image {
    max-width: 200px;
    max-height: 200px;
    margin-top: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    display: none;
}
</style>

<div class="product-form-container">
    <h2>${empty product ? '상품 추가' : '상품 수정'}</h2>
    
    <form id="productForm" action="${pageContext.request.contextPath}/admin/product/${empty product ? 'addpro' : 'updatepro'}.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="pno" value="${product.pno}">
        <input type="hidden" name="subcategory" value="${subcategory}">
        
        <!-- 카테고리 (하위카테고리에 따라 자동 설정) -->
        <div class="form-group">
            <label for="category">카테고리 *</label>
            <%
                String currentSubcategory = (String) pageContext.getAttribute("subcategory");
                if(currentSubcategory == null) {
                    model.ProductDto prod = (model.ProductDto) pageContext.getAttribute("product");
                    if(prod != null) {
                        currentSubcategory = prod.getSubcategory();
                    }
                }
                
                // 하위카테고리에 따라 카테고리 자동 판단
                String autoCategory = "";
                if(currentSubcategory != null) {
                    if(currentSubcategory.equals("런닝머신") || currentSubcategory.equals("사이클") || 
                       currentSubcategory.equals("로잉머신") || currentSubcategory.equals("스텝퍼")) {
                        autoCategory = "유산소";
                    } else if(currentSubcategory.equals("벤치프레스") || currentSubcategory.equals("덤벨") || 
                              currentSubcategory.equals("바벨") || currentSubcategory.equals("케이블머신")) {
                        autoCategory = "근력운동";
                    }
                }
                pageContext.setAttribute("autoCategory", autoCategory);
            %>
            <select name="category" id="category" required>
                <option value="">선택하세요</option>
                <option value="유산소" ${(product.category == '유산소' || autoCategory == '유산소') ? 'selected' : ''}>유산소</option>
                <option value="근력운동" ${(product.category == '근력운동' || autoCategory == '근력운동') ? 'selected' : ''}>근력운동</option>
            </select>
        </div>
        
        <!-- 하위카테고리 -->
        <div class="form-group">
            <label for="subcategory">하위카테고리 *</label>
            <input type="text" name="subcategory" id="subcategory" value="${empty product ? subcategory : product.subcategory}" required readonly style="background: #f5f5f5;">
            <span class="help-text">현재 하위카테고리: ${empty product ? subcategory : product.subcategory}</span>
        </div>
        
        <!-- 브랜드명 (사이트명) -->
        <div class="form-group">
            <label for="site_name">브랜드명 *</label>
            <input type="text" name="site_name" id="site_name" value="${product.site_name}" placeholder="예: 이고진, 반석" required>
        </div>
        
        <!-- 상품명 -->
        <div class="form-group">
            <label for="product_name">상품명 *</label>
            <input type="text" name="product_name" id="product_name" value="${product.product_name}" placeholder="상품명을 입력하세요" required>
        </div>
        
        <!-- 가격 -->
        <div class="form-group">
            <label for="price">가격 *</label>
            <input type="number" name="price" id="price" value="${product.price}" placeholder="예: 150000" min="0" required>
        </div>
        
        <!-- 후기 개수 -->
        <div class="form-group">
            <label for="review_count">후기 개수</label>
            <input type="number" name="review_count" id="review_count" value="${empty product.review_count ? 0 : product.review_count}" placeholder="예: 120" min="0">
        </div>
        
        <!-- 이미지 첨부 -->
        <div class="form-group">
            <label for="image_file">대표 이미지 ${empty product ? '*' : ''}</label>
            <input type="file" name="image_file" id="image_file" ${empty product ? 'required' : ''} accept="image/*">
            <span class="help-text">상품 대표 이미지를 선택하세요 (JPG, PNG 등, 최대 10MB)</span>
            <c:if test="${not empty product.image_path}">
                <div style="margin-top: 10px;">
                    <p style="font-size: 12px; color: #666;">현재 이미지: ${product.image_path}</p>
                    <img src="${pageContext.request.contextPath}/${product.image_path}" alt="현재 이미지" class="preview-image" style="display: block; max-width: 300px;">
                    <p style="font-size: 12px; color: #999; margin-top: 5px;">새 이미지를 선택하면 기존 이미지가 교체됩니다.</p>
                </div>
            </c:if>
            <img id="preview" class="preview-image" alt="미리보기">
        </div>
        
        <!-- 구매 링크 (공홈go URL) -->
        <div class="form-group">
            <label for="buy_link">구매 링크 (공홈go URL)</label>
            <input type="url" name="buy_link" id="buy_link" value="${product.buy_link}" placeholder="https://www.example.com/product">
            <span class="help-text">공식 홈페이지 구매 링크를 입력하세요</span>
        </div>
        
        <!-- 버튼 -->
        <div class="form-actions">
            <button type="submit" class="btn btn-submit">${empty product ? '추가하기' : '수정하기'}</button>
            <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
        </div>
    </form>
</div>

<script>
// 이미지 미리보기
document.getElementById('image_file').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('preview').src = e.target.result;
            document.getElementById('preview').style.display = 'block';
        };
        reader.readAsDataURL(file);
    }
});

// 카테고리 변경 시 하위카테고리 자동 설정 (추가 모드일 때만)
document.getElementById('category').addEventListener('change', function() {
    const category = this.value;
    const subcategoryInput = document.getElementById('subcategory');
    
    if (category === '유산소') {
        // 유산소 하위카테고리 목록
        // 실제로는 서버에서 가져와야 하지만, 여기서는 간단히 처리
    } else if (category === '근력운동') {
        // 근력운동 하위카테고리 목록
    }
});
</script>

<%@ include file="../../footer.jsp" %>
