<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>

<script type ="text/javascript">
	$(document).ready(function() {	
		$('input[type=checkbox]:checked').prop("checked", false);
		
		//쿠폰삭제 클릭시
		$('#del_btn').click(function() {		
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index, item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			
			  	var cnt = 0;
			  	cnt = output;
			  	
		      	if(cnt == 0){
		         	 alert("선택하신 쿠폰이 없습니다.");
		         	 return false;
		      	} else {
		    		if(confirm("선택한 쿠폰을 삭제 하시겠습니까?")){
			    
						$.ajax({
							url: 'deleteCoupon.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('쿠폰 삭제가 완료되었습니다.');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류가 발생하였습니다.');
						    }
						});
		    		} else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		    	}
		});
		
	});
</script>

<%-- 관리자 회원일 경우 --%>
<c:if test="${!empty user_num && user_auth == 4}">
	<div class = "container-fluid contents-wrap" style = "width:95%">
		<div class="text-center col-sm-30 my-5">
			<h2 class="admin-page-h2">관리자 - 전체 쿠폰 조회</h2>
				<%-- 쿠폰 없을 경우 --%>
				<c:if test = "${count == 0}">
					<div class = "text-center">
						<p>등록한 쿠폰이 없습니다.</p>
					</div>
				</c:if>
				
				<%-- 쿠폰 존재할 경우 --%>
				<c:if test = "${count > 0}">
					<div class = "text-right">
						<input type = "button" class = "btn btn-outline-dark" value = "뒤로 가기" onclick = "location.href='myPage.do'">
						<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'"> 
						<input type = "button" class = "btn btn-outline-dark" value = "쿠폰 삭제" id = "del_btn">
						<input type = "button" class = "btn btn-outline-dark" value = "쿠폰 등록" id = "reg_btn" onclick="location.href='${pageContext.request.contextPath}/member/couponRegisterView.do'">
					</div>
					<br/>
					
					<table class="table table-sm">
						<tr>
							<th scope="col">쿠폰 번호</th>
							<th scope="col">쿠폰명</th>
							<th scope="col">쿠폰설명</th>
							<th scope="col">할인가격</th>
							<th scope="col">선택</th>
							<th scope="col">수정</th>
						</tr>
						<c:forEach var = "coupon" items = "${list}">
							<tr>
								<td>${coupon.coupondetail_num}</td>
								<td>${coupon.coupon_name}</td>
								<td>${coupon.coupon_content}</td>
								<td><fmt:formatNumber pattern="###,###,###" value="${coupon.discount_price}"/> 원</td>
								<td>
								    <input type = "checkbox" aria-label="Checkbox for following text input" value = "${coupon.coupondetail_num}">
								</td>
								<td>
								    <input type = "button" class = "btn btn-outline-dark" value = "쿠폰 수정" id = "up_btn" onclick="location.href='${pageContext.request.contextPath}/member/couponModifyView.do?coupondetail_num=${coupon.coupondetail_num}'">
								</td>
							</tr>
						</c:forEach>
					</table>
					
					<!-- 페이지 처리 -->
					<div align = "center">
						${pagingHtml}
					</div>
				</c:if>
		</div>
	</div>
	
</c:if>

<%-- 관리자 이외의 접근 시도 시 --%>
<c:if test="${empty user_num || user_auth != 4}">
	<h1>관리자만 접근할 수 있습니다.</h1>
	<script type="text/javascript">
		$(function(){
			alert("관리자만 접근할 수 있습니다.");
			location.href="${pageContext.request.contextPath}/main/main.do";
		});
	</script>
</c:if>
