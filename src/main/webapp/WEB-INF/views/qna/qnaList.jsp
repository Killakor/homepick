<%@page import="org.hibernate.validator.constraints.Length"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
.box {
	display: flex;
	flex-direction: row;
    flex-wrap: wrap;
    box-sizing: margin-box;
    justify-content: space-between;
    padding-right: 10px;
    padding-left: 10px;
    justify-content: space-between;
}
.link-container{
width:1136px;
margin : 0 auto;
}
.link-tiem{
margin: 0 auto;
width : 100%;
}
.container{
margin : 0 auto;
width: 99%; 
height: 300px; 

position: relative;
}
.link-item{
	border-bottom : 1px solid #dbdbdb;
	width : 900px;
	margin : 0 auto;
}
.title{
	font-size:18px;
	weight:800;
	padding: 10px 10px 10px 10px;
	text-align:left;

}
.reg_date{
	font-size:15px;
	padding: 0px 10px 20px 10px;
	text-align:right;
}
.paging {
	text-align:center;
	padding : 50px;
	margin-top : 40px;
}
h2{
	text-align:left;
}
.write-button{
	text-align: right;
	margin : 40px 100px 0px 30px;
}
.main-container{
	margin : 0 auto;
	width: 1177px; 
	
}
.qna-left-title{
	text-align: left;
	top: 70px;
}
.qna-right-title{
	position: static;
	top: 70px;
	right: 10px;
	text-align: center;
}
.qna-category{
	cursor: pointer; 
	font-size: 18px; 
	color: #81a36f;
}
.quest-img{
	margin-top: 1em;
	margin-bottom: 20px;
	width: 20px; 
	height: 20px;
}
.h2 {
	font: bold;
    text-align: left;
    font-family: 'Gowun Dodum', sans-serif;
}
a.faq_item{
    line-height: 1;
    font-family: "Noto Sans KR", "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", sans-serif;
    -webkit-font-smoothing: antialiased;
    letter-spacing: -0.4px;
    -webkit-box-direction: normal;
    font-size: 18px;
    list-style: none;
    -webkit-tap-highlight-color: transparent;
    text-decoration: none;
    cursor: pointer;
    touch-action: manipulation;
    margin-bottom: 24px;
    display: block;
    font-weight: 700;
    color: #F5A100;
    background-color: transparent;
    border: none;
    padding: 0;
}
a.faq_item:hover{
	color: #6c7a48;
}
.email_button{
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
    width: 220px;
}
.copy-email{
	cursor: pointer;
    touch-action: manipulation;
    margin-left: .5ch;
    border: none;
    background: transparent;
    font-size: 15px;
    text-decoration: underline;
    color: #6c7a48;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!--  공유 API 시작 -->
<script type="text/javascript">
//페이스북
function shareFacebook() {
    var sendUrl = 'localhost:8080/teamproject/event/eventDetail.do?event_num=${event.event_num}'; // 전달할 URL
    window.open('http://www.facebook.com/sharer/sharer.php?u=' + sendUrl);
}
// 카카오톡
function shareKakao() {
		// 사용할 앱의 JavaScript 키 설정
	Kakao.init('bb121a537c2b70043cc692b909a3c23f');
	// 링크 버튼 생성
	Kakao.Link.createDefaultButton({
		container: '#btnKakao', // 공유 버튼 ID
		objectType: 'feed',
		content: {
			title: '홈픽', // 보여질 제목
			description: '새롭게 올라오는 예쁜 집들을 구경하세요!', // 보여질 설명
			imageUrl: 'localhost:8080/teamproject/main/main.do', // 콘텐츠 URL
			link: {
			mobileWebUrl: 'localhost:8080/teamproject/main/main.do',
			webUrl: 'localhost:8080/teamproject/main/main.do'
			}
		}
	});
}
// 트위터
function shareTwitter() {
    var sendText = '홈픽'; // 전달할 텍스트
    var sendUrl = 'http://localhost:8080/teamproject/event/eventDetail.do?event_num=${event.event_num}'; // 전달할 URL
    window.open('https://twitter.com/intent/tweet?text=' + sendText + '&url=' + sendUrl);
}
</script>
<!-- 공유 API  끝 -->
<script type="text/javascript">
 	$(function() {
 		
 		$('.question').click(function(){
 			$(this).parent().find('.answer').slideToggle("slow");
 		});
	});
         
</script>
<!-- 클릭시 이메일 복사 시작-->
<script>
    function copyToClipboard(val) {
	    var t = document.createElement("textarea");
	    document.body.appendChild(t);
	    t.value = val;
	    t.select();
	    document.execCommand('copy');
	    document.body.removeChild(t);
	    alert("이메일 주소가 복사되었습니다.")
    }
</script>
<!-- 클릭시 이메일 복사 끝 -->
<!-- 클릭시 URL 복사 시작-->
  <script>
    function copyUrl() {
    	var url='';
	    var textarea = document.createElement("textarea");
	    document.body.appendChild(textarea);
	    url=window.document.location.href;
	    textarea.value=url;
	    textarea.select();
	    document.execCommand('copy');
	    document.body.removeChild(textarea);
	    alert("URL이 복사되었습니다.")
    }
  </script>
<!-- 클릭시 URL 복사 끝 -->
	<div class="container"> 
		<div class="qna-left-title">
			<br><h2 class="h2">&nbsp;&nbsp;고객센터</h2><br>
			<div class="box">
	   			<section class="col-12 col-md-6 qna_contact"><address>운영시간 : 평일 09:00 ~ 18:00 (주말 &amp; 공휴일 제외)<br>
				    <c:if test="${user_auth != 4}">
			   			이메일 :&nbsp;<a href="${pageContext.request.contextPath}/qna/serviceBoardInsert.do" style="text-decoration:underline">이메일 문의하기</a>
			   			<button id="copybtn" class="copy-email" onclick="copyToClipboard('team4.homepick@gmail.com');" title="주소 복사">이메일 주소 복사</button>
				    </c:if>
	   			<br>전화 :&nbsp;<a href="tel:1234-5678" style="text-decoration: underline;">1234-5678</a></address>
				    <c:if test="${user_auth != 4}">
				        <button class="email_button" type="button" value="이메일 문의하기" onclick="location.href='${pageContext.request.contextPath}/qna/serviceBoardInsert.do'">이메일 문의하기</button>
				    </c:if>
					<c:if test="${user_auth == 4 }"> 
						<input class = "email_button" type="button" value="자주묻는 질문 설정" onclick="location.href='qnaServiceList.do'">
						<input class = "email_button" type="button" value="이메일 문의 내역" onclick="location.href='serviceBoardList.do'"><br><br>
					</c:if> 
	   			</section>
				<section class="col-12 col-md-6 customer-center__faq" >
					<ul class="faq_list" >
						<li><a class="faq_item" href="qnaList.do?keyword=배송관련">배송은 얼마나 걸리나요?</a></li>
						<li><a class="faq_item" href="qnaList.do?keyword=취소/환불">주문 취소는 어떻게 하나요?</a></li>
						<li><a class="faq_item" href="qnaList.do?keyword=서비스/기타">제품의 자세한 정보를 알고 싶어요.</a></li>
						<li><a class="faq_item" href="qnaList.do?keyword=서비스/기타">제품이 불량일 때는?</a></li>
					</ul>
				</section>	   		
	   		</div>
		</div>
	</div>
	<div class = "container-fluid contents-wrap" style = "width:90%">
		<div class="text-center col-sm-30 my-5">
	
		<table class="table table-sm" style="border-spacing: 2px; border-collapse: separate;">
			<tr>
				<th scope="col"><p class="qna-category" onclick="location.href='qnaList.do'">전체</p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=주문/결제">주문/결제</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=배송관련">배송관련</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=취소/환불">취소/환불</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=반품/교환">반품/교환</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=증빙서류발급">증빙서류발급</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=회원정보변경">회원정보변경</a></p></th>
				<th scope="col"><p class="qna-category"><a href="qnaList.do?keyword=서비스/기타">서비스/기타</a></p></th>
			</tr>
		</table>
		<c:if test="${count==0 }">
	   		<div class="result-display">출력할 내용이 없습니다.</div>
		</c:if>
		<table class="table table-sm" style="border-spacing: 2px; border-collapse: separate;">
		<c:if test="${count > 0 }">
			<c:forEach var="qna" items="${list}" varStatus="class_count">
				<tr>
					<th scope = "row">
						<div align="left" style="width: 150%;" class="button-area">
			  				<p class="question" style="cursor: pointer;">
			  				<img class="quest-img" src="${pageContext.request.contextPath}/resources/images/qna.png">
			  				${qna.qna_content }</p>
							<p class="answer" style="display:none; width: 1300px;">
			  				<img class="quest-img" src="${pageContext.request.contextPath}/resources/images/answer.png">
			  				${qna.qna_reply }</p>
						</div>
					</th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
					<th scope = "row"></th>
				</tr>
			</c:forEach>
		</c:if>
		</table>
		<!-- SNS 공유하기 버튼 시작 -->
		<div align="right">
			<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();">　　　</a><!-- 페이스북 -->
			<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();">　　　</a><!-- 카카오톡 -->
			<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();">　　　</a><!-- 트위터 -->
			<a id="btnUrl" class="link-icon url" style="cursor: pointer;" onclick="copyUrl(); return false;" title="URL 복사">　　　</a><!-- URL복사 -->
		</div>
		<!-- SNS 공유 API 버튼 끝 -->
		<div class="align-center">${pagingHtml}</div>
	</div>
</div>