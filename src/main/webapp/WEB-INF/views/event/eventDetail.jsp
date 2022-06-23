<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.btn#run {
	cursor: pointer;
	width: 50px;
    height: 30px;
    font-size:13px;
    margin-top:7px;
	margin-bottom:22px;
	bordr-color: #b8b7b4;
}

.btn comm-reset {
	cursor: pointer;
	width: 50px;
    height: 30px;
    font-size:13px;
    margin-top:7px;
	margin-bottom:22px;
}

.btn-default {
	color: #333;
	background-color: #fff;
	border-color: #ccc;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- SNS 공유 -->
<script>
	//페이스북
	function shareFacebook() {
		
	    var sendUrl = 'localhost:8080/teamproject/event/eventDetail.do?event_num=${event.event_num}';
	    window.open('http://www.facebook.com/sharer/sharer.php?u=' + sendUrl);
	    
	}
	
	//카카오톡
	function shareKakao() {
		var content = document.getElementById('btnKakao').innerHTML;
		
		// 사용할 앱의 JavaScript 키 설정
		Kakao.init('faf0c37f915089c12fea10b024c3c7d7');
		// 링크 버튼 생성
		Kakao.Link.createDefaultButton({
			container: '#btnKakao',
			objectType: 'feed',
			content: {
				title: '인테리어의 모든 것! 홈픽',
				description: '매일 새롭게 올라오는 예쁜 집들을 구경하세요!',
				imageUrl: 'localhost:8080/teamproject/main/main.do',
				link: {
				mobileWebUrl: 'localhost:8080/teamproject/main/main.do',
				webUrl: 'localhost:8080/teamproject/main/main.do'
				}
			}
		});
	}
	
	//트위터
	function shareTwitter() {
	    var sendText = '인테리어의 모든 것! 홈픽';
	    var sendUrl = 'http://localhost:8080/teamproject/event/eventDetail.do?event_num=${event.event_num}';
	    window.open('https://twitter.com/intent/tweet?text=' + sendText + '&url=' + sendUrl);
	}
	
	//클릭시 URL 복사
    function copyUrl() {
    	var url='';
	    var textarea = document.createElement("textarea");
	    document.body.appendChild(textarea);
	    url=window.document.location.href;
	    textarea.value=url;
	    textarea.select();
	    document.execCommand('copy');
	    document.body.removeChild(textarea);
	    alert("해당 주소가 복사되었습니다.")
    }
    
    
    //댓글 Ajax
	$(function(){
		
		var currentPage;
		var count;
		var rowCount;
		
		//댓글 목록
		function selectData(pageNum,event_num){
			currentPage = pageNum;
			
			if(pageNum == 1){
				//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
				$('#output').empty();
			}
			
			//로딩 이미지 노출
			$('#loading').show();
			
			$.ajax({
				type:'post',
				data:{
					pageNum:pageNum,
					event_num:event_num
					},
				url:'listComment.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					//로딩 이미지 감추기
					$('#loading').hide();
					count = param.count;
					rowCount = param.rowCount;
					
					//인자 item이 list에 들어가는 값을 받음
					//each() 메소드는 매개변수로 받은 것을 사용해 for in 반복문과 같이 배열이나 객체의 요소를 검사함
					$(param.list).each(function(index, item){
						var output = '<div class="item">';
						if(item.profile != null) {
							output += '<div style="width:57px; height:57px; float:left; padding-right:5em;"><img src="${pageContext.request.contextPath}/event/commentPhotoView.do?mem_num=' + item.mem_num + '" style="height:42px; width:42px;" class="my-photo" id="profile"/></div>';
						} else {
							output += '<div style="width:57px; height:57px; float:left; padding-right:5em;"><img src="${pageContext.request.contextPath}/resources/images/basic.png" style="height:42px; width:42px;" class="my-photo" id="profile"/></div>';
						}
						output += '<div style="font-size:15px; float:left;"><b>' + item.nickname + '</b></div>' + '<div>&nbsp;·&nbsp;' + item.comm_reg_date + '</div>';
						output += '<div class="sub-item">';
						output +='   <p>' + item.comm_content.replace(/</gi,'&lt;').replace(/>/gi,'&gt;') + '</p>';
						if($('#mem_num').val()==item.mem_num){
							
							//로그인한 회원 번호가 댓글 작성자 회원 번호와 같으면 버튼 노출
							output += ' <input type="button" data-num="'+item.comm_num+'" data-mem="'+item.mem_num+'" value="수정" id="run" class="btn modify-btn" style="margin-left:70px;">';
							output += ' <input type="button" data-num="'+item.comm_num+'" data-mem="'+item.mem_num+'" value="삭제" id="run" class="btn delete-btn">';
						}
						output += '  <hr size="1" noshade>';
						output += '</div>';
						output += '</div>';
						
						//문서 객체에 추가
						$('#output').append(output);						
					});
					
					//paging button 처리
					if(currentPage > =Math.ceil(count/rowCount)){
						//다음 페이지가 없음
						$('.paging-button').hide();
					} else{
						//다음 페이지가 존재
						$('.paging-button').show();
					}
					
				},
				error:function(){
					alert('잘못된 접근으로 네트워크 오류가 발생하였습니다.');
				}
			});
			
		}
		//다음 댓글 보기 버튼 클릭시 데이터 추가
		$('.paging-button input').click(function(){
			var pageNum = currentPage + 1;
			selectData(pageNum,$('#event_num').val());
		});
		
		//댓글 등록(기본 이벤트 제거하기 위해 이벤트 객체를 받음)
		$('#comm_form').submit(function(event){
			if($('#comm_content').val().trim()==''){
				alert('내용을 입력해주세요!');
				$('#comm_content').val('').focus();
				return false;
			}
			
			// form 이하의 태그에 입력한 데이터를 모두 읽어옴
			var data =$(this).serialize();
			//등록
			$.ajax({
				type:'post',
				data:data,	// 키(data): 변수(form_data) - 전달
				url:'writeComment.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('댓글은 로그인하셔야 작성하실 수 있습니다.');
					} else if(param.result == 'success'){
						//폼 초기화
						initForm();
						//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글들을 다시 호출
						selectData(1, $('#event_num').val());
					} else {
						alert('잘못된 접근으로 댓글 등록에 오류가 발생하였습니다.');
					}
				},
				error : function(request,status,error) { // 에러메시지 반환
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
			//기본 이벤트 제거 - submit 막아야 함
			event.preventDefault();
		});
		
		//댓글 작성 폼 초기화
		function initForm(){
			$('textarea').val('');
			$('#comm_first .letter-count').text('300/300');
		}
		//textarea에 내용 입력시 글자수 체크
		$(document).on('keyup','textarea',function(){
			//입력한 글자수 변수화
			var inputLength = $(this).val().length;
			
			//300자를 넘어선 경우
			if(inputLength > 300){
				$(this).val($(this).val().substring(0, 300));
			} else {
				var remain = 300 - inputLength;
				remain += '/300';
				if($(this).attr('id') == 'comm_content'){
					//등록폼 글자수
					$('#comm_first .letter-count').text(remain);
				} else{
					//수정폼 글자수
					$('#mcomm_first .letter-count').text(remain);
				}
			}
		});
		
		//댓글 수정 버튼 클릭시 수정폼 노출
		$(document).on('click','.modify-btn',function(){
			//댓글 글번호
			var comm_num = $(this).attr('data-num');
			//작성자 회원 번호
			var mem_num = $(this).attr('data-mem');
			//댓글 내용
			//this는 수정버튼 부모태그로 가서 p태그를 찾고 내용을 가져옴, br/gi 태그는 \n으로 변경, i의 의미는 대소문자 구분x, g의 의미는 전체
			var content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
			
			//댓글 수정폼 UI
			var modifyUI = '<form id="mcomm_form">';
			   modifyUI += '  <input type="hidden" name="comm_num" id="mcomm_num" value="'+comm_num+'">';
			   modifyUI += '  <input type="hidden" name="mem_num" id="mmem_num" value="'+mem_num+'">';
			   modifyUI += '  <textarea rows="3" cols="50" name="comm_content" id="mcomm_content" class="commp-content">'+content+'</textarea>';
			   modifyUI += '  <div id="mcomm_first"><span class="letter-count">300/300</span></div>';	
			   modifyUI += '  <div id="mcomm_second" class="align-right">';
			   modifyUI += '     <input type="submit" value="수정" id="run" class="btn">';
			   modifyUI += '     <input type="button" value="취소" id="run" class="btn comm-reset">';
			   modifyUI += '  </div>';
			   modifyUI += '  <hr size="1" noshade width="90%">';
			   modifyUI += '</form>';
			   
			//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면, 숨김 sub-item을 환원시키고 수정 폼을 최기화
			initModifyForm();
			
			//지금 클릭해서 수정하고자 하는 데이터는 감추기
			$(this).parent().hide();
			
			//수정폼을 수정하고자하는 데이터가 있는 div에 노출
			$(this).parents('.item').append(modifyUI);
			
			//입력한 글자수 셋팅
			var inputLength = $('#mcomm_content').val().length;
			var remain = 300 - inputLength;
			remain += '/300';
			
			//문서 객체에 반영
			$('#mcomm_first .letter-count').text(remain);		
		});
		
		//수정폼에서 취소 버튼 클릭시 수정폼 초기화
		$(document).on('click','.comm-reset',function(){
			initModifyForm();
		});
		
		//댓글 수정 폼 초기화
		function initModifyForm(){
			$('.sub-item').show(); // sub-item 보여줌
			$('#mcomm_form').remove(); // 폼 초기화
		}
		
		//댓글 수정
		//form submit을 막기 위해 event 객체를 받음
		$(document).on("submit","#mcomm_form", function(event){
			if($("#mcomm_content").val().trim() == ""){
				alert("내용을 입력해주세요!");
				$("#mcomm_content").val("").focus();
				return false;
			}
			
			// 폼에 입력한 데이터 변환
			var data = $(this).serialize();
					
			// 댓글 수정
			$.ajax({
				type:"post",
				url:"updateComment.do",
				data: data, // 오른쪽 form_data(value)는 중괄호 형태의 json 표기법으로 바뀜
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == "logout"){
						alert("로그인해야 수정할 수 있습니다.")
					} else if(param.result == "success"){
						//전송을 누르면 전송되지 않고 그대로 화면에 읽어와서 표시
						//form을 없애기 전에 form에 접근해서 정보를 읽음
						//부모로 올라가서 p태그를 찾아 내용을 넣어줌, html태그를 불허용했기 때문에 바꾸는 작업처리 필요
						$('#mcomm_form').parent().find('p').html($('#mcomm_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;'));
						//수정폼 초기화
						initModifyForm();
						alert('댓글이 수정되었습니다');
					} else if(param.result == "wrongAccess"){
						alert("타인의 글을 수정할 수 없습니다.");
					} else {
						alert("잘못된 접근으로 댓글 수정에 오류가 발생하였습니다.");
					}
				},
				error : function(request,status,error){
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
			//기본 이벤트 제거(해당 문법이 빠질 시 summit 되버림 필수!**)
			event.preventDefault();
		});
		
		
		//댓글 삭제
		$(document).on('click','.delete-btn',function(){
			//확인,취소 선택창
			var check = confirm('댓글을 삭제하시겠습니까?');
			if(check){
				//댓글 번호
				var comm_num = $(this).attr('data-num');
				//작성자 회원 번호
				var mem_num = $(this).attr('data-mem');
				
				$.ajax({
					type:'post',
					url:'deleteComment.do',
					data:{
						comm_num:comm_num,
						mem_num:mem_num
						},
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						if(param.result == 'logout'){
							alert('댓글은 로그인하셔야 삭제하실 수 있습니다.');
						} else if(param.result == 'success'){
							alert('댓글이 삭제되었습니다.');
							selectData(1,$('#event_num').val());
						} else if(param.result == 'wrongAccess'){
							alert('타인의 글을 삭제할 수 없습니다.');
						} else {
							alert('잘못된 접근으로 댓글 삭제에 오류가 발생하였습니다.');
						}
					},
					error:function(request,status,error){
						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
					}
				});
				} else {
			}
		});
		
		//초기 데이터(목록) 호출
		selectData(1, $('#event_num').val());
	});
</script>
<style>
.main-container{
	width:1000px;
	margin : 0 auto;
}
.title-item{
	text-align: left;
}
.date-item{
	text-align: left;
}
.content-item{
	text-align: left;
	padding: 50px 0px 140px 10px;
}
.hits-item{
	text-align: right;
	border-bottom : 1px solid #dbdbdb;
	padding : 0px 8px 0px 10px;
}
.icon-item{
	border-top : 1px solid #dbdbdb;
	text-align: right;
	padding : 40px 8px 0px 100px;
}
</style>

<!-- 이벤트 상세보기 -->
<div class="container">
	<div class="main-container"> 
		
		<!-- 이벤트 정보 -->
	 	<div class="title-item" align="center">
	 		<h2 id="title" style="font-family: 'Gowun Dodum', sans-serif;">${event.event_title}</h2>
	 	</div>
	 	
	 	<div class="date-item" align="center">
	 		<p style="font-family: 'Gowun Dodum', sans-serif;">${event.event_reg_date}</p>
	 	</div>
	 	<div class="hits-item" align="center">
	 		<p style="font-family: 'Gowun Dodum', sans-serif;">hits : ${event.event_hits}  |  작성자 : 관리자</p>
	 		<p style="font-family: 'Gowun Dodum', sans-serif;">카테고리: ${event.event_type}	|	진행날짜: ${event.event_day}</p>
	 	</div>

		<br>

		<!-- 이벤트 썸네일 -->
		<c:if test="${!empty event.event_filename}">
			<div style="display:none">
				<img src="imageView.do?event_num=${event.event_num}" style="max-width:500px">
			</div>
		</c:if>
		
		<!-- 이벤트 내용 -->
	 	<div class="content-item" align="center">
	 		<p id="content">${event.event_content}</p>
	 	</div>
	 	
	 	<!-- SNS 공유 -->
		<div align="right">
			<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();"></a>
			<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a>
			<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>
			<a id="btnUrl" class="link-icon url" style="cursor: pointer;" onclick="copyUrl(); return false;" title="URL 복사"></a>
		</div>
		
	 	<!-- 버튼 -->
	 	<div align="right">
		 	<a class = "btn btn-outline-dark"  href="${pageContext.request.contextPath}/event/eventList.do">목록으로 돌아가기</a>
		 	<%-- 관리자일 경우, 수정/삭제 기능 추가 --%>
		 	<c:if test="${user_auth == 4}">
			 	<a class = "btn btn-outline-dark" href="${pageContext.request.contextPath}/event/eventUpdate.do?event_num=${event.event_num}">수정</a>
				<a class = "btn btn-outline-dark" href="${pageContext.request.contextPath}/event/eventDelete.do?event_num=${event.event_num}" onclick="return confirm('해당 이벤트를 삭제하시겠습니까?');">삭제</a>
			</c:if>
	 	</div>
	 	
		<hr size="1" noshade="noshade">

	 	<!-- 댓글 -->
		<div id="comm_div">
			<form id="comm_form">
				<%-- 전송 값 히든 처리 --%>
				<input type="hidden" name="event_num" value="${event.event_num}" id="event_num">
				<input type="hidden" name="mem_num" value="${user_num}" id="mem_num"><br><br>
				
				<%-- 댓글 작성 불가능 할 경우 --%>
				<textarea rows="5" name="comm_content" id="comm_content" class="form-control" placeholder="댓글을 남겨보세요.">
					<c:if test="${empty user_num}">disabled="disabled"</c:if>
					<c:if test="${empty user_num}">로그인 해야 작성하실 수 있습니다.</c:if>
				</textarea>
				
				<%-- 댓글 작성 가능 할 경우 --%>
				<c:if test="${!empty user_num }">
					<div id="comm_first">
						<span class="letter-count">300/300</span>
					</div>
					<div id="comm_second" class="align-right">
						<input class = "btn btn-outline-dark" type="submit" value="등록" >
					</div>
				</c:if>
			</form>
		</div>
		
		<!-- 댓글 목록 -->
		<div id="output"></div>
		<div class="paging-button" style="display: none;">
			<input type="button" value="더보기">
		</div>
		<div id="loading" style="display: none;">
			<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif">
		</div>
	 	
	 </div>
 </div>