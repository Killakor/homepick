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
width:1136px;
margin : 0 auto;
}
.link-item{
margin: 0 auto;
width : 100%;
}
.container{
margin : 0 auto;
width:1138px;
}
.title{
	font-size:18px;
	weight:800;
	padding: 0x 10px 0px 10px;
	text-align:left;

}
.reg_date{
	font-size:15px;
	padding: 0px 10px 20px 10px;
	text-align:right;
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
<!-- 제품정보도 받아올 수 있도록 sql수정하기 -->
<div class="container-fluid">
 <div class="main-container">
 	<div class="name-item pb-4">
 	<h2 style="font-family: 'Gowun Dodum', sans-serif;">내가 쓴 리뷰 목록</h2>
 	</div>
 	<div class="cart-container">
 	<c:if test="${count==0}">
 		<h5 class="link-item" style="font-family: 'Gowun Dodum', sans-serif; text-align:center;">작성한 리뷰가 없습니다.</h5>
 	</c:if>
 	<div class="container">
 	 	<c:if test="${count>0}">
 		<c:forEach var="list" items="${list}" varStatus="n">
 	<!-- 상품정보도 받아올 수 있도록 sql수정하기 -->
	<!-- 이미지 없을때 -->
 			<c:if test="${empty list.thumbnail_filename}">
 				<div class="container" style="display:float;"> 
					<div class="title"><p style="font-family: 'Gowun Dodum', sans-serif;">${list.prod_name}</p><br></div>
					<p style="font-family: 'Gowun Dodum', sans-serif;"><fmt:formatNumber pattern="###,###,###" value="${list.prod_price}"/></p>
					<hr>
 				</div>
 				<input type = "hidden" name="mem_num" value = "${list.mem_num}">
				<input type = "hidden" name="prod_num" value = "${list.prod_num}">
 				<div class="content" style="font-size:12px;"> ${list.buis_name}</div>
 				<div class="title"> ${list.prod_name}</div><br>
				<div class="rating">별점 : <c:forEach var="var" items="${ratingOptions}" varStatus="status" begin="1" end="${list.rev_grade}">★</c:forEach></div>
 			<div class="content">${list.rev_content}</div>
 		<input type="hidden" name="prod_num"value="${list.prod_num}"/>
 		<c:if test="${!empty list.rev_filename}">
 		<div class="file-item mt-4 mb-4" style="text-align:center">
		<img src="imageView.do?rev_num=${list.rev_num}" style="max-width:500px">
		</div>
 		</c:if>
		 <div class="reg_date">
 		<a href="${pageContext.request.contextPath}/review/reviewDetail.do?rev_num=${list.rev_num}" onclick="return confirm('리뷰를 수정하시겠습니까?');" class="btn btn-outline-info">수정</a>
 		<a href="${pageContext.request.contextPath}/review/reviewDelete.do?rev_num=${list.rev_num}" onclick="return confirm('정말 삭제하시겠습니까?');" class="btn btn-outline-danger">삭제</a>
		</div>
 		</c:if>
 		<!-- 이미지 있을때 -->
		<c:if test="${!empty list.thumbnail_filename}">
		 <div class="container" style="display:flex; width:80%;"> 
		<div class="imgItem" style="flex-shrink: 0; width : 200px;">
		<a href="${pageContext.request.contextPath}/store/storeDetail.do?prod_num=${list.prod_num}"><img src="${pageContext.request.contextPath}/review/prodView.do?rev_num=${list.rev_num}" style = "width:150px; height:150x; max-width:150px; max-height:150px; display: float;"></a><br>
		</div>
 		<div class="prodItem" style="flex-grow:1;">
 		<h5 style="font-family: 'Gowun Dodum', sans-serif;">${list.prod_name}</h5><br>
 		 <p style="font-family: 'Gowun Dodum', sans-serif;"><fmt:formatNumber pattern="###,###,###" value="${list.prod_price}"/>원</p>
 		</div>
 		</div>
 		<hr style="width:70%; ">
		 <input type = "hidden" name="mem_num" value = "${list.mem_num}">
		<input type = "hidden" name="prod_num" value = "${list.prod_num}">
 		<div class="content" style="font-size:12px;"> ${list.buis_name}</div>
		<div class="rating" style="text-align:center">별점 : <c:forEach var="var" items="${ratingOptions}" varStatus="status" begin="1" end="${list.rev_grade}">★</c:forEach></div>
 		<div class="content" style="text-align:center">${list.rev_content}</div>
 		<input type="hidden" name="prod_num"value="${list.prod_num}"/>
 			<c:if test="${!empty list.rev_filename}">
 				<div class="file-item mt-4 mb-4" style="text-align:center">
				<img src="imageView.do?rev_num=${list.rev_num}" style="max-width:500px">
				</div>
 			</c:if>
 		<div class="reg_date">
		<p>작성일 : ${list.rev_reg_date}</p>
 		<a href="${pageContext.request.contextPath}/review/reviewDetail.do?rev_num=${list.rev_num}" onclick="return confirm('리뷰를 수정하시겠습니까?');" class="btn btn-outline-info">수정</a>
 		<a href="${pageContext.request.contextPath}/review/reviewDelete.do?rev_num=${list.rev_num}" onclick="return confirm('정말 삭제하시겠습니까?');" class="btn btn-outline-danger">삭제</a>
		</div>
		<hr>
		</c:if>
 		</c:forEach>
 	</c:if>
	</div>

</div>
</div>
</div>
