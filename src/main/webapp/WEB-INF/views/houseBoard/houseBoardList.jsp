<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.card {
	border:none;
}
.count {
	margin-top:15px;
	margin-bottom:25px;
}
ul {
	margin-right:5px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script>
	$(function() {
		// 카드형 게시물 100글자 초과시 ... 처리
		$('.box').each(function(){
			var content = $(this).children('.content');
			var content_txt = content.text();
			var content_txt_short = content_txt.substring(0, 100) + "……";

			if(content_txt.length >= 100){
				content.html(content_txt_short);
            }
        });
	});
</script>


<div class="houseBoard-list">
	<div class="container">
	
		<!-- 카테고리 검색 -->
		<div class="category">
			<div class="row">
				<!-- 평수 -->
				<div style="display:inline-block;">
					<ul>
						<li>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<button class="form-control dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">평수</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="list.do?size=0&residence=${residence}&style=${style}&space=${space}">10평미만</a>
										<a class="dropdown-item" href="list.do?size=1&residence=${residence}&style=${style}&space=${space}">10평대</a>
										<a class="dropdown-item" href="list.do?size=2&residence=${residence}&style=${style}&space=${space}">20평대</a>
										<a class="dropdown-item" href="list.do?size=3&residence=${residence}&style=${style}&space=${space}">30평대</a>
										<a class="dropdown-item" href="list.do?size=4&residence=${residence}&style=${style}&space=${space}">40평대</a>
										<a class="dropdown-item" href="list.do?size=5&residence=${residence}&style=${style}&space=${space}">50평 이상</a>
										<a class="dropdown-item" href="list.do?size=''&residence=${residence}&style=${style}&space=${space}">취소</a>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- 텍스트 출력 -->
					<span><a style="font-size:15px; color:#F5A100; text-decoration:none;" href="#">${sizeOutput}</a></span>
				</div>
				
				<!-- 주거형태 -->
				<div style="display:inline-block;">
					<ul>
						<li>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<button class="form-control dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">주거형태</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="list.do?size=${size}&residence=0&style=${style}&space=${space}">원룸&amp;오피스텔</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=1&style=${style}&space=${space}">아파트</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=2&style=${style}&space=${space}">빌라&amp;연립</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=3&style=${style}&space=${space}">단독주택</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=4&style=${style}&space=${space}">사무공간</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=5&style=${style}&space=${space}">상업공간</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=''&style=${style}&space=${space}">취소</a>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- 텍스트 출력 -->
					<span><a style="font-size:15px; color:#F5A100; text-decoration:none;" href="#">${residenceOutput}</a></span>
				</div>
				
				<!-- 스타일 -->
				<div style="display:inline-block;">
					<ul>
						<li>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<button class="form-control dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">스타일</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=0&space=${space}">모던</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=1&space=${space}">북유럽</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=2&space=${space}">빈티지</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=3&space=${space}">내추럴</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=4&space=${space}">프로방스&amp;로맨틱</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=5&space=${space}">클래식&amp;앤틱</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=6&space=${space}">한국&amp;아시아</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=7&space=${space}">유니크</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=''&space=${space}">취소</a>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- 텍스트 출력 -->
					<span><a style="font-size:15px; color:#F5A100; text-decoration:none;" href="#">${styleOutput}</a></span>
				</div>
				
				<!-- 공간 -->
				<div style="display:inline-block;">
					<ul>
						<li>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<button class="form-control dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">공간</button>
									<div class="dropdown-menu">
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=0">원룸</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=1">거실</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=2">침실</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=3">주방</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=4">욕실</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=5">아이방</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=6">서재&amp;작업실</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=7">베란다</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=8">사무공간</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=9">상업공간</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=10">가구&amp;소품</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=11">현관</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=12">외관&amp;기타</a>
										<a class="dropdown-item" href="list.do?size=${size}&residence=${residence}&style=${style}&space=''">취소</a>
									</div>
								</div>
							</div>
						</li>
					</ul>
					<!-- 텍스트 출력 -->
					<span><a style="font-size:15px; color:#F5A100; text-decoration:none;" href="#">${spaceOutput}</a></span>
				</div>
				
				<ul>
					<li>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
							<button class="form-control" type="button" onclick="location.href='list.do'">초기화</button>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<br>


		<!-- 게시물 목록 -->
		<%-- 게시물이 없을 경우 --%>
		<c:if test="${count == 0}">
			<div class="result-display">
				등록된 게시물이 없습니다.
			</div>
		</c:if>
		<%-- 게시물이 있을 경우 --%>
		<c:if test="${count > 0}">
			<div class="count">
				총 <b style="color:#F5A100">${count}</b>개의 글
			</div>
			
		<%-- 반복문 시작 --%>
		<div class="container">
			<div class="row mb-5 mr-7">
			<c:forEach var="houseBoard" items="${list}">
				<div class="col-3">
					<div class="card" style="width:255px; height:450px; text-align:center;">
						<div>
							<div style="float:left; cursor:pointer;" onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}'">
								<%-- 회원 프로필 사진이 없는 경우 --%>
								<c:if test="${empty houseBoard.profile_filename}">
									<img src="${pageContext.request.contextPath }/resources/images/basic.png" style="width:33px; height:33px; margin-bottom:15px;" class="my-photo">
								</c:if>
								<%-- 회원 프로필 사진이 있는 경우 --%>
								<c:if test="${!empty houseBoard.profile_filename}">
									<img src="${pageContext.request.contextPath}/houseBoard/boardProfile.do?mem_num=${houseBoard.mem_num}" style="width:33px; height:33px; margin-bottom:15px;" class="my-photo">
								</c:if>
								<span style="font-size:16px;">&nbsp;${houseBoard.nickname}</span>
							</div>
						</div>
						<div class="imgTransition" style="cursor:pointer; overflow:hidden;" onclick="location.href='detail.do?house_num=${houseBoard.house_num}'">
							<%-- 사진파일이 없는 경우 --%>
							<c:if test="${empty houseBoard.thumbnail_filename}">
								<figure class="embed-responsive embed-responsive-1by1">
				            		<img class="card-img-top embed-responsive-item" id="thumbnail" src="${pageContext.request.contextPath}/resources/images/basic_house.png" style="width:100%; border-radius:1%;"/>
								</figure>
							</c:if>
							<%-- 사진파일이 있는 경우 --%>
							<c:if test="${!empty houseBoard.thumbnail_filename}">
				            	<figure class="embed-responsive embed-responsive-1by1">
				            		<img class="card-img-top embed-responsive-item" id="thumbnail" src="imageView.do?house_num=${houseBoard.house_num}" style="width:100%; border-radius:1%;"/>
				            	</figure>
				            </c:if>
			            	<div class="card-title" align="center">
								<h5><a href="detail.do?house_num=${houseBoard.house_num}">${houseBoard.house_title}</a></h5>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			
			</div>
		</div>
		</c:if>
		
		<!-- 페이지 처리 -->
		<div class="paging" align="center">	
			<span>${pagingHtml}</span>
		</div>
	</div>
</div>
