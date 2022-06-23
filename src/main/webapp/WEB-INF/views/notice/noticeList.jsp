<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
.name-item{
	align-items: center;
}
.link-container{
width:1136px;
margin : 0 auto;
}
.container{
margin : 0 auto;
width:1138px;
}

.title{
	font-size:22px;
	weight:800;
	padding-left :30px;
	text-align:left;
	cursor: pointer;

}
.reg_date{
	font-size:15px;
	text-align:right;
	padding-right : 50px;
}
.paging {
	text-align:center;
	padding : 50px;
	margin-top : 40px;
}
h2{
	text-align:left;
	margin : 70px 0px 50px 130px;
}
.write-button{
	text-align: right;
	margin : 40px 100px 0px 30px;
}
</style>
<div class="container"> 
 <div class="main-container">
 	<div class="name-item mb-5 pb-5" align="center">
 	<h2 style="">공지사항</h2>
 	</div>
 		<c:if test="${count==0}">
 		<div class="container mt-5">
 		<div class="link-item mb-5 mb-5" style="text-align:center;">출력할 내용이 없습니다</div>
 		</div>
 		</c:if>
 		<c:if test="${count>0}">
 		<div class="container" style=" width : 90%">
 		<c:forEach var="notice" items="${list}">
 		<div class="link-item" onclick="location.href='noticeDetail.do?notice_num=${notice.notice_num}'">
 			<div class="title">
 			<h5 style="weight:bold;">${notice.notice_title}</h5>
 			</div>
 			<div class="reg_date">
 			<span style="">${notice.notice_reg_date}</span>
 			</div>
 			<hr>
 		</div>
 		</c:forEach>
		</div>
 		<div class="paging" style="color:gray;">
 			<span>${pagingHtml}</span>
 		</div>
 		</c:if>
 		<c:if test="${user_auth==4}">
 		 <div class="write-button pt-5"> 		
 		<a href="${pageContext.request.contextPath}/notice/noticeWrite.do" class="btn btn-outline-dark">공지 작성</a>
 		</div>
 		</c:if>
 	</div>
 </div>
 
