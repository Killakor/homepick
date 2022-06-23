<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<script type="text/javascript">
	//카드형 게시물 110글자 초과시 ... 처리
	$(document).ready(function(){
		
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
		<div  style="float: right;">
		<div align = "center">
			<h3 style="text-align:center;">내가 쓴 글 ( ${count} )</h3>
		</div>
		<%-- 카드시작 --%>
		<div class="row my-5 ml-5 mr-5" align="center">
		<%-- 등록된 게시물이 없는 경우 --%>
		<c:if test="${count == 0}">
			<div class="result-display">
				등록된 게시물이 없습니다.
			</div>
		</c:if>
		<%-- 등록된 게시물이 있는 경우 --%>
		<c:if test="${count > 0}">
			<!-- 반복문 시작 -->
			<c:forEach var="houseBoard" items="${list}">
				<div class="col-3" >
					<div class="card" style="height: 470px; width: 330px;">
			            <div class="card-header">
			            	<div style="float: left; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
				         		<%-- 회원 프로필 사진이 없는 경우 --%>
								<c:if test="${empty member.profile_filename }">
									<img src="${pageContext.request.contextPath }/resources/images/basic.png" width="33" height="33" class="my-photo">
								</c:if>
								<%-- 회원 프로필 사진이 있는 경우 --%>
								<c:if test="${!empty member.profile_filename }">
									<img src="${pageContext.request.contextPath }/member/boardPhotoView.do?mem_num=${houseBoard.mem_num}" width="33" height="33" class="my-photo">
								</c:if>
								  <b style="font-size: 17px">${ member.nickname }</b>
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
				          
				              <div class="content">
				              		<h5 class="card-title"><a href="${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}" class="btn btn-outline-dark">${ houseBoard.house_title }</a></h5>
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