<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.submit{
    cursor: pointer;
    touch-action: manipulation;
    box-sizing: border-box;
    display: inline-block;
    border-width: 1px;
    border-style: solid;
    text-align: center;
    border-radius: 4px;
    font-weight: bold;
    line-height: 1;
    height: 60px;
    padding: 21px 0;
    font-size: 18px;
    transition: .2s ease;
    background-color: #F5A100;
    border-color: #F5A100;
    color: #ffffff;
    user-select: none;
    width: 250px;
}

</style>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class = "container-fluid contents-wrap" style = "width:70%;">
	<div class="text-center col-sm-30 my-5">
		<div align = "left">
			<h2>이메일 문의</h2>
		</div>
		<hr noshade="noshade" size="2"><br>
		<div align="center" class = "container-fluid" style = "width:900px; border: 1px solid #b8b8b8; font-family: 'Gowun Dodum', sans-serif; ">
			<div class="text-center col-sm-12 my-5">
				<form:form action="serviceBoardInsert.do" modelAttribute="serviceBoardDTO" enctype="multipart/form-data">
					<div style="width:343px;" class="form-group row" >
						<label class="keyword" for="service_keyword" ></label>
						<select  class="" name="service_keyword" id="service_keyword">
							<option value="">문의 유형</option>
							<option value="회원 정보 문의">회원 정보 문의</option>
							<option value="쿠폰/포인트 문의">쿠폰/포인트 문의</option>
							<option value="주문/결제 관련 문의">주문/결제 관련 문의</option>
							<option value="취소/환불 관련 문의">취소/환불 관련 문의</option>
							<option value="배송 관련 문의">배송 관련 문의</option>
							<option value="주문 전 상품 정보 문의">주문 전 상품 정보 문의</option>
							<option value="서비스 개선 제안">서비스 개선 제안</option>
							<option value="시스템 오류 제보">시스템 오류 제보</option>
							<option value="불편 신고">불편 신고</option>
							<option value="기타 문의">기타 문의</option>
						</select>
						<form:errors path="service_keyword" cssClass="error-color"/>
					</div>
					<div class = "form-group row" style="width:343px;">
							<label class = "col-sm-3 col-form-label" for="service_nickname"></label>
							<c:if test="${empty user_num }">
								<input type="text" class="form-control" name="service_nickname" id="service_nickname" maxlength="10" placeholder="닉네임을 입력하세요"> 
							</c:if>
							<c:if test="${!empty user_num }">
								<input type="text" class="form-control" name="service_nickname" id="service_nickname" maxlength="12" value="${user_nickname }" readonly>
							</c:if>
							<form:errors path="service_nickname" cssClass="error-color"/>
					</div>
					<div class = "form-group row" style="width:343px;">		
							<label class = "col-sm-3 col-form-label" for="service_email"></label>
							<input type="text" class="form-control" name="service_email" id="service_email" maxlength="30" placeholder="이메일을 입력하세요"> 
							<form:errors path="service_email" cssClass="error-color"/>
					</div>
					<div class = "form-group row" style="width:750px;">
						<label class = "col-sm-3 col-form-label" for="service_title"></label>
						<input type="text" class="form-control" name="service_title" id="service_title" maxlength="30" placeholder="제목을 입력하세요"> 
						<form:errors path="service_title" cssClass="error-color"/>
					</div>
					<div class = "form-group row" style="width:750px; height:160px;">
							<label class = "col-sm-3 col-form-label" for="service_content"></label>
							<textarea rows="1" style="height:160px;" class="form-control" name="service_content" id="service_content" maxlength="500" placeholder="문의 내용"></textarea>
							<form:errors path="service_content" cssClass="error-color"/>
					</div><br>
					<div class = "form-group row" style="width:250px;">
						<label class = "col-sm-3 col-form-label" for="upload"></label>
						<input class = "btn btn-outline-dark"  type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
					</div>
			
					<!-- 버튼 -->
					<div class = "form-group row">
						<form:button class = "submit">제출하기</form:button>
					</div>
					</form:form>
			</div>
		</div>
	</div>
</div>
