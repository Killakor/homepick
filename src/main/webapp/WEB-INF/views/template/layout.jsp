<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 레이아웃 name 타일즈 통해 받아오기 -->
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>

<body>
	<!-- Header -->
	<div id="container">
		<div id="main_header">
			<tiles:insertAttribute name="header"/>
		</div>
		
		<!-- Body - Container -->
		<div id="main_body">
			<tiles:insertAttribute name="body"/>
		</div>
		
		<!-- Footer -->
		<div id="main_footer">
			<tiles:insertAttribute name="footer"/>
		</div>
	</div>
</body>
</html>




