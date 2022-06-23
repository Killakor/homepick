<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width,initial-scale=1">
<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	<div align = "left">
			<h3>비밀번호 찾기</h3>
	</div>
	<div class="text-center col-sm-14 my-5">
	<form:form id="passwdSearch_form" action="passwdSearchResult.do" modelAttribute="memberDTO">
		<form:errors element="div" align="left" cssClass="error-color"/>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for=mem_id>아이디</label>
				<form:input class = "col-sm-4 form-control" path="mem_id" placeholder="Ex)4자이상 12자이하"/>
				<form:errors path="mem_id" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="phone">전화번호</label>
				<form:input class = "col-sm-4 form-control" path="phone" placeholder="Ex)010-1234-5678"/>
				<form:errors path="phone" cssClass="error-color"/>
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-2 col-form-label" for="email">이메일&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="email" placeholder="Ex)everyHome@every.com"/>
				<form:errors path="email" cssClass="error-color"/>
		</div>
		<div class = "form-group row" style="padding-left: 3em;">
			<form:button class = "btn btn-outline-info">비밀번호 찾기</form:button>&nbsp;
			<input type = "button" class = "btn btn-outline-info" value = "아이디찾기" onclick = "location.href='${pageContext.request.contextPath}/member/idSearch.do'">&nbsp;
			<input type = "button" class = "btn btn-outline-dark" value = "로그인으로" onclick = "location.href='${pageContext.request.contextPath}/member/login.do'">&nbsp;
			<input type = "button" class = "btn btn-outline-dark" value = "회원가입으로" onclick = "location.href='${pageContext.request.contextPath}/member/registerUser.do'">
		</div>
	</div>
	</form:form><br>
	
</div>

