<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<link rel="stylesheet" href="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.btn#run {
	cursor: pointer;
	width: 50px;
    height: 30px;
    font-size:13px;
    margin-top:7px;
	margin-bottom:22px;
}
div.btn delete-btn {
	cursor: pointer;
	width:44px;
    height:26px;
    font-size:13px;
    margin-top:10px;
	margin-bottom:10px;
	margin-left:5px;
}
div.btn modify-btn {
	cursor: pointer;
	width:44px;
    height:26px;
    font-size:13px;
    margin-top:10px;
	margin-bottom:10px;
	margin-left:5px;
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
.heart-btn{
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
    padding-bottom: 5px;
    padding-top: 5px;
    margin-top: 12px;
    font-size: 13px;
    transition: .2s ease;
    background-color: #ededed;
    border-color: #ededed;
    color: #000000;
    user-select: none;
    width: 100px;
    height: 42px;
}
.scrap-btn{
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
    padding-bottom: 5px;
    padding-top: 5px;
    margin-top: 12px;
    font-size: 13px;
    transition: .2s ease;
    background-color: #ededed;
    border-color: #ededed;
    color: #000000;
    user-select: none;
    width: 100px;
    height: 42px;
}
.my-photo#profile {
	margin-top:0px;
}
.sub-item {
	margin-top:10px;
}
#mcomm_first {
	float:left;
	width:70%;
	padding-left:5px;
	margin-top:7px;
	margin-bottom:22px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	//페이스북
	function shareFacebook() {
		
	    var sendUrl = 'localhost:8080/teamproject/houseBoard/detail.do?house_num=${houseBoard.house_num}';
	    window.open('http://www.facebook.com/sharer/sharer.php?u=' + sendUrl);
	}
	
	//카카오톡
	function shareKakao() {
		var content = document.getElementById('btnKakao').innerHTML;
		
		// 사용할 앱의 JavaScript 키 설정
		Kakao.init('faf0c37f915089c12fea10b024c3c7d7');
		// 링크 버튼 생성
		Kakao.Link.sendDefault({
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
	    var sendUrl = 'http://localhost:8080/teamproject/houseBoard/detail.do?house_num=${houseBoard.house_num}';
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
	$(function() {
		
		var currentPage
		var count;
		var rowCount;
		
		//댓글 목록
		function selectData(pageNum,house_num) {
			currentPage = pageNum;
			
			if(pageNum == 1) {
				//처음 호출시는 해당 ID의 div 내부 내용물을 제거
				$('#output').empty();
			}
			
			//로딩 이미지 노출
			$('#loading').show();
			
			$.ajax({
				type: 'post',
				data: {
					pageNum: pageNum, // key:value
					house_num: house_num
					},
				url: 'listComm.do',
				dataType: 'json',
				cache: false,
				timeout: 30000,
				success: function(param) {
					//로딩 이미지 감추기
					$('#loading').hide();
					count = param.count;
					rowCount = param.rowCount;
					
					//인자 item이 list에 들어가는 값을 받음
					//each() 메소드는 매개변수로 받은 것을 사용해 for in 반복문과 같이 배열이나 객체의 요소를 검사함
					$(param.list).each(function(index, item) {
						var output = '<div class="item">';
						if(item.profile != null) {
							output += '<div style="width:55px; height:57px; float:left; padding-right:5em; margin-right:-18px;"><img src="${pageContext.request.contextPath}/houseBoard/boardProfile.do?mem_num='+item.mem_num+'" style="height:42px; width:42px;" class="my-photo" id="profile"/></div>';
						} else {
							output += '<div style="width:55px; height:57px; float:left; padding-right:5em; margin-right:-18px;"><img src="${pageContext.request.contextPath}/resources/images/basic.png" style="height:42px; width:42px;" class="my-photo" id="profile"/></div>';
						}
						output += '<div style="font-size:15px; float:left;"><b>' + item.nickname + '</b></div>' + '<div>&nbsp;·&nbsp;' + item.comm_reg_date + '</div>';
						output += '<div class="sub-item">';
						output += '   <p>' + item.comm_content.replace(/</gi,'&lt;').replace(/>/gi,'&gt;') + '</p>';
						if($('#mem_num').val() == item.mem_num || $('#user_auth').val() == 4) {
							
							//로그인한 회원번호가 댓글 작성자 회원번호와 같으면 버튼 노출
							output += ' <input type="button" data-num="'+item.comm_num+'" data-mem="'+item.mem_num+'" value="수정" id="run" class="btn modify-btn" style="margin-left:70px;">';
							output += ' <input type="button" data-num="'+item.comm_num+'" data-mem="'+item.mem_num+'" value="삭제" id="run" class="btn delete-btn">';
						}
						output += '  <hr size="1" style="color:#bfbfbf; noshade;">';
						output += '</div>';
						output += '</div>';
						
						//문서 객체에 추가
						$('#output').append(output);						
					});
					
					//paging button 처리
					if(currentPage >= Math.ceil(count/rowCount)) {
						//다음 페이지가 없음
						$('.paging-button').hide();
					} else{
						//다음 페이지가 존재
						$('.paging-button').show();
					}
				},
				error: function(request,status,error) {
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		}
		
		
		//다음 댓글 보기 버튼 클릭시 데이터 추가
		$('.paging-button input').click(function() {
			var pageNum = currentPage + 1;
			selectData(pageNum,$('#house_num').val());
		});
		
		//댓글 등록(기본 이벤트 제거하기 위해 이벤트 객체를 받음)
		$('#comm_form').submit(function(event) {
			if($('#comm_content').val().trim() == '') {
				alert('내용을 입력하세요');
				$('#comm_content').val('').focus();
				return false;
			}
			
			//form 이하의 태그에 입력한 데이터를 모두 읽어옴
			var form_data = $(this).serialize();
			//등록
			$.ajax({
				type: 'post',
				data: form_data, // 키(data): 변수(form_data) - 전달
				url: 'writeComm.do',
				dataType: 'json',
				cache: false,
				timeout: 30000,
				success: function(param) {
					if(param.result == 'logout') {
						alert('댓글은 로그인하셔야 작성하실 수 있습니다.');
					} else if(param.result == 'success') {
						// 폼 초기화
						initForm();
						// 댓글 작성이 성공하면 새로 삽입한 글을 포함하여 첫번째 페이지의 게시글들을 다시 호출
						selectData(1,$('#house_num').val());
					} else {
						alert('잘못된 접근으로 댓글 등록에 오류가 발생하였습니다.');
					}
				},
				error: function(request,status,error) { // 에러메시지 반환
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
			//기본 이벤트 제거 - submit 막아야 함
			event.preventDefault();
		});
		
		//댓글 작성 폼 초기화
		function initForm() {
			$('textarea').val('');
			$('#comm_first .letter-count').text('300/300'); // class 후손선택자
		}
		
		//textarea에 내용 입력시 글자수 체크
		$(document).on('keyup','textarea',function() {
			//입력한 글자수 변수화
			var inputLength = $(this).val().length;
			
			//300자를 넘어선 경우
			if(inputLength > 300) {
				$(this).val($(this).val().substring(0, 300));
			} else {
				var remain = 300 - inputLength;
				remain += '/300';
				if($(this).attr('id') == 'comm_content') {
					//등록폼 글자수
					$('#comm_first .letter-count').text(remain);
				} else {
					//수정폼 글자수
					$('#mcomm_first .letter-count').text(remain);
				}
			}
		});
		
		//댓글 수정 버튼 클릭시 수정폼 노출
		$(document).on('click','.modify-btn',function() {
			//댓글 글번호
			var comm_num = $(this).attr('data-num');
			//작성자 회원번호
			var mem_num = $(this).attr('data-mem');
			//댓글 내용
			//this는 수정버튼 부모태그로 가서 p태그를 찾고 내용을 가져옴, br/gi 태그는 \n으로 변경, i의 의미는 대소문자 구분x, g의 의미는 전체
			var comm_content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
			
			//댓글 수정폼 UI
			var modifyUI = '<form id="mcomm_form">';
			   modifyUI += '   <input type="hidden" name="comm_num" id="mcomm_num" value="'+comm_num+'">';
			   modifyUI += '   <input type="hidden" name="mem_num" id="mmem_num" value="'+mem_num+'">';
			   modifyUI += '   <textarea rows="1" name="comm_content" id="mcomm_content" class="form-control" placeholder="칭찬과 격려의 댓글은 작성자에게 큰 힘이 됩니다 :)">'+comm_content+'</textarea>';
			   modifyUI += '   <div id="mcomm_first"><span class="letter-count">300/300</span></div>';
			   modifyUI += '   <div id="mcomm_second" class="align-right">'
			   modifyUI += '	  <input type="submit" value="등록" id="run" class="btn">';
			   modifyUI += '	  <input type="submit" value="취소" id="run" class="btn comm-reset">';
			   modifyUI += '   </div>';
			   modifyUI += '<hr size="1" width="100%" style="color:#bfbfbf; noshade;">';
			   modifyUI += '</form>';
			   
			   //이전에 이미 수정하는 댓글이 있을 경우 수정 버튼을 클릭하면, 숨김 sub-item을 환원시키고 수정 폼을 초기화
			   initModifyForm();
			   
			   //지금 클릭해서 수정하고자 하는 데이터는 감추기
			   $(this).parent().hide();
			   
			   //수정폼을 수정하고자 하는 데이터가 있는 div에 노출
			   $(this).parents('.item').append(modifyUI);
			   
			   //입력한 글자수 세팅
			   var inputLength = $('#mcomm_content').val().length;
			   var remain = 300 - inputLength;
			   remain += '/300';
			   
			   //문서 객체에 반영
			   $('#mcomm_first .letter-count').text(remain);
		});
		
		//수정 폼에서 취소 버튼 클릭시 수정폼 초기화
		$(document).on('click','.comm-reset',function() {
			initModifyForm();
		});
		
		//댓글 수정 폼 초기화
		function initModifyForm() {
			$('.sub-item').show(); // sub-item 보여줌
			$('#mcomm_form').remove(); // 폼 초기화
		}
		
		//댓글 수정
		//form submit을 막기 위해 event 객체를 받음
		$(document).on('submit','#mcomm_form',function(event) {
			if($('#mcomm_content').val().trim() == '') {
				alert('내용을 입력하세요');
				$('#mcomm_content').val('').focus();
				return false;
			}
			
			//폼에 입력한 데이터 반환
			var form_data = $(this).serialize();
			
			//댓글 수정
			$.ajax({
				url: 'updateComm.do',
				type: 'post',
				data: form_data, // 오른쪽 form_data(value)는 중괄호 형태의 json 표기법으로 바뀜
				dataType: 'json',
				cache: false,
				timeout: 30000,
				success: function(param) {
					if(param.result == 'logout') {
						alert('로그인 후 사용하세요');
					} else if(param.result == 'success') {
						//전송을 누르면 전송되지 않고 그대로 화면에 읽어와서 표시
						//form을 없애기 전에 form에 접근해서 정보를 읽음
						// 부모로 올라가서 p태그를 찾아 내용을 넣어줌, html태그를 불허용했기 때문에 바꾸는 작업처리 필요
						$('#mcomm_form').parent().find('p').html($('#mcomm_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;'));
						// 수정폼 초기화
						initModifyForm();
						alert('댓글이 수정되었습니다');
					} else if(param.result == 'wrongAccess') {
						alert('타인의 글을 수정할 수 없습니다.');
					} else {
						alert('잘못된 접근으로 댓글 수정에 오류가 발생하였습니다.');
					}
				},
				error: function(request,status,error) {
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
			//기본 이벤트 제거(해당 문법이 빠질 시 summit 되버림 필수!**)
			event.preventDefault();
		});
		
		
		//댓글 삭제
		$(document).on('click','.delete-btn',function() {
			
			//확인,취소 선택창
			var check = confirm('댓글을 삭제하시겠습니까?');
			if(check){
				//댓글 번호
				var comm_num = $(this).attr('data-num');
				//작성자 회원 번호
				var mem_num = $(this).attr('data-mem');
				
				$.ajax({
					type: 'post',
					url: 'deleteComm.do',
					data: {
						comm_num: comm_num, // key:value
						mem_num: mem_num
						},
					dataType: 'json',
					cache: false,
					timeout: 30000,
					success: function(param) {
						if(param.result == 'logout') {
							alert('댓글은 로그인하셔야 삭제하실 수 있습니다.');
						} else if(param.result == 'success') {
							alert('댓글이 삭제되었습니다.');
							selectData(1,$('#house_num').val());
						} else if(param.result == 'wrongAccess') {
							alert('타인의 글을 삭제할 수 없습니다.');
						} else {
							alert('잘못된 접근으로 댓글 삭제에 오류가 발생하였습니다.');
						}
					},
					error: function(request,status,error) { // 에러메시지 반환
						alert("🤯 code = " + request.status + " message = " + request.responseText + " error = " + error);
					}
				});
				} else {
			}
		});
		
		//초기 데이터(목록) 호출
		selectData(1, $('#house_num').val());
	});
	
	
	//집들이 게시물 삭제
	var delete_btn = document.getElementById('delete_run');
	delete_run.onclick = function() {
		var choice = confirm('해당 게시물을 삭제하시겠습니까?');
		if(choice) {
			location.replace('delete.do?house_num=${houseBoard.house_num}')
		}
	};
	
	
	//추천 및 스크랩
	$(function() {
		$('#heartCount').html("${countHeart}"); // span값 가져오기
		$('#scrapCount').html("${countScrap}");
		
		var house_num = $('#house_num').val(); // hidden값 가져오기
		
		//추천 버튼 클릭 시, 실행 또는 취소
		$(document).on('click','.heart-btn',function() {
			$.ajax({
				data: {
					"house_num": house_num, //보내는 데이터
					},
				tyep: 'post', //데이터 전송 방식
				url: 'heart.do', //데이터 보내는 곳
				dataType: 'json', //보내는 데이터 타입
				cache: false,
				timeout: 30000,
				success: function(param) { //param으로 데이터 전송받음
					if(param.result == 'logout') {
						alert('로그인 후 사용하세요');
						location.replace('../member/login.do');
					} else if(param.result == 'success') {
						alert('추천해주셔서 감사합니다');
						$('#heart').attr('src','../resources/images/like.png');
						$('#heartCount').text(param.countHeart); //span값 변경하기
					} else {
						alert('추천이 취소되었습니다');
						$('#heart').attr('src','../resources/images/dislike.png');
						$('#heartCount').text(param.countHeart);
					}
				},
				error: function(request,status,error) { 
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		});
		
		//스크랩 버튼 클릭 시, 실행 또는 취소
		$(document).on('click','.scrap-btn',function() {
			$.ajax({
				data: {
					"house_num": house_num, //보내는 데이터
					},
				tyep: 'post', //데이터 전송 방식
				url: 'scrap.do', //데이터 보내는 곳
				dataType: 'json', //보내는 데이터 타입
				cache: false,
				timeout: 30000,
				success: function(param) { //param으로 데이터 전송받음
					if(param.result == 'logout') {
						alert('로그인 후 사용하세요');
						location.replace('../member/login.do');
					} else if(param.result == 'success') {
						alert('스크랩이 완료되었습니다');
						$('#scrap').attr('src','../resources/images/scrapO.png');
						$('#scrapCount').text(param.countScrap); //span값 변경하기
					} else {
						alert('스크랩이 취소되었습니다');
						$('#scrap').attr('src','../resources/images/scrapX.png');
						$('#scrapCount').text(param.countScrap);
					}
				},
				error: function(request,status,error) {
					alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		});
		
	});
</script>


<!-- 집들이 상세보기 -->
<div class="page-main">
	<div class="container">
		<input type="hidden" id="house_num" value="${houseBoard.house_num}"/>
		<!-- 작성자 정보 -->
		<div class="profile" style="float:left;">
			<div style="float:left; cursor:pointer;" onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}'">
				<%-- 회원 프로필 사진이 없는 경우 --%>
				<c:if test="${empty houseBoard.profile_filename}">
					<img src="${pageContext.request.contextPath }/resources/images/basic.png" style="width:33px; height:33px; margin-bottom:15px;" class="my-photo">
				</c:if>
				<%-- 회원 프로필 사진이 있는 경우 --%>
				<c:if test="${!empty houseBoard.profile_filename}">
					<img src="${pageContext.request.contextPath}/houseBoard/boardProfile.do?mem_num=${houseBoard.mem_num}" style="width:33px; height:33px; margin-bottom:15px;" class="my-photo">
				</c:if>
				<b style="font-size:16px;">${houseBoard.nickname}</b>
			</div>
		</div>

		<!-- 추천 및 스크랩 -->
		<div class="btn_click" style="float:right; display:inline-block;">
			<!-- 추천 버튼 -->
			<button type="button" id="heart_btn" class="heart-btn">
				<%-- 추천 이미지 변경 --%>
				<c:if test="${heartCheckNum == 0}">
					<img id="heart" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/dislike.png">
				</c:if>
				
				<c:if test="${heartCheckNum == 1}">
					<img id="heart" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/like.png">
				</c:if>
				
				<!-- 추천수 -->
				<span id="heartCount" style="display:inline-block;"></span>
			</button>
			
			<!-- 스크랩 버튼 -->
			<button type="button" id="scrap_btn" class="scrap-btn">
				<%-- 스크랩 이미지 변경 --%>
				<c:if test="${scrapCheckNum == 0}">
					<img id="scrap" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/scrapX.png">
				</c:if>
				
				<c:if test="${scrapCheckNum == 1}">
					<img id="scrap" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/scrapO.png">
				</c:if>
				
				<!-- 스크랩수 -->
				<span id="scrapCount" style="display:inline-block;"></span>
			</button>
		</div>
		
		<hr size="1" width="100%" style="color:#bfbfbf; noshade;">
		
		<!-- 카테고리/등록일/조회수 -->
		<div class="info">
			<div class="category" style="float:left;">
				<span style="color:#737373;">${houseBoard.house_area}&nbsp;｜&nbsp;${houseBoard.house_type}&nbsp;｜&nbsp;${houseBoard.house_style}&nbsp;｜&nbsp;${houseBoard.house_space}</span>
			</div>
			<div class="date">
				<span style="float:right; display:inline-block; color:#737373;">${houseBoard.house_reg_date}&nbsp;등록&nbsp;·&nbsp;조회&nbsp;${houseBoard.house_hits}</span>
			</div>
		</div>
		
		<br/><br/>
		
		<!-- 게시물 내용 -->
		<div class="content">
			<p>${houseBoard.house_content}</p>
		</div>

		<br/><br/>
		
		<!-- SNS 공유 -->
		<div align="right">
			<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();" style="cursor:pointer;"></a>
			<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();" style="cursor:pointer;"></a>
			<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();" style="cursor:pointer;"></a>
			<a id="btnUrl" class="link-icon url" onclick="copyUrl(); return false;" style="cursor:pointer;"></a>
		</div>

		<hr size="1" width="100%" style="color:#bfbfbf; noshade;">
		
		<!-- 수정/삭제/목록 버튼 -->
		<div class="detail-button" style="text-align:right;">
			<%-- 로그인 회원번호 또는 관리자 일 경우만 수정 및 삭제 가능 --%>
			<c:if test="${!empty user_num && user_num == houseBoard.mem_num || user_auth == 4}">
				<input class="btn" type="button" value="수정" id="modify_run" onclick="location.href='update.do?house_num=${houseBoard.house_num}'">
				<input class="btn" type="button" value="삭제" id="delete_run">
			</c:if>
			<input class="btn" type="button" value="목록" onclick="location.href='list.do'">
		</div>
		
		<br/><br/>
		
		<!-- 댓글 -->
		<div class="comm-title" style="font-weight:bold; font-size:15pt;">
			<span>댓글 </span>
			<span style="color:#F5A100">${countComm}</span>
		</div>
		
		<div id="comm_div">
			<form id="comm_form">
				<input type="hidden" name="house_num" value="${houseBoard.house_num}" id="house_num">
				<input type="hidden" name="mem_num" value="${user_num}" id="mem_num">
				<input type="hidden" name="user_auth" value="${user_auth}" id="user_auth">
				<textarea rows="1" name="comm_content" id="comm_content" class="form-control" placeholder="칭찬과 격려의 댓글은 작성자에게 큰 힘이 됩니다 :)"
					<c:if test="${empty user_num}">disabled="disabled"</c:if>
					><c:if test="${empty user_num}">로그인 후 사용하세요</c:if></textarea><!-- 닫는 태그 내리지(띄어쓰지) 말자! 공백으로 인식 됨 -->
					
				<c:if test="${!empty user_num}">
					<div id="comm_first">
						<span class="letter-count">300/300</span>
					</div>
					<div id="comm_second" class="align-right">
						<input type="submit" value="등록" class="btn" id="run">
					</div>
				</c:if>
			</form>
		</div>
		
		<!-- 댓글 목록 -->
		<div id="output"></div>
		<div class="paging-button" style="display:none;">
			<input type="button" value="더보기">
		</div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
		</div>
	</div>
</div>
