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
.link-item{
	border-bottom : 1px solid #dbdbdb;
	width : 900px;
	margin : 0 auto;
}
.title{
	font-size:18px;
	weight:800;
	padding: 0px 10px 10px 10px;
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
textarea{
width : 750px;
height : 300px;
resize:none;
margin : 20px 0px 0px 0px;
}
</style>
<div class="container-fluid">
 <div class="main-container">
 	<div class="name-item">
 	<h2 style="font-family: 'Gowun Dodum', sans-serif;">리뷰작성</h2>
 	</div>
 	<div class="cart-container">
 		
 		<h4 style="font-family: 'Gowun Dodum', sans-serif; text-align : center;">제품정보</h4>
 		<div class="link-item" style="font-family: 'Gowun Dodum', sans-serif;"></div>
 		<div class="link-item" onclick="#">
 			<div style="text-align:center; font-size:14px;'">${reviewDTO.buis_name}</div><br>
 			<div class="title" style="text-align:center;">${reviewDTO.prod_name}</div>
 			<div class="reg_date">${reviewDTO.prod_price}원</div>
 		</div>
	</div>
</div>
</div>
<div class="container">
	<div class="main-container">
		<!-- 상품을 사용하고 느끼신 소감을 적어주세요! -->
		<div class="message mt-5 pt-5">
		<h5 style="text-align: center;">상품을 사용하시고 느끼신 소감을 적어주세요!</h5>
		</div>
		<form:form id="user_review" action="reviewWrite.do" modelAttribute="reviewDTO" enctype="multipart/form-data">
		<input type = "hidden" name="mem_num" value = "${mem_num}">
		<input type = "hidden" name="prod_num" value = "${prod_num}">
		<ul>
		<li class="li-title">
			<div class="star mt-5"  style="text-align:center; margin-right:600px;">
			<form:label path="rev_grade">평점:</form:label>
			<form:select path="rev_grade">
				<form:options items="${ratingOptions}"/>
			</form:select>
			</div>
		</li>
		
		<!-- 별점부분 -->
		<li class="li-content"  style="text-align:center;">
			<form:textarea path="rev_content"/>
			<form:errors path="rev_content" cssClass="error-color"/>
		</li>
		<!-- 폼 text_area -->
		<!-- 이미지 첨부 파일 넣게 되어있게 -->	
		<li class="li-content mt-4"  style="text-align:center;">
				<label for="upload">이미지 파일</label>
				<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
			</li>
		</ul>
		<div class="submit-button mt-5" style="text-align:right; margin-right:200px;">
			<input type="submit" value="등록" class="btn btn-info">
			<input type="button" value="목록으로"  class="btn btn-success" onclick="location.href='${pageContext.request.contextPath}/review/reviewList.do'">
		</div>
		</form:form>
	</div>
</div>