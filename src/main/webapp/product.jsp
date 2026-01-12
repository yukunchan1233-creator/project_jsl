<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%
	String category = request.getParameter("cat");
	String subcategory = request.getParameter("sub");
	if(category == null) category = "가슴";
	if(subcategory == null) subcategory = "벤치프레스";
	
	ProductDao dao = new ProductDao();
	List<ProductDto> list = dao.selectProducts(category, subcategory);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= category %> - <%= subcategory %> - 홈트레이닝</title>
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
	</div>
	
	<!-- 서브 비주얼 -->
	<div class="subvisual">
		<h2><%= category %> - <%= subcategory %></h2>
		<p>다양한 브랜드의 <%= subcategory %> 제품을 비교해보세요</p>
	</div>
	
	<!-- 제품 목록 테이블 -->
	<div class="container">
		<table class="product-table">
			<thead>
				<tr>
					<th>사이트</th>
					<th>제품명</th>
					<th>가격</th>
					<th>후기 개수</th>
					<th>상세보기</th>
				</tr>
			</thead>
			<tbody>
				<% if(list.size() == 0) { %>
				<tr>
					<td colspan="5" style="text-align:center; padding:40px;">
						등록된 제품이 없습니다.
					</td>
				</tr>
				<% } else { %>
					<% for(ProductDto dto : list) { %>
					<tr>
						<td><%= dto.getSite_name() %></td>
						<td><%= dto.getProduct_name() %></td>
						<td><%= String.format("%,d", dto.getPrice()) %>원</td>
						<td><%= dto.getReview_count() %>개</td>
						<td>
							<button class="view-btn" onclick="location.href='detail.jsp?pno=<%= dto.getPno() %>'">
								보기
							</button>
						</td>
					</tr>
					<% } %>
				<% } %>
			</tbody>
		</table>
	</div>
	
	<!-- 푸터 -->
	<footer class="footer">
		<div class="footer-inner">
			<p>Copyright 홈트레이닝 운동기구 &copy; All Rights Reserved</p>
		</div>
	</footer>
</body>
</html>







