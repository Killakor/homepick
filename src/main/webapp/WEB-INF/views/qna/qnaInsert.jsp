<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.submit{
    cursor: pointer;
    touch-action: manipulation;
    box-sizing: border-box;
    display: inline-block;
    border-width: 1px;
    border-style: solid;
    text-align: center;
    border-radius: 4px;
    font-weight: bold;
    line-height: 1;
    height: 60px;
    padding: 21px 0;
    font-size: 18px;
    transition: .2s ease;
    background-color: #F5A100;
    border-color: #F5A100;
    color: #ffffff;
    user-select: none;
    width: 250px;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$('#qnaInsertForm').submit(function(){
			if(confirm("등록하시겠습니까?")){
				if($('#qna_content').val().trim()==''){
					$('#qna_content').val('').focus();
					alert("질문내용을 입력해주세요!");
					return false;
				}
				if($('#qna_reply').val().trim()==''){
					$('#qna_reply').val('').focus();
					alert("답변내용을 입력해주세요!");
					return false;
				}
			}else{
				alert("취소되었습니다.");
				return false;
			}
		});

	});
</script>
<script type="text/javascript">
	var submit = document.getElementById('submit');
	submit.onclick = function() {
		var choice = confirm('글 등록을 하시겠습니까?');
		if(choice) {
			alert('등록이 완료되었습니다.');
		}
	};
</script>
<div class = "container-fluid contents-wrap" style = "width:70%">
   <div class="text-center col-sm-30 my-5">

<div align = "left">
	<h3>관리자 - 자주묻는질문 등록</h3>
</div>
<div align = "right">
	<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='qnaList.do'">
</div>
	<hr noshade="noshade" size="2"><br>
		<div align="center" class = "container-fluid" style = "width:900px; border: 1px solid #b8b8b8; font-family: 'Gowun Dodum', sans-serif; ">
			<div class="text-center col-sm-12 my-5">
			<form:form id="qnaInsertForm" action="qnaInsert.do" modelAttribute="qnaDTO">
				<div style="flex: auto;" class="input-group-prepend col-xs-2">
					<label class="input-group-text" for="qna_category" >카테고리</label>
					<select class="custom-select form-select-lg col-sm-3" name="qna_category" id="qna_category">
						<option value="주문/결제">주문/결제</option>
						<option value="배송관련">배송관련</option>
						<option value="취소/환불">취소/환불</option>
						<option value="반품/교환">반품/교환</option>
						<option value="증빙서류발급">증빙서류발급</option>
						<option value="회원정보변경">회원정보변경</option>
						<option value="서비스/기타">서비스/기타</option>
					</select>
				</div>
				<div style="display: inline-block;"><hr size="1" noshade="noshade"></div>
				<div class = "form-group row" style="width:750px; height:160px;">
					<label class = "col-sm-3 col-form-label" for="qna_content"></label>
					<textarea rows="1" style="height:160px;" class="form-control" name="qna_content" id="qna_content" maxlength="500" placeholder="Q: 질문 내용"></textarea>
					<form:errors path="qna_content" cssClass="error-color"/>
				</div><br>
				<div class = "form-group row" style="width:750px; height:160px;">
					<label class = "col-sm-3 col-form-label" for="qna_reply"></label>
					<textarea rows="1" style="height:160px;" class="form-control" name="qna_reply" id="qna_reply" maxlength="500" placeholder="A: 답변 내용"></textarea>
					<form:errors path="qna_reply" cssClass="error-color"/>
				</div><br>
				<!-- 버튼 -->
				<div class="align-center">
					<input class = "submit" type="submit" value="등록">
				</div>
			</form:form>
		</div>
		</div>
	</div>
</div>		
