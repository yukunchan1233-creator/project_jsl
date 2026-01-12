<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%
	String category = request.getParameter("cat");
	if(category == null) category = "가슴";
	
	ProductDao dao = new ProductDao();
	List<String> subcategories = dao.selectSubcategories(category);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= category %> 운동기구 - 홈트레이닝</title>
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
		<h2><%= category %> 운동기구</h2>
		<p><%= category %> 운동에 최적화된 운동기구를 선택하세요</p>
	</div>
	
	<!-- 카테고리 목록 -->
	<div class="container">
		<div class="category-list">
			<% for(String sub : subcategories) { %>
			<div class="category-item" onclick="location.href='product.jsp?cat=<%= category %>&sub=<%= sub %>'">
				<h3><%= sub %></h3>
				<p>클릭하여 제품 보기</p>
			</div>
			<% } %>
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







