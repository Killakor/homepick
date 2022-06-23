<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		alert("상세정보를 반드시 입력해주시기 바랍니다.");
		
		$('#register_form').submit(function(){
			if($('#mem_name').val().trim()==''){
				$('#mem_name').val('').focus();
				alert("이름을 입력해주시기 바랍니다.");
				return false;
			}
			if($('#phone').val().trim()==''){
				$('#phone').val('').focus();
				alert("전화번호를 입력해주시기 바랍니다.");
				return false;
			}
			
			if($('#email').val().trim()==''){
				$('#email').val('').focus();
				alert("이메일을 입력해주시기 바랍니다.");
				return false;
			}
			if($('#zipcope').val().trim()==''){
				$('#zipcope').val('').focus();
				alert("우편번호를 입력해주시기 바랍니다.");
				return false;
			}
			if($('#address1').val().trim()==''){
				$('#address1').val('').focus();
				alert("주소를 입력해주시기 바랍니다.");
				return false;
			}
			if($('#address2').val().trim()==''){
				$('#address2').val('').focus();
				alert("상세주소를 입력해주시기 바랍니다.");
				return false;
			}
		});
	});
	
	
	//다음 주소
    function sample6_execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; 		//주소 변수
               var extraAddr = '';  //참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { //사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { //사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R'){
                   //법정동명이 있을 경우 추가한다. (법정리는 제외)
                   //법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraAddr += data.bname;
                   }
                   //건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   //표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraAddr !== ''){
                       extraAddr = ' (' + extraAddr + ')';
                   }
                   //조합된 참고항목을 해당 필드에 넣는다.
                   document.getElementById("address1").value = extraAddr;
               
               } else {
                   document.getElementById("address1").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('zipcode').value = data.zonecode;
               document.getElementById("address1").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("address2").focus();
           }
       }).open();
   }
</script>

<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	
	<h3>회원 가입</h3>

	<div class="text-center col-sm-12 my-5">
		<form:form id="register_form" action="kakaoLoginProcess.do" modelAttribute="memberDTO">
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="mem_name">이름</label>
				<form:input path="mem_name"/>
			</div>	
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="phone">전화번호</label>
				<form:input path="phone"/>
			</div>
			<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="email">이메일</label>
				<form:input path="email"/>
			</div>
			<div class = "form-group row">	
				<label class = "col-sm-3 col-form-label" for="zipcope">우편번호</label>
				<input id="zipcode" name="zipcode" placeholder="우편번호" type="text" value="" maxlength="5" readonly="readonly"/>&nbsp;&nbsp;&nbsp;
				<input class = "btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
			</div>
		
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address1">주소</label>
				<input id="address1" name="address1" type="text" value="" maxlength="30" readonly="readonly" placeholder="주소"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address2">나머지주소</label>
				<form:input path="address2" maxlength="30" placeholder="상세주소"/>
			</div>
			<div class = "form-group row">
				<div class = "text-center col-sm-12">
					<form:button class = "btn btn-outline-dark">가입</form:button>
					<input class = "btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
			</div>
		</form:form>
	</div>
</div>
