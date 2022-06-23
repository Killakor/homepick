<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.svg" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<style>
/* GNB */
.navcontainer {
	display: flex;
	align-items: flex-start;
	postion: relative;
	box-sizing: border-box;
	max-width: 1256px;
	height: 80px;
	padding: 0px 80px;
	margin: 0 auto;
}

/* 커뮤니티 스토어 버튼 설정 */
.navmenuitem {
	float: left;
	display: display-block;
	position: relative;
	font-weight: 700;
	line-height: 26px;
	font-size: 18px;
	padding: 14px 6px;
	margin: 6px 10px 0;
}
.nav-menu {
	display: block;
	margin: auto 0;
	width: 300px;
	flex: 0 0 auto;
}

/* 상단 우측 (통합검색부터 글쓰기까지) */
#search {
}
.nav-right {
	display: flex;
	margin: auto 0;
	justify-content: flex-end;
	align-items: center;
	position: static;
	width: 720px;
	line-height: 1;
	flex-grow: 1;
	flex: 0 0 auto;
}
.navrightitem {
	display: inline-block;
	position: relative;
	font-weight: 700;
	line-height: 20px;
	font-size: 15px;
	padding: 14px 6px;
	margin: 7px 10px 0;
}

/* GNB 2depth */
.navline {
	z-index: 502;
	position: relative;
	transition: top .1s;
	border-bottom: 1px solid #ededed;
}

/* 드롭 다운 */
.dropdownbar {
	position: absolute;
	height: 0px;
	overflow: hidden;
	transition: height .2s;
	-webkit-transition: height .2s;
	-moz-transition: height .2s;
	-o-transition: height .2s;
	width: 800px;
	margin-top: 80px;
}
.dropdownbar li {
	display: inline-block;
}
.navmenuli:hover .dropdownbar {
	height: 40px;
}
.navmenuli a:hover, .navmenuli a.active, .navmenuli a.active:hover {
	color: #F5A100;
}
.navmenuitemdropdown {
	font-size: 15px;
	line-height: 18px;
	margin: auto 0;
	padding: 6px 8px 4px;
}

/* 드롭다운 시 여백 */
.nav-dropdown {
	margin: 50px;
}
.navrightitemdropdown {
	font-size: 15px;
	line-height: 18px;
	margin: auto 0;
	padding: 6px 8px 4px;
	font-weight: bold;
}
.navrightmenuli:hover .dropdownbar {
	height: 40px;
}
.nav-left {
	margin-top: 22px;
	margin-right: 30px;
}
.topbar {
	font-family: 'Noto Sans KR', sans-serif;
}
.nav-menu {
	font-family: 'Noto Sans KR', sans-serif;
}
.nav-right {
	font-family: 'Noto Sans KR', sans-serif;
}
.nav-dropdown {
	font-family: 'Noto Sans KR', sans-serif;
}
div.nav-right-menu {
	font-family: 'Noto Sans KR', sans-serif;
}
.navrightmenuli {
	font-family: 'Noto Sans KR', sans-serif;
}
ul li.navrightmenuli {
	font-family: 'Noto Sans KR', sans-serif;
}
ul.dropdownbar {
	font-family: 'Noto Sans KR', sans-serif;
}
ul li.navmenuli {
	font-family: 'Noto Sans KR', sans-serif;
}
.dropbtn {
	background-color: #4CAF50;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}
.dropbtn:hover, .dropbtn:focus {
	background-color: #F5A100;
}
.dropdown {
	position: relative;
	display: inline-block;
}
.dropdown-content {
	display: none;
	position: absolute;
	background-color: #000000;
	min-width: 160px;
}
.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}
.dropdown-content a:hover {
	background-color: #F5A100
}
.show {
	display: block;
}
ul.dropdownbar li.navmenuitemdropdown {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	//드롭 다운 기능(현재 미구현 - css로 임시 구현)
	function myFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

	window.onclick = function(event) {
		if (!event.target.matches('.dropbtn')) {
			var dropdowns = document.getElementsByClassName("dropdown-content");
			var i;
			for (i = 0; i < dropdowns.length; i++) {
				var openDropdown = dropdowns[i];
				if (openDropdown.classList.contains('show')) {
					openDropdown.classList.remove('show');
				}
			}
		}
	}
	
	$(document).ready(function(){
		$('.navmenuitem').click(function(){
			if( $(this).hasClass("active")) {
				$(this).removeClass("active");
			} else {
				$(this).addClass("active");
			}
		});
	});

</script>

<!-- GNB Contaioner -->
<div class="topbar">
	<div class="navline">
		<div class="navcontainer">
			<!-- 로고 -->
			<div class="nav-left">
				<a class="logo" href="${pageContext.request.contextPath}/main/main.do" style="">
					<img src="${pageContext.request.contextPath}/resources/images/logo-main.png" style="height: 40px;"></a>
			</div>
			
			<!-- 기본메뉴 -->
			<nav class="nav-menu" style="float: left;">
				<ul class="navmenuul">
					<li class="navmenuli"><a class="navmenuitem" style="text-decoration: none;" href="${pageContext.request.contextPath}/store/storeCategory.do">스토어</a></li>
					<li class="navmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/houseBoard/list.do" style="text-decoration: none;">커뮤니티</a>
						<ul class="dropdownbar">
							<li class="navmenuitemdropdown" style="text-decoration: none; font-weight: bold;"><a href="${pageContext.request.contextPath}/houseBoard/list.do">집들이</a></li>
							<li class="navmenuitemdropdown" style="text-decoration: none; font-weight: bold;"><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
							<li class="navmenuitemdropdown" style="text-decoration: none; font-weight: bold;"><a href="${pageContext.request.contextPath}/qna/qnaList.do">고객센터</a></li>
						</ul>
					</li>
					<li class="navmenuli"><a class="navmenuitem" style="text-decoration: none; color: royalblue" href="${pageContext.request.contextPath}/event/eventList.do">이벤트</a></li>
				</ul>
			</nav>
			
			<%-- 비회원일 경우 --%>
			<c:if test="${empty user_num}">
				<nav class="nav-right">
					<form id="search" action="${pageContext.request.contextPath}/mainSearch/mainSearch.do" method="get">
						<div class="search-bar" style="width: 200px; margin-top: 10px; margin-left: 0px; margin-right: 0px;">
							<input type="search" name="keyword" id="keyword" class="form-control" placeholder="제품을 검색하세요 (｡･∀･)ﾉﾞ" style="font-size: 13px;" autocomplete="off" aria-label="통합검색" aria-describedby="button-addon2">
						</div>
					</form>
					
					<a class="navrightitem" href="${pageContext.request.contextPath}/member/login.do" style="text-decoration: none;">로그인</a>
					<a class="navrightitem" href="${pageContext.request.contextPath}/member/registerUser.do" style="text-decoration: none;">회원가입</a>
					<a class="navrightitem" href="${pageContext.request.contextPath}/order/nonCheck.do" style="text-decoration: none;">비회원주문조회</a>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="#"
								style="color: #F5A100; text-decoration: none;">글쓰기</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/houseBoard/write.do">사진올리기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/review/myBuyList.do">상품리뷰 쓰기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/serviceBoardInsert.do">고객센터 질문하기</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</c:if>
			
			<%-- 정지회원일 경우 --%>
			<c:if test="${!empty user_num && user_auth == 1}">
				<nav class="nav-right">
					<form id="search" action="${pageContext.request.contextPath}/mainSearch/mainSearch.do" method="get">
						<div class="search-bar" style="width: 200px; margin-top: 10px; margin-left: 0px; margin-right: 0px;">
							<input type="search" name="keyword" id="keyword" class="form-control" placeholder="제품을 검색하세요 (｡･∀･)ﾉﾞ" style="font-size: 13px;" autocomplete="off" aria-label="통합검색" aria-describedby="button-addon2">
						</div>
					</form>
					<!-- 회원 프로필 사진 -->
					<c:if test="${empty user_photo}">
						<img src="${pageContext.request.contextPath }/resources/images/basic.png" width="33" height="33" class="my-photo">
					</c:if>
					<c:if test="${!empty user_photo}">
						<img src="${pageContext.request.contextPath }/member/photoView.do" width="33" height="33" class="my-photo">
					</c:if>
					
					<span class="navrightitem">${user_nickname} 님은 <b style="color: red;">정지회원</b>입니다.</span>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="#" style="color: #F5A100; text-decoration: none;">마이페이지</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</c:if>
			
			<%-- 일반회원일 경우 --%>
			<c:if test="${!empty user_num && user_auth == 2}">
				<nav class="nav-right">
					<form id="search" action="${pageContext.request.contextPath}/mainSearch/mainSearch.do" method="get">
						<div class="search-bar" style="width: 200px; margin-top: 10px; margin-left: 0px; margin-right: 0px;">
							<input type="search" name="keyword" id="keyword" class="form-control" placeholder="제품을 검색하세요 (｡･∀･)ﾉﾞ" style="font-size: 13px;" autocomplete="off" aria-label="통합검색" aria-describedby="button-addon2">
						</div>
					</form>
					<!-- 회원 프로필 사진 -->
					<c:if test="${empty user_photo}">
						<img src="${pageContext.request.contextPath }/resources/images/basic.png" width="33" height="33" class="my-photo">
					</c:if>
					<c:if test="${!empty user_photo }">
						<img src="${pageContext.request.contextPath }/member/photoView.do" width="33" height="33" class="my-photo">
					</c:if>
					
					<span class="navrightitem">${user_nickname} 님</span>
					<a class="navrightitem" href="${pageContext.request.contextPath}/cart/cartList.do">장바구니</a>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="color: #F5A100; text-decoration: none;">마이페이지</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/order/myOrder.do">나의쇼핑</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/sellerApplication.do">판매자신청</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="#"
								style="color: #F5A100; text-decoration: none;">글쓰기</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/houseBoard/write.do">사진올리기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/review/myBuyList.do">상품리뷰 쓰기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/serviceBoardInsert.do">고객센터질문하기</a></li>
									<li class="navrightitemdropdown"style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/store/storeRegister.do">상품등록</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</c:if>
			
			<%-- 판매자회원일 경우 --%>
			<c:if test="${!empty user_num && user_auth == 3}">
				<nav class="nav-right">
					<form id="search" action="${pageContext.request.contextPath}/mainSearch/mainSearch.do" method="get">
						<div class="search-bar" style="width: 200px; margin-top: 10px; margin-left: 0px; margin-right: 0px;">
							<input type="search" name="keyword" id="keyword" class="form-control" placeholder="제품을 검색하세요 (｡･∀･)ﾉﾞ" style="font-size: 13px;" autocomplete="off" aria-label="통합검색" aria-describedby="button-addon2">
						</div>
					</form>
					
					<!-- 회원 프로필 사진 -->
					<c:if test="${empty user_photo}">
						<img src="${pageContext.request.contextPath }/resources/images/basic.png" width="33" height="33" class="my-photo">
					</c:if>
					<c:if test="${!empty user_photo}">
						<img src="${pageContext.request.contextPath }/member/photoView.do" width="33" height="33" class="my-photo">
					</c:if>
					
					<span class="navrightitem">${user_nickname} 님</span>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="color: #F5A100; text-decoration: none;">판매자페이지</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myProduct.do">나의물건</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="#"
								style="color: #F5A100; font-family: text-decoration : none;">등록</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/houseBoard/write.do">사진올리기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/serviceBoardInsert.do">고객센터질문하기</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/store/storeRegister.do">상품등록</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</c:if>
			
			<%-- 관리자일 경우 --%>
			<c:if test="${!empty user_num && user_auth == 4}">
				<nav class="nav-right">
					<form id="search" action="${pageContext.request.contextPath}/mainSearch/mainSearch.do" method="get">
						<div class="search-bar" style="width: 200px; margin-top: 10px; margin-left: 0px; margin-right: 0px;">
							<input type="search" name="keyword" id="keyword" class="form-control" placeholder="제품을 검색하세요 (｡･∀･)ﾉﾞ" style="font-size: 13px;" autocomplete="off" aria-label="통합검색" aria-describedby="button-addon2">
						</div>
					</form>
					
					<!-- 회원 프로필 사진 -->
					<c:if test="${empty user_photo}">
						<img src="${pageContext.request.contextPath }/resources/images/crown.gif" width="37" height="37" class="my-photo">
					</c:if>
					<c:if test="${!empty user_photo}">
						<img src="${pageContext.request.contextPath }/member/photoView.do" width="37" height="37" class="my-photo">
					</c:if>
					
					<span class="navrightitem">관리자</span>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="color: #F5A100; text-decoration: none;">관리자페이지</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">관리자페이지</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
								</ul>
							</li>
						</ul>
					</div>
					
					<div class="nav-right-menu">
						<ul>
							<li class="navrightmenuli"><a class="navmenuitem" href="#"
								style="color: #F5A100; text-decoration: none;">등록</a>
								<ul class="dropdownbar">
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/event/eventWrite.do">이벤트등록</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/notice/noticeWrite.do">공지등록</a></li>
									<li class="navrightitemdropdown" style="color: #F5A100; text-decoration: none;"><a href="${pageContext.request.contextPath}/member/couponRegisterView.do">쿠폰등록</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
			</c:if>

		</div>
	</div>
</div>

<!-- 드롭다운 -->
<div class="nav-dropdown">
	<div class="nav-dropdown-bar">
		<div class="navline"></div>
	</div>
</div>