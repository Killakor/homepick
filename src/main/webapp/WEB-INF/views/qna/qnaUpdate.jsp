<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$('#qnaUpdateForm').submit(function(){
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
<div class = "container-fluid contents-wrap" style = "width:95%">
   <div class="text-center col-sm-30 my-5">
   <div align = "left">
		<h2 class="admin-page-h2">관리자 - 자주묻는 질문 리스트</h2>
	</div>
   <c:if test="${count==0 }">
  		<div class="text-center">
  			출력할 내용이 없습니다.
  		</div>
   	<div class = "text-right">
		<input type = "button" class = "btn btn-outline-dark" value = "돌아가기" onclick = "location.href='qnaServiceList.do'">&nbsp;
	</div>
	</c:if>
	
	<c:if test="${count > 0 }">	
	<div class = "text-right">
		<input type = "button" class = "btn btn-outline-dark" value = "돌아가기" onclick = "location.href='qnaServiceList.do'">&nbsp;
   </div>
   <table class="table table-sm">
   		<tr>
   			<th scope="col" style="width: 8%">문의번호</th>
			<th scope="col" style="width: 19%">키워드</th>
			<th scope="col" style="width: 24%">제목</th>
			<th scope="col" style="width: 44%">내용</th>

   		</tr>
   		<c:forEach var="serviceboard" items="${list }">
   		<tr>
   			<th scope = "row">${serviceboard.service_num}</th>
   			<td>${serviceboard.service_keyword}</td>
   			<td>${serviceboard.service_title}</td>
   			<td>${serviceboard.service_content}</td>
   		</tr>
   		</c:forEach>
   </table>
	</c:if>
   	<div class="align-center">${pagingHtml}</div>
	

<hr noshade="noshade" size="2">
<div align = "left">
	<h2 class="admin-page-h2">관리자 - 자주묻는질문 수정</h2>
</div>
	
		<div align="center" class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: 'Gowun Dodum', sans-serif; ">
			<div class="text-center col-sm-12 my-5">
			<!-- 폼 시작 -->
			<form:form id="qnaUpdateForm" action="qnaUpdate.do" modelAttribute="qnaDTO">
				<form:hidden path="qna_num"/>
				<div align="left">	
					<span style="font-weight: bold;">문의 번호 : ${qnaDTO.qna_num}</span>
				</div>
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
				<div class = "form-group row">		
					<label class = "col-sm-3 col-form-label" for="qna_content">질문내용</label>
					<textarea id="qna_content" name="qna_content" rows="5" cols="30">${qnaDTO.qna_content}</textarea>
				</div>
				<div class = "form-group row">		
					<label class = "col-sm-3 col-form-label" for="qna_reply">답변내용</label>
					<textarea id="qna_reply" name="qna_reply" rows="5" cols="30">${qnaDTO.qna_reply}</textarea>
				</div>
				<!-- 버튼 -->
				<div class="align-center">
					<input class = "btn btn-outline-dark" type="submit" value="등록">
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='qnaList.do'">
				</div>
			</form:form>
		</div>
		</div>
	</div>
</div>		