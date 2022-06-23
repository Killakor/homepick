<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<meta name="viewport" content="width=device-width,initial-scale=1">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 카카오 관련 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	Kakao.init('faf0c37f915089c12fea10b024c3c7d7'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); //sdk 초기화 여부판단
	
	//카카오 로그인
	function kakaoLogin() {
	    Kakao.Auth.login({
	      success: function (response) {
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function (response) {
	        	  $.ajax({	//카카오 로그인 세션 처리
	        		  url:"kakaologin.do",
	        		  type:"POST",
	        		  data:{
	        			  id : response.id,
	        			  nickname : response.kakao_account.profile.nickname,
	        			  profile_image_url : response.kakao_account.profile.profile_image_url
	        			  },
	        		  dataType:"json",
	        		  success:function(param){
	        			  alert(param.knickname + "님 환영합니다!!");
	        			  location.href='${pageContext.request.contextPath}/member/kakaoMemberInfoRegister.do';
	        		  },
	  				  error : function(request,status,error){      //에러메세지 반환
			               alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			          }
	        	  })
	          },
	          fail: function (error) {
	          },
	        })
	      },
	      fail: function (error) {
	      },
	    })
	  } 
</script>

<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">

	<h3>회원 로그인</h3>

	<div class="text-center col-sm-12 my-5">
		<form:form id="login_form" action="login.do" modelAttribute="memberDTO">
			
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="mem_id">아이디</label>
				<form:input class = "col-sm-5 form-control" path="mem_id"/>
				<form:errors path="mem_id" cssClass="error-color" style="margin-left:170px;"/>
			</div>
			
			<div class = "form-group row">
				<label class = "col-sm-3 col-form-label" for="passwd">비밀번호</label>
				<form:password class = "col-sm-5 form-control" path="passwd"/>
				<form:errors path="passwd" cssClass="error-color" style="margin-left:170px;"/>
			</div>
			
			<%-- 오류 현상 확인 필요 --%>
			<form:errors cssClass="error-color" style="margin-left:170px;"/>
			
			<br/>
			
			<div class = "form-group row" style=" padding-left: 6em;">
				<form:button class = "btn btn-outline-dark" type="submit">로그인</form:button>&nbsp;&nbsp;&nbsp;
				<input type = "button" class = "btn btn-outline-dark" value = "아이디찾기" onclick = "location.href='${pageContext.request.contextPath}/member/idSearch.do'">&nbsp;&nbsp;&nbsp;
				<input type = "button" class = "btn btn-outline-dark" value = "비밀번호찾기" onclick = "location.href='${pageContext.request.contextPath}/member/passwdSearch.do'">
			</div>
		</form:form>
		
		<br/>
		
		<%-- 카카오 로그인 --%>
		<div class = "form-group row">
			<div class = "form-group col" style="padding-right: 10em;">
				<a href="javascript:void(0)">
					<img width="320" height="50" src="../resources/images/kakao_login_img.png" onclick="kakaoLogin();"/>
				</a>
			</div>
		</div>

	</div>
</div>
