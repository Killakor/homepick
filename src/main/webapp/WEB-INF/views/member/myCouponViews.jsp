<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<div class = "container-fluid contents-wrap" style = "width:95%">
	<div class="text-center col-sm-30 my-5">
		<div align = "left">
			<h2 class="admin-page-h2">내 쿠폰 조회</h2>
		</div>
	<c:if test = "${count == 0}">
	<div class = "text-center">
		보유중인 쿠폰이 없습니다.
	</div>
	</c:if>
	<c:if test = "${count > 0}">
		<div class = "text-right">
			<input type = "button" class = "btn btn-outline-dark" value = "마이페이지" onclick = "location.href='myPage.do'">
			<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<br>
	<table class="table table-sm">
			<tr>
				<th scope="col">쿠폰 번호</th>
				<th scope="col">쿠폰명</th>
				<th scope="col">쿠폰설명</th>
				<th scope="col">할인가격</th>
			</tr>
			<c:forEach var = "coupon" items = "${list}">
			<tr>
				<td>${coupon.coupondetail_num}</td>
				<td>${coupon.coupon_name}</td>
				<td>${coupon.coupon_content}</td>
				<td><fmt:formatNumber pattern="###,###,###" value="${coupon.discount_price}"/> 원</td>
			</tr>
			</c:forEach>
		</table>
		<div align = "center">
			${pagingHtml}
		</div>
	</c:if>
	</div>
</div>