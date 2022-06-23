<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type = "text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
	#con_non_main {
		width : 1000px;
		height : 250px;
		border : 1px solid grey;
		margin-top : 30px;
	}
	#con_text {
		margin-top : 30px;
		font-family: 'Gowun Dodum', sans-serif;
		text-decoration: none;
	}
	#con_button {
		margin-top : 50px;
	}
</style>
<div class = "align-center">
	<c:if test = "${orderDTO.receiver_phone == null}">
		<div id = "con_non_main" class = "container">
			<h2 id = "con_text">주문하신 내용이 없습니다!</h2>
			<div id = "con_button">
				<input type = "button" class = "btn btn-outline-dark" id = "main_btn" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'">
				<input type = "button" class = "btn btn-outline-dark" id = "cate_btn" value = "뒤로가기" onclick = "location.href='${pageContext.request.contextPath}/order/nonCheck.do'">
			</div>
		</div>
	</c:if>
	<c:if test = "${orderDTO.receiver_phone != null}">
		<div class = "container">
			<table class = "table table-striped table-sm">
				<tr>
					<th scope="col">주문 번호</th>
					<th scope="col">주문 날짜</th>
					<th scope="col">상품명</th>
					<th scope="col">주소</th>
					<th scope="col">수량</th>
					<th scope="col">가격</th>
					<th scope="col">수령자 이름</th>
					<th scope="col">수령자 전화번호</th>
				</tr>
				<c:forEach var = "orderDTO" items = "${list}">
				<tr>
					<th scope = "row">${orderDTO.order_num}</th>
					<td>${orderDTO.order_date}</td>
					<td><a href = "${pageContext.request.contextPath}/store/storeDetail.do?prod_num=${orderDTO.prod_num}">${orderDTO.prod_name}</a></td>
					<td>${orderDTO.order_address1}<br>${orderDTO.order_address2}</td>
					<td>${orderDTO.pay_quan}</td>
					<td>${orderDTO.pay_price}</td>
					<td>${orderDTO.receiver_name}</td>
					<td>${orderDTO.receiver_phone}</td>
				</tr>
				</c:forEach>
			</table>
			<div align = "center">
				${pagingHtml}
			</div>
		</div>
	</c:if>
</div>