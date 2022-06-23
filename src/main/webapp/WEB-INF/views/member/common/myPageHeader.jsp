<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type="text/javascript">
	//프로필 버튼 오버 시 색상 변경
	$(function(){
		$(".profile_btn").hover(function(){
			$(this).css("background-color", "#f0e9e9");
		}, function() {
			$(this).css("background-color", "white");
		});
	});
</script>

<%-- 일반회원 마이 페이지 --%>
<c:if test="${!empty user_num && user_auth == 2}">
	<div align="left" style="padding-left: 150px;">
		<nav class="nav-right">
		
			<div class="nav-right-menu">
				<ul style=" display: inline-block; ">
					<li class="navrightmenuli">
						<a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="font-size: 20px; text-decoration: none;">프로필</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">모두보기</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myBoard.do">내가 쓴 글</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myScrap.do">스크랩북</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myRecomm.do">좋아요</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myCoupon.do">내 쿠폰</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli">
						<a class="navmenuitem" href="${pageContext.request.contextPath}/order/myOrder.do" style="font-size: 20px; text-decoration: none;">나의쇼핑</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/order/myOrder.do">주문배송내역조회</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/cart/cartList.do">장바구니</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPoint.do">포인트</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli">
						<a class="navmenuitem" href="${pageContext.request.contextPath}/review/myBuyList.do" style="font-size: 20px; text-decoration: none;">나의리뷰</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/review/myBuyList.do">리뷰쓰기</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/review/reviewList.do">내가 작성한 리뷰</a></li> 
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli">
						<a class="navmenuitem" href="${pageContext.request.contextPath}/member/memberUpdate.do" style="font-size: 20px;text-decoration: none;">설정</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberUpdate.do">회원정보수정</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberPasswdUpdate.do">비밀번호변경</a></li> 
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/sellerApplication.do">판매자 신청</a></li> 
						</ul>
					</li>
				</ul>
			</div>
		</nav>	
	</div>	
	
	<hr size="1" style="color:#bfbfbf; noshade; margin-top:-8px;">
	<br/>
	<hr size="1" style="color:#bfbfbf; noshade; margin-top:10px;">
</c:if>

<%-- 판매자 마이페이지 --%>
<c:if test="${!empty user_num && user_auth == 3}">
	<div align="left" style="padding-left: 150px;">
		<nav class="nav-right">
		
			<div class="nav-right-menu">
				<ul style=" display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="font-size: 20px; text-decoration: none;">프로필</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">모두보기</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myBoard.do">내가 쓴 글</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myScrap.do">스크랩북</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myRecomm.do">좋아요</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myCoupon.do">내 쿠폰</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="#" style="text-decoration: none;">나의쇼핑</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myProduct.do">상품 등록 내역 조회</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/order/myOrder.do">주문배송내역조회</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/cart/cartList.do">장바구니</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPoint.do">포인트</a></li>
		
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/review/myBuyList.do" style="font-size: 20px; text-decoration: none;">나의리뷰</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/review/myBuyList.do">리뷰쓰기</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/review/reviewList.do">내가 작성한 리뷰</a></li> 
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/memberUpdate.do" style="text-decoration: none;">설정</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberUpdate.do">회원정보수정</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberPasswdUpdate.do">비밀번호변경</a></li> 
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/sellerApplication.do">판매자 신청</a></li> 
						</ul>
					</li>
				</ul>
			</div>
		</nav>	
	</div>
	
	<br/>
	<hr size="1" style="color:#bfbfbf; noshade;">
</c:if>

<%-- 관리자 마이페이지 --%>
<c:if test="${!empty user_num && user_auth == 4}">
	<div align="left" style="padding-left: 15em;  ">
		<nav class="nav-right">
		
			<div class="nav-right-menu">
				<ul style=" display: inline-block; ">
					<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/myPage.do" style="font-size: 20px;text-decoration: none;">회원관리</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/myPage.do">관리자 정보</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberList.do">전체 회원 조회</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/sellerApplyList.do">판매자 신청내역 조회</a></li>
							
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="#" style="font-size: 20px;text-decoration: none;">커뮤니티 관리</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/houseBoard/list.do">사진게시판</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/event/eventList.do">이벤트</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/qnaList.do">고객센터</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/qnaServiceList.do">자주묻는 질문 내역조회</a></li>
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/qna/serviceBoardList.do">이메일 문의 내역조회</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="#" style="font-size: 20px;text-decoration: none;">기타</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/couponRegisterView.do">쿠폰 등록</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/aminCouponAllView.do">전체 쿠폰 조회</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="nav-right-menu">
				<ul style="display: inline-block;">
					<li class="navrightmenuli"><a class="navmenuitem" href="${pageContext.request.contextPath}/member/memberUpdate.do" style="font-size: 20px;text-decoration: none;">설정</a>
						<ul class="dropdownbar">
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberUpdate.do">관리자 정보수정</a></li>						
							<li class="navrightitemdropdown" style="text-decoration: none;"><a href="${pageContext.request.contextPath}/member/memberPasswdUpdate.do">비밀번호변경</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
	</div>
	
	<br/>
	<hr size="1" style="color:#bfbfbf; noshade;">
</c:if>

<%--정지회원, 탈퇴회원, 비회원 접근 불가 --%>
<c:if test="${!empty user_num && user_auth < 2}">
	<h1>정지회원 또는 탈퇴회원은 접근할 수 없습니다.</h1>
	<script type="text/javascript">
		$(function(){
			alert("정지회원 또는 탈퇴회원은 접근할 수 없습니다.");
			location.href="${pageContext.request.contextPath}/main/main.do";
		});
	</script>
</c:if>