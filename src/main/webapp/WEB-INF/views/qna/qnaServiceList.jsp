<%@page import="org.hibernate.validator.constraints.Length"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('input[type=checkbox]:checked').prop("checked", false);
		
		$('#del_btn').click(function() {		// 질문삭제 클릭시
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			
			  	var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 질문이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("삭제하시겠습니까?")){
			    
						$.ajax({
							url: 'qnaDelete.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('삭제 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		    	}
		});	// 회원정지 끝
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
		<input type = "button" class = "btn btn-outline-dark" value = "고객센터" onclick = "location.href='qnaList.do'">&nbsp;
		<input type = "button" class = "btn btn-outline-dark" value = "질문등록" onclick = "location.href='qnaInsert.do'">&nbsp;
	</div>
	</c:if>
	
	<c:if test="${count > 0 }">	
	<div class = "text-right">
		<input type = "button" class = "btn btn-outline-dark" value = "고객센터" onclick = "location.href='qnaList.do'">&nbsp;
		<input type = "button" class = "btn btn-outline-dark" value = "질문등록" onclick = "location.href='qnaInsert.do'">&nbsp;
		<input type = "button" class = "btn btn-outline-dark" value = "질문삭제" id = "del_btn">
   </div>
   <table class="table table-sm">
   		<tr>
   			<th scope="col" style="width: 8%">질문번호</th>
			<th scope="col" style="width: 19%">분류</th>
			<th scope="col" style="width: 28%">질문내용</th>
			<th scope="col" style="width: 28%">답변내용</th>
			<th scope="col" style="width: 5%">선택</th>
			<th scope="col" style="width: 7%">수정</th>
   		</tr>
   		<c:forEach var="qna" items="${list }">
   		<tr>
   			<th scope = "row">${qna.qna_num}</th>
   			<td>${qna.qna_category}</td>
   			<td>${qna.qna_content}</td>
   			<td>${qna.qna_reply}</td>
   			<td>
   				<input type = "checkbox" aria-label="Checkbox for following text input" value = "${qna.qna_num}">
   			</td>
   			<td><input class = "btn btn-outline-dark" type="button" value="수정" onclick="location.href='qnaUpdate.do?qna_num=${qna.qna_num}'"></td>
   		</tr>
   		</c:forEach>
   </table>
	</c:if>
   	<div class="align-center">${pagingHtml}</div>
	</div>
</div>
