<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    

<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type ="text/javascript">
	$(document).ready(function() {
		
		// submit 버튼 클릭시 유효성 체크
		$("#idSearch_form").submit(function(){
			
			if($("#mem_name").val().trim() == "") {
				alert("이름을 입력해주세요.");
				$("#mem_name").val("").focus();
				return false;
			}
			if($("#phone").val().trim() == "") {
				alert("전화번호를 입력해주세요.");
				$("#phone").val("").focus();
				return false;
			}
		});
	});
</script>
<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">

	<h3>아이디 찾기</h3>

	<div class="text-center col-sm-14 my-5">
		<form:form id="idSearch_form" action="idSearchResult.do" modelAttribute="memberDTO">
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="mem_name">회원 이름</label>
				<form:input class = "col-sm-4 form-control" path="mem_name"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="phone">전화 번호</label>
				<form:input class = "col-sm-4 form-control" path="phone"/>
			</div>
			
			<br/>
			<div class = "form-group row" style="padding-left: 2em;">
				<form:button class = "btn btn-outline-dark">아이디 찾기</form:button>&nbsp;
				<input type = "button" class = "btn btn-outline-dark" value = "비밀번호 찾기" onclick = "location.href='${pageContext.request.contextPath}/member/passwdSearch.do'">&nbsp;
				<input type = "button" class = "btn btn-outline-dark" value = "로그인으로" onclick = "location.href='${pageContext.request.contextPath}/member/login.do'">&nbsp;
				<input type = "button" class = "btn btn-outline-dark" value = "회원가입으로" onclick = "location.href='${pageContext.request.contextPath}/member/registerUser.do'">
			</div>
		</form:form>
		<br/>
	</div>
</div>
