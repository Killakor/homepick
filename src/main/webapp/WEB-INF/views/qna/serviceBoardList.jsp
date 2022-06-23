<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<div class = "container-fluid contents-wrap" style = "width:99%"> 
   <div align = "left">
		<h3>이메일 문의 목록</h3><br>
	</div>
    <form id="search_form" action="serviceBoardList.do" method="get">
   		<ul class="search" style="-webkit-padding-start:3px;">
			<li>
				<select name="keyword" id="keyword">
					<option value="">전체</option>
					<option value="회원 정보 문의">회원 정보 문의</option>
					<option value="쿠폰/포인트 문의">쿠폰/포인트 문의</option>
					<option value="주문/결제 관련 문의">주문/결제 관련 문의</option>
					<option value="취소/환불 관련 문의">취소/환불 관련 문의</option>
					<option value="배송 관련 문의">배송 관련 문의</option>
					<option value="주문 전 상품 정보 문의">주문 전 상품 정보 문의</option>
					<option value="서비스 개선 제안">서비스 개선 제안</option>
					<option value="시스템 오류 제보">시스템 오류 제보</option>
					<option value="불편 신고">불편 신고</option>
					<option value="기타 문의">기타 문의</option>
				</select>
					&nbsp;&nbsp;
					<input class = "btn btn-outline-dark" type="submit" value="찾기">&nbsp;&nbsp;
					<input class = "btn btn-outline-dark" type="button" value="목록" onclick="location.href='serviceBoardList.do'">
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<input type = "button" class = "btn btn-outline-dark" value = "돌아가기" onclick = "location.href='qnaList.do'">
			</li>
		</ul>
   </form> 

<hr noshade="noshade" size="2">  
	<div class="text-center col-sm-30 my-5">
   	
   <c:if test="${count==0 }">
  		<div class="text-center">
  			출력할 내용이 없습니다.
  		</div>
	</c:if>
	
	<c:if test="${count > 0 }">	
   <table class="table table-sm">
   		<tr>
   			<th scope="col" style="width: 6%">문의번호</th>
			<th scope="col" style="width: 12%">키워드</th>
			<th scope="col" style="width: 12%">닉네임</th>
			<th scope="col" style="width: 19%">제목</th>
			<th scope="col" style="width: 30%">내용</th>
			<th scope="col" style="width: 19%">이메일</th>

   		</tr>
   		<c:forEach var="serviceboard" items="${list }">
   		<tr>
   			<th scope = "row">${serviceboard.service_num}</th>
   			<td>${serviceboard.service_keyword}</td>
   			<td>${serviceboard.service_nickname}</td>
   			<td><a href="${pageContext.request.contextPath}/qna/serviceBoardDetail.do?service_num=${serviceboard.service_num}">${serviceboard.service_title}</a></td>
   			<td>${serviceboard.service_content}</td>
   			<td>${serviceboard.service_email}</td>
   		</tr>
   		</c:forEach>
   </table>
	</c:if>
   	<div class="align-center">${pagingHtml}</div>
</div>
</div>