<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%
	String pnoStr = request.getParameter("pno");
	int pno = 0;
	if(pnoStr != null) {
		pno = Integer.parseInt(pnoStr);
	}
	
	ProductDao dao = new ProductDao();
	ProductDto dto = dao.selectProduct(pno);
	
	if(dto == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	// 상세 이미지들을 배열로 분리 (쉼표로 구분)
	String[] detailImages = null;
	if(dto.getDetail_images() != null && !dto.getDetail_images().isEmpty()) {
		detailImages = dto.getDetail_images().split(",");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= dto.getProduct_name() %> - 상세보기</title>
<link rel="stylesheet" href="css/hometraining.css">
</head>
<body>
	<!-- 상단 네비게이션 -->
	<div class="top_navigation">
		<header class="header">
			<nav class="top_left">
				<ul>
					<li><a href="index.jsp">홈으로</a></li>
				</ul>
			</nav>
			<nav class="top_right">
				<ul>
					<li><a href="">로그인</a></li>
					<li><a href="">회원가입</a></li>
				</ul>
			</nav>
		</header>
	</div>
	
	<!-- 메인 메뉴 -->
	<div class="gnb_group">
		<h1>🏋️ 홈트레이닝 운동기구</h1>
		<nav class="gnb">
			<ul class="nav_1depth">
				<li>
					<a href="category.jsp?cat=가슴">가슴</a>
					<ul class="dropdown">
						<li><a href="product.jsp?cat=가슴&sub=벤치프레스">벤치프레스</a></li>
						<li><a href="product.jsp?cat=가슴&sub=딥스">딥스</a></li>
						<li><a href="product.jsp?cat=가슴&sub=푸쉬업바">푸쉬업바</a></li>
					</ul>
				</li>
				<li>
					<a href="category.jsp?cat=등">등</a>
					<ul class="dropdown">
						<li><a href="product.jsp?cat=등&sub=풀업바">풀업바</a></li>
						<li><a href="product.jsp?cat=등&sub=케이블머신">케이블머신</a></li>
						<li><a href="product.jsp?cat=등&sub=랫풀다운">랫풀다운</a></li>
					</ul>
				</li>
				<li>
					<a href="category.jsp?cat=하체">하체</a>
					<ul class="dropdown">
						<li><a href="product.jsp?cat=하체&sub=스쿼트랙">스쿼트랙</a></li>
						<li><a href="product.jsp?cat=하체&sub=레그프레스">레그프레스</a></li>
						<li><a href="product.jsp?cat=하체&sub=덤벨">덤벨</a></li>
					</ul>
				</li>
				<li>
					<a href="category.jsp?cat=유산소">유산소</a>
					<ul class="dropdown">
						<li><a href="product.jsp?cat=유산소&sub=러닝머신">러닝머신</a></li>
						<li><a href="product.jsp?cat=유산소&sub=자전거">자전거</a></li>
						<li><a href="product.jsp?cat=유산소&sub=로잉머신">로잉머신</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
	
	<!-- 제품 상세 정보 -->
	<div class="product-detail">
		<h2><%= dto.getProduct_name() %></h2>
		
		<div class="product-info">
			<div class="product-main-image">
				<% if(dto.getImage_path() != null) { %>
				<img src="<%= dto.getImage_path() %>" alt="<%= dto.getProduct_name() %>">
				<% } else { %>
				<img src="images/no-image.jpg" alt="이미지 없음">
				<% } %>
			</div>
			<div class="product-details">
				<h3><%= dto.getSite_name() %> - <%= dto.getProduct_name() %></h3>
				<div class="price"><%= String.format("%,d", dto.getPrice()) %>원</div>
				<div class="review">후기: <%= dto.getReview_count() %>개</div>
				<div style="margin-top:30px;">
					<strong>카테고리:</strong> <%= dto.getCategory() %> > <%= dto.getSubcategory() %>
				</div>
			</div>
		</div>
		
		<!-- 상세 이미지 갤러리 -->
		<% if(detailImages != null && detailImages.length > 0) { %>
		<div class="detail-gallery">
			<h3>제품 상세 이미지</h3>
			<div class="gallery-images">
				<% for(String img : detailImages) { %>
					<% if(img != null && !img.trim().isEmpty()) { %>
					<img src="<%= img.trim() %>" alt="제품 상세 이미지">
					<% } %>
				<% } %>
			</div>
		</div>
		<% } %>
		
		<!-- 구매 링크 -->
		<div class="buy-link">
			<a href="<%= dto.getBuy_link() %>" target="_blank">
				🛒 <%= dto.getSite_name() %>에서 구매하기
			</a>
		</div>
	</div>
	
	<!-- 푸터 -->
	<footer class="footer">
		<div class="footer-inner">
			<p>Copyright 홈트레이닝 운동기구 &copy; All Rights Reserved</p>
		</div>
	</footer>
</body>
</html>







