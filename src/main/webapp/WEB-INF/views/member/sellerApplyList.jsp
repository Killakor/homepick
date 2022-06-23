<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<script type ="text/javascript">
	$(document).ready(function() {
		// 검색 유효성 체크
		$("#search_form").submit(function(){
			if($("#keyword").val().trim() == ""){
				alert("검색어를 입력하세요!!");
				$("#keyword").val("").focus();
				return false;	// 서밋은 false 클릭은 ;
			}
		});
		
		$('input[type=checkbox]:checked').prop("checked", false);
		
		$('#registSeller_btn').click(function() {		// 판매자등록 클릭시
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			
			  	var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 회원이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("선택한 회원을 판매자로 등록 하시겠습니까?")){
			    
						$.ajax({
							url: 'memberRegistSeller.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('등록 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		    	}
		});	// 판매자등록 끝
		
		$('#deleteSeller_btn').click(function() {		// 판매자등록취소 클릭시
		   	var output = '';
		   
			$('input[type=checkbox]:checked').each(function(index,item){
			    if(index !=0 ){
			    	output += ',';
			    }
					output += $(this).val();
			  	});
			
			  	var cnt = 0;
			  	cnt = output;
		      	if(cnt == 0){
		         	 alert("선택한 회원이 없습니다!");
		         	 return false;
		      	}else{
		    		if(confirm("선택한 회원의 판매자 등록을 취소 하시겠습니까?")){
			    
						$.ajax({
							url: 'memberCancelSeller.do',
						   	type: 'post',
						   	data: {output : output},
						   	dataType : 'json',
							cache : false,
							timeout : 30000,
						    success: function(param) {
						    	alert('취소 완료!');
						    	location.reload();
						    	$('input[type=checkbox]:checked').prop("checked", false);
						    },
						    error : function() {
						    	alert('네트워크 오류!');
						    }
						});
		    		}else {
		    			$('input[type=checkbox]:checked').prop("checked", false);
		    		}
		    	}
		});	// 판매자등록취소 끝
		
		
		
	});
	
</script>
<c:if test="${!empty user_num && user_auth == 4}">
<div class = "container-fluid contents-wrap" style = "width:95%">
	<div class="text-center col-sm-30 my-5">
		<div align = "left">
			<h2 class="admin-page-h2">관리자 - 판매자 신청 내역</h2>
		</div>
	<c:if test = "${count == 0}">
	<div class = "text-center">
		판매 신청한 회원이 없습니다.
	</div>
	</c:if>
	<c:if test = "${count > 0}">
		<div class = "text-right">
			<input type = "button" class = "btn btn-outline-dark" value = "뒤로 가기" onclick = "location.href='myPage.do'">
			<input type = "button" class = "btn btn-outline-dark" value = "홈으로" onclick = "location.href='${pageContext.request.contextPath}/main/main.do'"> 
			<input type = "button" class = "btn btn-outline-dark" value = "판매자 등록" id = "registSeller_btn">
			<input type = "button" class = "btn btn-outline-dark" value = "판매자 등록취소" id = "deleteSeller_btn">
		</div>
		<br>
	<table class="table table-sm">
			<tr>
				<th scope="col">회원 번호</th>
				<th scope="col">아이디</th>
				<th scope="col">사업자 번호</th>
				<th scope="col">대표자명</th>
				<th scope="col">회사명</th>
				<th scope="col">개업일자</th>
				<th scope="col">종목명</th>
				<th scope="col">회사우편번호</th>
				<th scope="col">회사주소</th>
				<th scope="col">회원등급</th>
				<th scope="col">선택</th>
			</tr>
			<c:forEach var = "memberBuis" items = "${list}">
			<tr>
				<th scope = "row">${memberBuis.mem_num}</th>
				<td>${memberBuis.mem_id}</td>
				<td>${memberBuis.buis_num}</td>
				<td>${memberBuis.ceo_name}</td>
				<td>${memberBuis.buis_name}</td>
				<td>${memberBuis.opening_date}</td>
				<td>${memberBuis.buis_item}</td>
				<td>${memberBuis.buis_zipcode}</td>
				<td>${memberBuis.buis_address1} <br> ${memberBuis.buis_address2}</td>
				<td>
					<c:if test="${memberBuis.mem_auth == 0}">탈퇴회원</c:if>
				    <c:if test="${memberBuis.mem_auth == 1}">정지회원</c:if>
				    <c:if test="${memberBuis.mem_auth == 2}">일반회원</c:if>
				    <c:if test="${memberBuis.mem_auth == 3}">판매회원</c:if>
				    <c:if test="${memberBuis.mem_auth == 4}">관리자</c:if>
				</td>
				<td>
				    <c:if test="${member.mem_auth != 4 && member.mem_auth != 0}">
				    	<input type = "checkbox" aria-label="Checkbox for following text input" value = "${memberBuis.mem_num}">
				    </c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div align = "center">
			${pagingHtml}
		</div>
	</c:if>
	</div>
	<div align="center" style="background-color: #f5f5ff; width :100%; height: 100%;">
	<br>  
	<form action="sellerApplyList.do" method="get" id="search_form">
	<div class=" col-lg-5">
		<input style="float: right;  position: relative; right: 84px;  bottom : 1px; height: 36px;" type="submit" class = "btn btn-outline-dark" value="검색">
		<div class=" col-lg-6">
		<input class="form-control input-lg" type="search" name="keyword" id = "keyword" style="height: 30px;" placeholder="검색어를 입력하세요."><br>
		<div class=" col-sm-7">
				<select style="position: relative; right: 185px; bottom : 55px; height: 36px;" class="form-control input-sm" name="keyfield">
					<option value="1">회사명</option>
					<option value="2">대표자명</option>
				</select>
		</div>
		</div>
	</div>
	<input style="float: right; position: relative; right: 17px; bottom : 55px;" type="button" class = "btn btn-outline-dark" value="목록" onclick="location.href='${pageContext.request.contextPath}/member/sellerApplyList.do'">
	</form>
	</div>
</div>
	
</c:if>



<%-- 비정상적인 접근 --%>
<c:if test="${empty user_num || user_auth != 4}">
	<h1>관리자만 접근할 수 있습니다.</h1>
	<script type="text/javascript">
	$(function(){
		alert("관리자만 접근할 수 있습니다.");
		location.href="${pageContext.request.contextPath}/main/main.do";
	});
	</script>
</c:if>