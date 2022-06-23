<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<style>
.name-item{
	align-items: center;
}
.cart-container{
	width: 1136px;
	margin : 0 auto;
}
.link-item{
	margin: 0 auto;
	width : 100%;
}
.container{
	margin : 0 auto;
	width: 1138px;
}
.title{
	font-size:18px;
	weight:800;
	text-align:left;

}
.reg_date{
	font-size:15px;
	padding-right: 30px;
	text-align:right;
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
 	<div class="name-item">
 	<h2 style="font-family: 'Gowun Dodum', sans-serif;">리뷰목록</h2>
 	</div>
 	<div class="cart-container">
 	<c:if test="${count==0}">
 		<h5 class="link-item" style="font-family: 'Gowun Dodum', sans-serif; text-align:center;">구매한 내역이 없습니다.</h5>
 	</c:if>
 	<c:if test="${count>0}">
 		<c:forEach var="list" items="${list}" varStatus="n">
 		<form:form id="${n.index}" action="reviewCheck.do" modelAttribute="reviewDTO" method="post">
 		<div class="link-item" onclick="#">
 		<div class="title" style="font-size:15px;">판매샵 : ${list.buis_name}</div>
 		<div class="title"><h5>제품명 : ${list.prod_name}</h5></div>
 		<input type="hidden" name="prod_num"value="${list.prod_num}"/>
 		<div class="reg_date"><h6><fmt:formatNumber pattern="###,###,###" value="${list.prod_price}"/> 원</h6></div>
 		<div class="iftag" style="text-align:right; padding-right:20px;">
		<input type="submit" value="리뷰작성" class="btn btn-light">
 		</div>
 		</div>
 		</form:form>
 		</c:forEach>
 	</c:if>
	</div>

</div>
</div>
