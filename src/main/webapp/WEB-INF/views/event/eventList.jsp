<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.card {
	border:none;
}
.count {
	margin-top:15px;
	margin-bottom:25px;
}
ul {
	margin-right:5px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
 

<!-- 이벤트 목록 -->
<div class="event-list">
	<div class="container">
		<%-- 등록된 게시물이 없을 경우 --%>
		<c:if test="${eventCount == 0}">
			<div class="result-display">등록된 게시물이 없습니다.</div>
		</c:if>
		
		<%-- 등록된 게시물이 있을 경우 --%>
		<c:if test="${count > 0}">
		<b>[이벤트]</b><br>
		<div class="count">
			총 <b style="color:#F5A100">${count}</b>개의 글
		</div>
		
		<%-- 이벤트 목록 반복문 시작 --%>
		<div class="container">
			<div class="row mb-5 mr-7">
				<c:forEach var="event" items="${list}">
					<div class="col-3">
						<div class="card" style="width:255px; height:450px; text-align:center;">
							<div class="imgTransition" style="cursor:pointer; overflow:hidden;" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=${event.event_num}'">
								<%-- 사진파일이 없는 경우 --%>
								<c:if test="${empty event.event_filename}">
									<figure class="embed-responsive embed-responsive-1by1">
					            		<img class="card-img-top embed-responsive-item" id="thumbnail" src="${pageContext.request.contextPath}/resources/images/basic_house.png" style="width:100%; border-radius:1%;"/>
									</figure>
								</c:if>
								<%-- 사진파일이 있는 경우 --%>
								<c:if test="${!empty event.event_filename}">
					            	<figure class="embed-responsive embed-responsive-1by1">
					            		<img class="card-img-top embed-responsive-item" id="thumbnail" src="${pageContext.request.contextPath}/event/eventPhotoView.do?event_num=${event.event_num}" style="width:100%; border-radius:1%;"/>
					            	</figure>
					            </c:if>
								<div class="card-title" align="center">
									<h5><a href="${pageContext.request.contextPath}/event/eventDetail.do?event_num=${event.event_num}">${event.event_title}</a></h5>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		</c:if>
		<div class="paging" align="center">	
			<span>${pagingHtml}</span>
		</div>
	</div>
</div>

<hr size="1" width="100%" style="color:#bfbfbf; noshade;"><br>

<!-- 이벤트 목록 검색 -->
<div style="text-align:center;">
	<form id="search_form" action="eventList.do" method="get"  style="text-align:center;">
   		<ul class="search">
			<li>
				<select name="keyword" id="keyword" >
					<option value="">전체</option>
					<option value="진행중">진행중</option>
					<option value="종료">종료</option>
				</select>
				<input class = "btn btn-outline-dark" type="submit" value="찾기">
				<input class = "btn btn-outline-dark" type="button" value="목록" onclick="location.href='eventList.do'">
			</li>
		</ul>
   </form> 
</div>

<%-- 관리자 일 경우 이벤트 작성 버튼 활성화 --%>
<c:if test="${user_auth == 4}">
	<div align="right"> 		
		<input type="button" class="btn btn-outline-dark" value="이벤트 작성" onclick ="location.href='eventWrite.do'">
	</div>
</c:if>