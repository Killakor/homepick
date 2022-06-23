<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class ="page-main">
	<h2 style="align:center;">프로필 사진</h2>
	<div class="mypage-info-main" style=" width:280px; height:430px;">
		<ul style=" margin:0; list-style:none; clear:both;" >
			<li style="text-align:center;">
				<%-- 이미지 등록 여부 --%>
				<c:if test="${empty user_photo}">
					<img src="${pageContext.request.contextPath}/resources/images/basic.png" width="120" height="120" class="my-photo">
				</c:if>
				<c:if test="${!empty user_photo}">
					<img src="${pageContext.request.contextPath}/member/photoView.do" width="120" height="120" class="my-photo">
				</c:if>
			</li>
		</ul>
		
		<br/>
		
		<h4 style="text-align:center;">닉네임 : ${member.nickname}</h4>
		<br/>
		<div class="align-center">
			<input class = "btn btn-outline-dark" type="button" value="수정" id="modify_btn" onclick="location.href='memberUpdate.do'">
		</div>
		<hr>
		
		<c:if test="${!empty user_num && (user_auth == 2 || user_auth == 3 || user_auth == 4)}">
			<div class="mypage-info" style="margin-bottom: 2em; padding-bottom : 1em; height: 100%;">
				<table style="border:1px dashed #b5b7ba; height: 100%; box-sizing: border-box;">
					<tr>
						<th style="border:1px dashed white;">
							<div style="cursor: pointer; width: 45px; height: 45px;" align="center" onclick="location.href='myScrap.do'">
								<img class="profile_btn" style="margin-top: 1em; margin-bottom: 2px; width: 40px; height: 40px;" src="${pageContext.request.contextPath}/resources/images/bookmark.svg">
									<p>스크랩북</p>
									<p style="margin-bottom: 2em;">${member.scrapbook_count}</p>
							</div>
						</th>
						
						<th style="border:1px dashed white;">
							<div  style="cursor: pointer; width: 45px; height: 45px;" align="center" onclick="location.href='myRecomm.do'">
								<img class="profile_btn" style="margin-top: 1em; margin-bottom: 2px; width: 40px; height: 40px;" src="${pageContext.request.contextPath}/resources/images/heart.svg">
									<p>좋아요</p>
									<p style="margin-bottom: 2em;">${member.recommend_count}</p>
							</div>
						</th>
						
						<th style="border:1px dashed white;">
							<div  style="cursor: pointer; width: 60px; height: 60px;" align="center" onclick="location.href='myCoupon.do'">
								<img class="profile_btn" style="margin-top: 1em; margin-bottom: 2px; width: 40px; height: 40px;" src="${pageContext.request.contextPath}/resources/images/coupon.png">
									<p>내 쿠폰</p>
									<p style="padding-bottom: 5em;">${member.coupon_count}</p>
							</div>
						</th>
					</tr>
				</table>
			</div>
		</c:if>
	</div>

</div>