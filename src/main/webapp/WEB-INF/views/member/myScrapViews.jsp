<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		// 카드형 게시물 110글자 초과시 ... 처리
		$('.box').each(function(){
			var content = $(this).children('.card-title');
			var content_txt = content.text();
			var content_txt_short = content_txt.substring(0,10)+"...";
			if(content_txt.length >= 10){
				content.html(content_txt_short);
	        }
	    });
		
		
	});
</script>
<br><div  style = "width:99%">
		<div style="float: right;">
		<div align = "center">
			<h2 style="text-align:center;">내가 스크랩 한 글 ( ${count} )</h2>
		</div>
		<%-- 카드시작 --%>
		<div class="row my-5 ml-5 mr-5" align="center">
		<%-- 등록된 게시물이 없는 경우 --%>
		<c:if test="${count == 0}">
			<div class="result-display">
				스크랩한 게시물이 없습니다.
			</div>
		</c:if>
		<%-- 등록된 게시물이 있는 경우 --%>
		<c:if test="${count > 0}">
			<!-- 반복문 시작 -->
			<c:forEach var="houseBoard" items="${myScrapBoardList}">
				<div class="col-3">
					<div class="card" style="height: 470px; width: 300px;">
			            <div class="card-header">
			            	<div style="float: left; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
				         		<%-- 회원 프로필 사진이 없는 경우 --%>
								<c:if test="${empty houseBoard.profile_filename }">
									<img src="${pageContext.request.contextPath }/resources/images/basic.png" width="33" height="33" class="my-photo">
								</c:if>
								<%-- 회원 프로필 사진이 있는 경우 --%>
								<c:if test="${!empty houseBoard.profile_filename }">
									<img src="${pageContext.request.contextPath }/member/boardPhotoView.do?mem_num=${houseBoard.mem_num}" width="33" height="33" class="my-photo">
								</c:if>
								  <b style="font-size: 17px">${ houseBoard.nickname }</b>
			            	</div>
			            </div>
			           
			            <div class="card-body">
				            <div align="center" style="cursor: pointer;"  onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}'">
					            <%-- 사진파일이 없는 경우 --%>
					            <c:if test="${ empty houseBoard.thumbnail_filename }">
					            	<img src="${pageContext.request.contextPath}/resources/images/basic.png" style="height: 270px; width: 175px;" />
					            </c:if>
					            <%-- 사진파일이 있는 경우 --%>
					            <c:if test="${!empty houseBoard.thumbnail_filename }">
					            	<img src="${pageContext.request.contextPath}/member/thumbnailPhotoView.do?house_num=${houseBoard.house_num}" style="height: 270px; width: 175px;" />
					            </c:if>
				            </div>
				           <div class="box">
				           		<br>   
				           	  <p class="card-title">${ houseBoard.house_title }</p>
				              <!-- 게시글 좋아요 및 북마크 -->
				              <div class="content">
				              		<ul>
				              			<li style="display: inline-block; float: left;">
				              				<!-- 추천 버튼 -->
											<button type="button" id="heart_btn" class="heart-btn" disabled="disabled">
												<c:if test="${houseBoard.heartCheckNum == 0}">
													<img class="heart" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/dislike.png">
												</c:if>
												<c:if test="${houseBoard.heartCheckNum == 1}">
													<img class="heart" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/like.png">
												</c:if>
											</button>
											<!-- 추천수 -->
											<span class="heartCount" style="display:inline-block;">${houseBoard.house_recom}</span>&nbsp;
				              			</li>
				              			<li style="display: inline-block; float: right;">
				              				<!-- 스크랩 버튼 -->
											<button type="button" id="scrap_btn" class="scrap-btn" disabled="disabled">
												<c:if test="${houseBoard.scrapCheckNum == 0}">
													<img class="scrap" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/scrapX.png">
												</c:if>
												<c:if test="${houseBoard.scrapCheckNum == 1}">
													<img class="scrap" style="margin: 5 10 5 10; width:25px; height:25px;" src="${pageContext.request.contextPath}/resources/images/scrapO.png">
												</c:if>
											</button>
											<!-- 스크랩수 -->
											<span class="scrapCount" style="display:inline-block;">${houseBoard.house_Scrap}</span>
				              			</li>
				              		</ul>
				              </div>
				           </div>
			           <br>
		            </div>
		          </div>
				</div>
			</c:forEach>
			<!-- 반복문 끝 -->
		</c:if>
		<!-- 카드 끝 -->
	</div>
	<div class="align-center">${pagingHtml}</div>
</div>
</div>
<!-- 중앙 내용 끝 --> 