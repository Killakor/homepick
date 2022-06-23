<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width,initial-scale=1">
<div class = "container-fluid contents-wrap" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	<div align = "left">
		<h3>아이디 찾기 결과</h3>
	</div>
	<%-- 비밀번호 찾기 성공시 --%>
		<br>
	<table class="table table-sm">
			<tr>
				<th scope="col"><div align="center">${id} 님의 비밀번호 찾기 결과</div></th>
			</tr>
			<tr>
				<td align="center"> 
				<div align="center" style="font-size:18px; background-color: #f5f5ff; width :60%; height: 60%;">
				 <b style="font-size: 24px;">${id}</b>님!! 입력하신 이메일 <b style="font-size: 24px; color: red;">(${email})</b>로 <br>임시 비밀번호를 보내드렸습니다!!<br>
				언제나 저희 홈픽을 이용해주셔서 감사합니다.</div></td>
			</tr>
		</table>
	<div class = "text-right">
			<input type = "button" class = "btn btn-outline-dark" value = "뒤로 가기" onclick = "history.go(-1);">
			<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'">
			<input type = "button" class = "btn btn-outline-dark" value = "로그인하기" onclick = "location.href='${pageContext.request.contextPath}/member/login.do'">
			
	</div>
</div>