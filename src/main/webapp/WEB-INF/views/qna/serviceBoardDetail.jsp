<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

.main {
	display: flex;
	justify-content: center;
	align-item: center;
}

.main-container {
	display: grid;
	grid-template-columns: repeat(4, 5fr);
	grid-auto-rows: minmax(80px, auto);
	grid-row-gap: 4 rem;
	grid-column-gap: 2rem;
}

.main-item:nth-child(1) {
	grid-column: 1/5;
	grid-row: 1/1;
}

.main-item:nth-child(2) {
	grid-column: 1/3;
	grid-row: 2/4;
}

.main-item:nth-child(3) {
	grid-column: 3/5;
	grid-row: 2/4;
}
</style>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript">
	$(function(){
		$('#sendEmailForm').submit(function(){
			if($('#service_reply').val().trim()==''){
				$('#service_reply').val('').focus();
				alert("내용을 입력해주세요!");
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="main">
	<div class="main-container">
	<div class="main-item">
	<div align = "left">
		<h3>1대1 이메일 질문 답변</h3>
		<hr width="100%" size="1" noshade="noshade">
	</div>
	</div>
	<div class="main-item">
	<ul style="-webkit-padding-start:0px;">
		<li>제목: ${ serviceboard.service_title }</li>
		<li>글번호: ${serviceboard.service_num }</li>
		<li>작성자 이메일: ${serviceboard.service_email }</li>
		<li>문의 유형: ${serviceboard.service_keyword }</li>
	</ul>
		<hr width="98%" size="1" noshade="noshade">
	<ul style="-webkit-padding-start:0px;">	
		<li>문의내용: ${serviceboard.service_content }</li>
	</ul>
	<c:if test="${!empty serviceboard.service_filename}">
	<div class="align-center">
		<img src="imageView.do?service_num=${serviceboard.service_num }" style="max-width:500px">
	</div>
	</c:if>
	</div>
	
	<%-- 폼 작성 부분 --%>
<div class="main-item">
	<div align="center">
		<div>
		<form id="sendEmailForm" action="sendEmail.do" method="Post">
			<div style="width:280px; height:180px; align:center;">
				<label for="service_reply"></label>
				<textarea rows="1" style="height:160px;" class="form-control" name="service_reply" id="service_reply" maxlength="300" placeholder="답변 내용 작성"></textarea>
				<form:errors path="service_reply" cssClass="error-color"/>
			</div><br>
				<input type="hidden" value="${serviceboard.service_email}" name="service_email" id="service_email">
			<div class = "form-group row">
				<div class = "text-center col-sm-12">
					<input class="btn btn-outline-dark" type="submit" id="email_send_button" value="이메일전송">&nbsp;&nbsp;
					<script type="text/javascript">
						var email_send_button = document.getElementById('email_send_button');
						email_send_button.onclick = function() {
							var choice = confirm('이메일 전송을 하시겠습니까?');
							if(choice) {
								alert('전송이 완료되었습니다.');
							}
						};
					</script>
				<input class="btn btn-outline-dark" type="button" value="목록" onclick="location.href='serviceBoardList.do'">
				</div>
			</div>	
		</form>
		</div>
	</div>	
</div>
</div>	
</div>
</body>
</html>