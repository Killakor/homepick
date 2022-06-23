<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	//이메일 인증	
	$(function() {
		//인증 시, 인증확인 버튼 숨김처리
		$("#email_check_button").hide();
		
		//이메일 인증번호 변수
		var emailCheckCode = "";
		//이메일 인증 성공 여부
		var emailCertification = false;	
		
		//인증번호전송 클릭시
		$("#email_send_button").click(function(){	
			
			if($("#email").val().trim() == ""){
				alert("이메일을 입력해주시기 바랍니다.");
				return false;
			}
			
			//입력 이메일
			var email = $("#email").val();
			//인증번호 입력란
			var email_Check = $("#email_check");
			//인증번호전송 버튼
			var email_CheckBox = $("#email_check_button");
				
			//인증번호 전송 클릭시 입력 이메일 전송 ajax 작성
			$.ajax({
				type : "GET",
				url:"mailCheck.do?email=" + email,
				success:function(data){
					console.log("data : " + data);			//확인용 (추후 삭제 진행)
					email_Check.attr("disabled", false);	//인증번호 입력란 활성화
					$("#email_check_button").show();		//인증확인 버튼 활성화
					emailCheckCode = data;					//변수에 인증번호 담기
				},
				error : function(){
					alert("네트워크 오류가 발생하였습니다.");
				}
			});
				
		});
			
		//인증확인 클릭시, 인증번호 비교
		$("#email_check_button").click(function(){
			//사용자 입력코드    
			var user_inputCode = $("#email_check").val();
			    
			//인증번호가 일치한 경우
		    if(user_inputCode == emailCheckCode){	
		    	alert("인증번호에 성공하였습니다.");
		    	$("#email_check_button").hide();			//인증확인 숨기기
		    	emailCertification = true;					//인증여부 성공으로 변경
		    	$("#email_check").attr("readonly", true);	// 인증번호 입력칸 비활성화
		    } else {	// 인증번호 불일치
		    	alert("인증번호가 불일치합니다.");
		    }		
		});
		
		
		//탈퇴 시
		$("#mem_delete_btn").click(function(){
			var input_passwd = prompt("가입하신 비밀번호를 입력해주세요.");
			
			$.ajax({
				url:"memberDelete.do",
				type:"post",
				data : {input_pass:input_passwd},
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'success'){
						alert("회원 탈퇴가 정상적으로 성공하였습니다.\n복구를 원하시면 홈픽 고객센터에 문의해주시기 바랍니다.");
						location.href="${pageContext.request.contextPath}/main/main.do";
					} else if(param.result == 'NotEqualsPasswd'){
						alert("비밀번호가 불일치합니다.");
					} else if(param.result == 'logout'){
						alert("로그인을 해주세요!!");
						location.href="${pageContext.request.contextPath}/member/login.do";
					} else {
						alert("서버 처리 중 오류가 발생하였습니다.")
					}
				},
				error : function(request,status,error){
		               alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
		        }
			});
		});
	});
	
	
	//디음주소
    function sample6_execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               //팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               //내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; //주소 변수
               var extraAddr = ''; //참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { //사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { //사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               //사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
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

               //우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('zipcode').value = data.zonecode;
               document.getElementById("address1").value = addr;
               //커서를 상세주소 필드로 이동한다.
               document.getElementById("address2").focus();
           }
       }).open();
   	}
	
	
  	//MyPage 프로필 사진 수정
	$(function(){
		$('#photo_btn').click(function(){
			$('#photo_choice').show();
			$(this).hide();
		});
		
		//파일 미리 보기
		var photo_path;
		var my_photo;
		$('#upload').change(function(){	// 업로드 파일이 바뀌면
			var upload = document.getElementById('upload');
			my_photo = upload.files[0];
			if(my_photo){
				var reader = new FileReader();
				
				reader.readAsDataURL(my_photo);
				
				reader.onload = function(){
					photo_path = $('.my-photo').attr('src');
					$('.my-photo').attr('src',reader.result);
				};
			}
		});
		
		//ajax를 이용한 파일 전송
		$('#photo_submit').click(function(){
			if($('#upload').val()==''){
				alert('이미지 파일을 선택해주세요.');
				$('#upload').focus();
				return;
			}
			
			//파일 전송
			var form_data = new FormData();
			form_data.append('upload',my_photo);
			$.ajax({
				data:form_data,
				type:'post',
				url:'updateMyPhoto.do',
				dataType:'json',
				cache:false,
				contentType:false,
				enctype:'multipart/form-data',
				processData:false,
				success:function(param){
					if(param.result == 'logout'){
						alert('세션이 만료되었습니다. 로그인 후 사용하세요.');
					}else if(param.result == 'success'){
						alert('프로필 사진이 변경 되었습니다.');
						$('#upload').val('');
						$('#photo_choice').hide();
						$('#photo_btn').show();
					}else{
						alert('파일 전송에 오류가 발생하였습니다.');
					}
				},
				error:function(){
					alert('네트워크 오류가 발생하였습니다.');
				}
			});
			
		});
		
		//프로필 사진 전송 취소
		$('#photo_reset').click(function() {
			$('.my-photo').attr('src',photo_path);
			$('#upload').val('');
			$('#photo_choice').hide();
			$('#photo_btn').show();
		});
	});
	
</script>

<input type="button"  value="비밀번호변경" style="float: right; cursor: pointer;" class = "btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/member/memberPasswdUpdate.do'">
<input type="button"  value="회원탈퇴" style="float: right; cursor: pointer;" class = "btn btn-outline-dark" id="mem_delete_btn">
<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	
	<h3>회원 정보수정</h3>
	
	<div class="text-center col-sm-12 my-5">
		<form:form id="modify_form" action="memberUpdate.do" modelAttribute="memberDTO" enctype="multipart/form-data">
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="mem_name">이름</label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color" style="display:block; float:left;"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="email">이메일</label>
				<form:input path="email"/>
				<form:errors path="email" cssClass="error-color"/>
			</div>
			
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="nickname">별명</label>
				<form:input path="nickname"/>
				<form:errors path="nickname" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="phone">전화번호</label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="zipcope">우편번호</label>
				<form:input path="zipcode" id="zipcode" name="zipcode" placeholder="우편번호" type="text" value="" maxlength="5" readonly="true"/>&nbsp;&nbsp;&nbsp;
				<input type="button" class = "btn btn-outline-dark" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				<form:errors path="zipcode" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address1">주소</label>
				<form:input path="address1" id="address1" name="address1" type="text" value="" maxlength="30" readonly="true" placeholder="주소"/>
				<form:errors path="address1" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="address2">나머지주소</label>
				<form:input path="address2" maxlength="30" placeholder="상세주소"/>
				<form:errors path="address2" cssClass="error-color"/>
			</div>
			
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="profile">프로필 사진</label>
				<%-- 이미지 출력 --%>
				<c:if test="${empty memberDTO.profile_filename}">
					<img src="${pageContext.request.contextPath}/resources/images/basic.png" width="150" height="150" class="my-photo">
				</c:if>
				<c:if test="${!empty memberDTO.profile_filename}">
					<img src="${pageContext.request.contextPath}/member/photoView.do" width="150" height="150" class="my-photo">
				</c:if>
				<div class="align-center" style="padding-left: 10em;">
					<input type="button" class = "btn btn-outline-dark" value="수정" id="photo_btn">
				</div>
				<br/>
				<div id="photo_choice" style="display:none;">
					<input type="file" class = "btn btn-outline-dark" id="upload" accept="image/gif,image/png,image/jpeg">
					<input type="button" class = "btn btn-outline-dark" value="전송" id="photo_submit">
					<input type="button" class = "btn btn-outline-dark" value="취소" id="photo_reset">
				</div>

				</div>
				<br/>
				<div class = "form-group row">
					<div class = "text-center col-sm-10">
						<form:button class = "btn btn-outline-dark">회원정보수정</form:button>&nbsp;&nbsp;
						<input type="button" class = "btn btn-outline-dark" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
					</div>
				</div>
		</form:form>
	</div>
</div>
<!-- 중앙 내용 끝 -->