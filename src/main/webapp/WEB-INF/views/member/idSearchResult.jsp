<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

<div class = "container-fluid contents-wrap" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">

	<h3>아이디 찾기 결과</h3>
	
	<br/>

	<%-- 아이디 찾기 실패 시 --%>
	<c:if test = "${count == 0}">
		<div class = "text-center">
			<p>정보가 일치하지 않습니다.</p>
		</div>
	</c:if>
	
	<%-- 아이디 찾기 성공 시 --%>
	<c:if test = "${count > 0}">
		
		<table class="table table-sm">
			<tr>
				<th scope="col">
					<div align="center">가입 된 회원 아이디</div>
				</th>
			</tr>
			<c:forEach var="member" items = "${list}">
				<tr scope="col">
					<td align="center"> 
						<div align="center" style="font-weight:bold; font-size:24px; background-color: #F5A100; color:#FAFAFA; width :60%; height: 60%;">${member.mem_id}</div>
					</td>
				</tr>
				<tr scope="col">
					<td align="center"> 
					</td>
				</tr>
				
			</c:forEach>
		</table>
	</c:if>
	
	<div class = "text-right">
		<input type = "button" class = "btn btn-outline-dark" value = "뒤로 가기" onclick = "history.go(-1);">
		<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'">
		<input type = "button" class = "btn btn-outline-dark" value = "로그인하기" onclick = "location.href='${pageContext.request.contextPath}/member/login.do'">
	</div>
</div>