<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type = "text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
	#con_main {
		width : 1000px;
		height : 250px;
	}
	#con_text {
		margin-top : 30px;
		font-family: 'Gowun Dodum', sans-serif;
		text-decoration: none;
	}
	#con_button {
		margin-top : 80px;
	}
</style>
<div class = "align-center">
	<div class = "container" id = "con_main">
		<h2 id = "con_text">결제가 완료 되었습니다!!</h2>
		<div id = "con_button">
			<input type = "button" class = "btn btn-outline-dark" id = "main_btn" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'">
			<input type = "button" class = "btn btn-outline-dark" id = "cate_btn" value = "카테고리" onclick = "location.href='${pageContext.request.contextPath}/store/storeCategory.do'">
		</div>
	</div>
</div>