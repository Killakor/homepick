<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
<div class="page-main">
	<h2>안내</h2>
	
	<!-- result 결과 정보 -->
	<div class="result-display">
		<div class="align-center">
			${accessMsg}
			<p>
				<input type="button" value="${accessBtn}" onclick="location.href='${accessUrl}'">
				<input type="button" value="메인" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</p>
		</div>
	</div>
</div>
</body>
</html>