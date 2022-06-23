<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
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
	padding: 10px 10px 10px 10px;
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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

 <div class="main-container">
 	<div class="name-item" align="center">
 		<h2 style="font-family: 'Gowun Dodum', sans-serif;">장바구니</h2>
 	</div>
 	
 	<div class="cart-container">
 		<%-- 장바구니 갯수 여부 체크 --%>
 		<c:if test="${map.count == 0}">
			<div class="container mt-5">
 				<div class="link-item mb-5 mb-5" style="font-family: 'Gowun Dodum', sans-serif; text-align:center;">장바구니에 아무것도 없습니다.</div>
 			</div>
 		</c:if>
 		
 		<c:if test="${map.count > 0}">
			<form name="form1" id="form1" method="post" action="cartUpdate.do">
			
				<%-- 장바구니 반복문 --%>
				<c:forEach var="row" items="${map.list}" varStatus="i">
				
					<%-- 상품 썸네일 없을 경우 --%>
					<c:if test="${empty row.thumbnail_filename}">
						<!-- 상품 상세보기 링크 -->
						<div class="link-item" style="display:float;"> 
							<a href="storeDetail.do?prod_num=${row.prod_num}">
								<img src = "${pageContext.request.contextPath}/resources/images/gift.png" style = "width:240px; height:240px; max-width:240px; max-height:240px;">
							</a>
							
						<br/>
						<!-- 상품 정보 -->
			 			<div class="title">
			 				<p style="font-family: 'Gowun Dodum', sans-serif;">${row.prod_name}</p>
			 			</div>
			            <input type="number" style="width: 40px" name="cart_quan" value="${row.cart_quan}" min="1" max="10">
			            <input type="hidden" name="prod_num" value="${row.prod_num}">
			 			<div class="reg_date">
			 				<p style="font-family: 'Gowun Dodum', sans-serif;"><fmt:formatNumber pattern="###,###,###" value="${row.prod_price}"/></p>
			 				<a href="${pageContext.request.contextPath}/cart/cartDelete.do?cart_num=${row.cart_num}" class="btn btn-outline-danger">삭제</a>
			 			</div>
			 			</div>
		 			</c:if>
		 			
		 			<%-- 상품 썸네일 있을 경우 --%>
		 			<c:if test="${!empty row.thumbnail_filename}">
						<!-- 상품 상세보기 링크 -->
						<div class="if_thumbnail"> 
							<div class="container" style="display: flex;"> 
								<!-- 이미지 경로 설정 -->
								<div class="imgBox" style="display:flex;">
									<a href="${pageContext.request.contextPath}/store/storeDetail.do?prod_num=${row.prod_num}">
									<img src = "imageView.do?prod_num=${row.prod_num}" style = "width:240px; height:240px; max-width:240px; max-height:240px; display: float;"></a>
									<br/>
								</div>
					 			<div class="title" style="display:flex;">
					 				<p style="font-family: 'Gowun Dodum', sans-serif;">${row.prod_name}</p>
					 			</div>
				 			</div>
				            <input type="hidden" name="prod_num" value="${row.prod_num}">
				 			<div class="reg_date">
				 			<span style="font-family: 'Gowun Dodum', sans-serif;">
				 			 가격:<fmt:formatNumber pattern="###,###,###" value="${row.prod_price}"/>원<br>
				             장바구니 수량:<input type="number" style="width: 50px; height: 34px;" name="cart_quan" value="${row.cart_quan}" min="1" max="10">
				 			 </span><a href="${pageContext.request.contextPath}/cart/cartDelete.do?cart_num=${row.cart_num}" class="btn btn-outline-danger">삭제</a></div>
			 			</div>
		 			</c:if>
				</c:forEach>
				
				<hr>
				
				<p>장바구니 금액 합계 : <fmt:formatNumber pattern="###,###,###" value="${map.sumMoney}"/></p>
				<br/>
		        <p>배송료 : ${map.fee}</p>
		        <br/>
		        <p>*10만원 이상부터는 배송료가 0원이 됩니다.</p>
		        <br/>
		        <p>전체 주문금액  :<fmt:formatNumber pattern="###,###,###" value="${map.allSum}"/></p>
	        
				<input type="submit" class="btn btn-success" value="수정" formaction="${pageContext.request.contextPath}/cart/cartUpdate.do">
				<input type="submit" class="btn btn-success" value="주문하기" formaction="${pageContext.request.contextPath}/cart/cartOrderForm.do">
			</form>
 		</c:if>
 	</div>
 </div>
