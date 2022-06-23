<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<%@ include file="/WEB-INF/views/member/common/myPageProfile.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script type="text/javascript">
	$(function() {
		//비밀번호 수정 체크
		$('#passwd').keyup(function() {
			if($('#confirm_passwd').val() != '' && $('#confirm_passwd').val()!= $(this).val()){
				$('#message_id').text('비밀번호가 불일치 합니다.').css('color','red');
			}else if($('#confirm_passwd').val() != '' && $('#confirm_passwd').val() == $(this).val()){
				$('#message_id').text('비밀번호 일치합니다.').css('color','blue');
			}
		});
		
		$('#confirm_passwd').keyup(function() {
			if($('#passwd').val() != '' && $('#passwd').val()!= $(this).val()){
				$('#message_id').text('비밀번호가 불일치 합니다.').css('color','red');
			}else if($('#passwd').val() != '' && $('#passwd').val() == $(this).val()){
				$('#message_id').text('비밀번호 일치합니다.').css('color','blue');
			}
		});
		
		$('#UpdatePasswdForm').submit(function() {
			if($('#now_passwd').val().trim()==''){
				alert('현재 비밀번호를 입력해주세요.');
				$('#now_passwd').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('변경할 비밀번호를 입력해주세요.');
				$('#passwd').val('').focus();
				return false;
			}
			if($('#confirm_passwd').val().trim()==''){
				alert('변경할 비밀번호 확인을 입력해주세요.');
				$('#confirm_passwd').val('').focus();
				return false;
			}
			if($('#passwd').val() != $('#confirm_passwd').val()){
				$('#message_id').text('비밀번호가 불일치 합니다.').css('color','red');
				return false;
			}
		});
	});
</script>

<div class = "container-fluid" style = "width:500px; font-family: 'Gowun Dodum', sans-serif; ">

	<h3>비밀번호 변경</h3>

	<div class="text-center col-sm-12 my-5">
		<form:form id="UpdatePasswdForm" action="memberPasswdUpdate.do" modelAttribute="memberDTO">
			
			<div class = "form-group row">	
				<label class="col-sm-4" for="now_passwd">현재 비밀번호</label>
				<form:password path="now_passwd" class="col-sm-7" placeholder="8~16자리 영문/숫자/특수문자"/>
				<form:errors path="now_passwd" cssClass="error-color"/>
			</div>
			
			<div class = "form-group row">	
				<label class="col-sm-4" for="passwd">변경 비밀번호</label>
				<form:password path="passwd" class="col-sm-7" placeholder="8~16자리 영문/숫자/특수문자"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</div>
			
			<div class = "form-group row">	
				<label class="col-sm-4" for="confirm_passwd">비밀번호 확인</label>
				<input type="password" id="confirm_passwd" class="col-sm-7" placeholder="8~16자리 영문/숫자/특수문자"/>
				<span id="message_id" class="error-color"></span>
			</div>
			
			<div class = "form-group row">
				<div class = "text-center col-sm-10">
					<form:button class = "btn btn-outline-dark">전송</form:button>
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</div>
		</form:form>
	
	</div>
</div>
