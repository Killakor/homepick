<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		$('#couponRegister_form').submit(function(){
			
			var check = confirm("쿠폰등록을 하시겠습니까?");
			
			if(check){
				if($('#coupon_name').val().trim()==''){
					$('#coupon_name').val('').focus();
					alert("쿠폰명을 입력해주세요!");
					return false;
				}
				if($('#discount_price').val().trim()==''){
					$('#discount_price').val('').focus();
					alert("할인가격을 입력해주세요!");
					return false;
				}
				
				if($('#coupon_content').val().trim()==''){
					$('#coupon_content').val('').focus();
					alert("쿠폰 내용을 입력해주세요!");
					return false;
				}
			}else{
				return false;
			}
		});
	});
</script>
<!-- 중앙 내용 시작 -->

<div class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: 'Gowun Dodum', sans-serif; ">
	<div align = "left">
			<h3>쿠폰 등록</h3>
	</div>
	<div class="text-center col-sm-12 my-5">
		
	<form:form id="couponRegister_form" action="couponRegisterView.do" modelAttribute="memberDTO">
		<div class = "form-group row">
			<label class = "col-sm-2 col-form-label" for="coupon_name">쿠폰명&nbsp;</label>
			<form:input path="coupon_name" placeholder="쿠폰명을 입력해주세요"/>&nbsp;&nbsp;&nbsp;
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="discount_price">할인 가격&nbsp;</label>
				<form:input path="discount_price" placeholder="할인 가격을 입력해주세요"/> 원
				<form:errors path="discount_price" cssClass="error-color"/>
		</div>
		<div class = "form-group row">	
				<label class = "col-sm-2 col-form-label" for="coupon_content">쿠폰 내용&nbsp;</label>
				<form:textarea path="coupon_content"/>
				<form:errors path="coupon_content" cssClass="error-color"/>
		</div>	
			<br>
			<div class = "form-group row">
				<div class = "text-center col-sm-10">
					<form:button class = "btn btn-outline-dark">등록</form:button>
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</div>
		
		
	</form:form>
	
	</div>
</div>
<!-- 중앙 내용 끝 -->