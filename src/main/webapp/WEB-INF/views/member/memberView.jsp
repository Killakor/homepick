<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<%@ include file="/WEB-INF/views/member/common/myPageProfile.jsp" %>

<script type="text/javascript">
	//사진 올리기
	$(function(){
		$(".mypage-photo-write").hover(function(){
			$(this).css("color", "#d9d4d4");
		}, function() {
		        $(this).css("color","black");
		});
	});
</script>

<%-- 관리자가 아닌경우 --%>
 <c:if test="${!empty user_num && user_auth != 4}">
	<div class="mypage-main-content" align="center">
		<div class="mypage-photo-write-divi">
			<a href="${pageContext.request.contextPath}/member/myBoard.do">사진 ${member.house_board_count}</a>
			
			<table style="border:1px dashed #b5b7ba; width:400px;">
				<tr>
					<td style="border:1px dashed #b5b7ba;" class="mypage-photo-write" align="center" onclick="location.href='${pageContext.request.contextPath}/houseBoard/write.do'">
						<span style="font-size: 25px;">+</span>
						<span style="font-size: 14px;">사진을 올려보세요</span>
					</td>			
				</tr>
			</table>	
			<br/>
			
			<a href="${pageContext.request.contextPath}/qna/qnaList.do">문의</a>
			
			<table style="border:1px dashed #b5b7ba; width:400px;">
				<tr style="border-style: dotted;">
				<td style="border:1px dashed #b5b7ba;" class="mypage-photo-write" align="center" onclick="location.href='${pageContext.request.contextPath}/qna/serviceBoardInsert.do'">
					<span style="font-size: 25px;">+</span>
					<span style="font-size: 14px;">고객센터 문의하기</span>
				</td>			
				</tr>
			</table>
		</div>
	</div>
</c:if>

<%-- 관리자인 경우 --%>
<c:if test="${!empty user_num && user_auth == 4}">
	<div style="float: right;">
		<input type = "button" class = "btn btn-outline-dark" value = "회원 전체 조회하기" onclick = "location.href='${pageContext.request.contextPath}/member/memberList.do'">
	</div>
 	<div class = "container-fluid contents-wrap" style = "float: left;">
		<div class="text-center col-sm-10 my-5">
			<h2 class="admin-page-h2"> 판매자 신청 내역</h2>
			<c:if test = "${count == 0}">
				<div class = "text-center">판매 신청한 회원이 없습니다.</div>
			</c:if>
			
			<c:if test = "${count > 0}">
				<table class="table table-sm">
					<tr>
						<th scope="col">회원 번호</th>
						<th scope="col">아이디</th>
						<th scope="col">회사명</th>
						<th scope="col">종목명</th>
						<th scope="col">회원등급</th>
					</tr>
					<c:forEach var = "memberBuis" items = "${list}">
						<tr>
							<th scope = "row">${memberBuis.mem_num}</th>
							<td>${memberBuis.mem_id}</td>
							<td>${memberBuis.buis_name}</td>
							<td>${memberBuis.buis_item}</td>
							<td>
								<c:if test="${memberBuis.mem_auth == 0}">탈퇴회원</c:if>
							    <c:if test="${memberBuis.mem_auth == 1}">정지회원</c:if>
							    <c:if test="${memberBuis.mem_auth == 2}">일반회원</c:if>
							    <c:if test="${memberBuis.mem_auth == 3}">판매회원</c:if>
							    <c:if test="${memberBuis.mem_auth == 4}">관리자</c:if>
							</td>
						</tr>
						</c:forEach>
					</table>
			
			<div class = "text-right">
			<br/>
				<input type = "button" class = "btn btn-outline-dark" value = "판매자 등록하러가기" onclick = "location.href='${pageContext.request.contextPath}/member/sellerApplyList.do'">
			</div>
			<br/>
			<hr noshade="noshade" size="1">
				
			</c:if>
		</div>
	</div>

	<div class = "container-fluid contents-wrap" style = "float: left;">
		<div class="text-center col-sm-10 my-5">
			<h2 class="admin-page-h2"> 이메일 문의 내역</h2>
			
			<c:if test = "${qnacount == 0}">
				<div class = "text-center">이메일 문의 내역이 없습니다.</div>
			</c:if>
			<c:if test = "${qnacount > 0}">
				<table class="table table-sm">
					<tr>
						<th scope="col">문의 번호</th>
						<th scope="col">키워드</th>
						<th scope="col">닉네임</th>
						<th scope="col">제목</th>
						<th scope="col">이메일</th>
					</tr>
					<c:forEach var = "serviceBoard" items = "${qnalist}">
						<tr>
							<th scope = "row">${serviceBoard.service_num}</th>
							<td>${serviceBoard.service_keyword}</td>
							<td>${serviceBoard.service_nickname}</td>
							<td>${serviceBoard.service_title}</td>
							<td>${serviceBoard.service_email}</td>
						</tr>
					</c:forEach>
				</table>
				<div class = "text-right">
				<br/>
					<input type = "button" class = "btn btn-outline-dark" value = "문의 확인하기" onclick = "location.href='${pageContext.request.contextPath}/qna/serviceBoardList.do'">
				</div>
				<br/>
				<hr noshade="noshade" size="1">
				
			</c:if>
		</div>
	</div>
</c:if>
 
<!-- 중앙 내용 끝 -->