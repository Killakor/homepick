<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
.main {
	display: flex;
	justify-content: center;
	align-item: center;
}
.main-container {
	display: grid;
	grid-template-columns: repeat(4, 5fr);
	grid-auto-rows: minmax(180px, auto);
	grid-row-gap: 4 rem;
	grid-column-gap: 2rem;
}
.main-item:nth-child(1) {
	grid-column: 1/4;
	grid-row: 1/4;
}
.main-item:nth-child(2) {
	grid-column: 4/5;
	grid-row: 1/4;
}
.main-item:nth-child(3) {
	grid-column: 1/5;
	grid-row: 3/5;
}
.main-item:nth-child(4) {
	grid-column: 1/4;
	grid-row: 5/7;
}
.main-item:nth-child(5) {
	grid-column: 4/5;
	grid-row: 5/7;
}
.main-item:nth-child(6) {
	grid-column: 1/5;
	grid-row: 7/9;
}
.main-item:nth-child(7) {
	grid-column: 1/5;
	grid-row: 9/11;
}
.main-story{
	display:flex;
	flex-direction:column;
	align-items: stretch;
}
.main-story-link {
	height: 90px;
	width:397px;
	border : 1px solid white;
	background-color:rgb(250,250,250);
	border-radius:10px;
}
.link1:hover span{
	color: red;
}
.link2:hover span{
	color: red;
}
.link3:hover span{
	color: red;
}
.description{
	padding : 25px 0px 0px 25px;
	font-weight : 700;
	font-color: gray;
	font-size: 9px;
}
.title{
	padding : 10px 0px 0px 25px;
	font-weight : 700;
	font-color: gray;
	font-size: 13px;
}
.rankfeedli{
	display:inline;
}
.rankfeedul{
	text-align:center;
}
.rankfeed{
	position:sticky;
}
.rankitemul{
	float::inline-block ;
	display:flex;
	text-align:center;
	width: 300px;
	height: 280px;
	background-color:black;
}
.rankcontent{
	width: 1083px;
	height : 150px;
	text-align : center;
}

/* 베스트아이템 */
.bestitemli {
	display: flex;
	flex-direction: column;
	margin-bottom: 2rem;
}
.bestimage {
	height: 0;
	padding-bottom: 60%;
	background-color: white;
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
}
.bestimage img {
	display: none;
}
.bestdesc {
	flex: 1 1 auto;
	padding: 5px;
	background: white;
}

@media (min-width: 600px) {
	.bestitemul {
		display: flex;
		flex-wrap: wrap;
		margin: 0 -1rem;
	}
	.bestitemli {
		width: 50%;
		padding: 0 1rem;
	}
}

@media (min-width: 1200px) {
	.bestitemli {
		width: 25%;
	}
	.carousel slide{
 	visibility : hidden ;  
	}
}

/* 인기사진 */
.popularli {
	display: flex;
	flex-direction: column;
	margin-bottom: 2rem;
}
.popularimage {
	height: 0;
	padding-bottom: 60%;
	background-color: white;
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
}
.popularimage img {
	display: none;
}
.populardesc {
	flex: 1 1 auto;
	padding: 5px;
	background: white;
}

@media (min-width: 600px) {
	.popularul {
		display: flex;
		flex-wrap: wrap;
		margin: 0 -1rem;
	}
	.popularli {
		width: 50%;
		padding: 0 1rem;
	}
}

@media (min-width: 600px) {
	.categoryul {
		display: flex;
		flex-wrap: wrap;
		margin: 0 -1rem;
	}
	.categoryli {
		width: 50%;
		padding: 0 -1rem;
	}
}

@media (min-width: 1200px) {
	.popularli {
		width: 25%;
	}
}

/* 홈픽 스토리 */
.storyli {
	display: flex;
	flex-direction: column;
	margin-bottom: 2rem;
}
.storyimage {
	height: 0;
	padding-bottom: 60%;
	background-color: white;
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
}
.storyimage img {
	display: none;
}
.storydesc {
	flex: 1 1 auto;
	padding: 5px;
	background: white;
}
.storydesc p {
	font-size: 12px;
}
@media (min-width: 600px) {
	.storyul {
		display: flex;
		flex-wrap: wrap;
		margin: 0 -1rem;
	}
	.storyli {
		width: 50%;
		padding: 0 1rem;
	}
}

@media (min-width: 1200px) {
	.storyli {
		width: 33.33333%;
	}
}
.cateul {
	position: relative;
	margin-top: 120px;
	display: flex;
	align-items: center;
	justify-content: center;
}
.cateli img {
	width: 240px;
	margin: 0 auto;
}
.cateul2 {
	display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
}
.cateli2 img {
	width: 120px;
	margin: 0 auto;
}
</style>

<script type="text/javascript">
	$(function(){
		//메뉴 클릭시 li 추가
		$('.rankfeedli').click(function(){
			var activeTab = $(this).attr('value');
			$('li').css('text-color','orange');
			$.getJSON("/main/main.do"+"?activeTab"+activeTab, function(data){
				var str= "";
				$(data).each(function(){
					console.log(data);
					str += "<li"
				})
			})
		});
		
		$('.mainimgwrapper').hover(function() {
			$("#mainimg").css("transform", "scale(1.2)"),$("#mainimgbutton").css("color","blue");
		}, function(){
			$("#mainimg").css("transform", "scale(1.1)"),$("#mainimgbutton").css("color","");
		});
	});
</script>


<div class="main">
	<div class="main-container">
		<div class="main-item">
			<div class="mainimgwrapper" style="height:560px; width:auto; ">
				<div class="main-img" id="main-img" style="overflow: hidden; cursor: pointer; border-radius:30px; max-width:1000px;" >
					<img src="${pageContext.request.contextPath}/resources/images/mainimg.png" id="mainimg" style="transition: all 0.2s linear;" onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=3'">
				</div>
				<div class="mainimgtext" style="position: relative; bottom:120px; cursor: pointer;">
					<p style="font-size:40px; padding-left: 55px; font-family: 'Gowun Dodum', sans-serif; font-weight:bolder; color:white;">내추럴한 신혼 인테리어</p>
					<p style="font-size:16px; padding-left: 55px; font-family: 'Gowun Dodum', sans-serif; color:white;">변천사 과정 단독취재!!</p>
				</div>
			</div>
		</div>
		
		<div class="main-item">
			<!-- 롤링배너 -->
			<div id="carouselExampleControls" class="carousel slide" style="cursor: pointer;" data-ride="carousel">
				<div class="carousel-inner" style="border-radius:30px;">
					<div class="carousel-item active">
						<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/event1.jpg" alt="First slide" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=9'" style="height: 540px;">
					</div>
				    <div class="carousel-item">
			      		<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/event2.jpg" alt="Second slide" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=4'" style="height: 540px;">
				    </div>
				    <div class="carousel-item">
			     		<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/event3.jpg" alt="Third slide" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=8'" style="height: 540px;">
				    </div>
				    <div class="carousel-item">
				    	<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/event4.jpg" alt="Four slide" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=7'" style="height: 540px;">
				    </div>
				</div>
					<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					 	<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
				    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
				    	<span class="sr-only">Next</span>
					</a>
			</div>
		</div>

		<!-- Sub GNB -->
		<div class="main-item my-5" style="text-align :center; font-size:20px; font-weight:bold;"><br>
			<section class="popular" style="cursor: pointer;">
			<ul class="cateul">
				<li class="cateli"><a><img src ="${pageContext.request.contextPath}/resources/images/onclick1.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do'"></a></li>
				<li class="cateli"><a><img src ="${pageContext.request.contextPath}/resources/images/onclick2.png" onclick="location.href='${pageContext.request.contextPath}/houseBoard/list.do'"></a></li>
				<li class="cateli"><a><img src ="${pageContext.request.contextPath}/resources/images/onclick3.png" onclick="location.href='${pageContext.request.contextPath}/houseBoard/list.do'"></a></li>
				<li class="cateli"><a><img src ="${pageContext.request.contextPath}/resources/images/onclick4.png" onclick="location.href='${pageContext.request.contextPath}/event/eventDetail.do?event_num=6'"></a></li>
				<li class="cateli"><a><img src ="${pageContext.request.contextPath}/resources/images/onclick5.png" onclick="location.href='${pageContext.request.contextPath}/qna/qnaList.do'"></a></li>
			</ul>
			</section>
		</div>
			
		<!-- 홈픽 스토리 - 1)최신순 리스트 4개 -->
		<div class="main-item"style="text-align :center;">
			<p class="mb-2" style="text-align:left; font-size:20px; font-weight:bold;">홈픽 스토리</p>
			<section class="everydaystory">
				<ul class="storyul">
					<%-- 집들이 반복문 --%>
			  	  	<c:forEach var="houseBoard" items="${HList}">
						<div align="center" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/houseBoard/detail.do?house_num=${houseBoard.house_num}'">
							<li class="mx-2">
								<figure class="storyimage" style="height: 200px; width :250px;">
									<%-- 집들이 썸네일 사진이 없는 경우 --%>
									<c:if test="${empty houseBoard.thumbnail_filename}">
						            	<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/basic.png" style="border-radius:1%; width:300px; height:206px;"/>
						            </c:if>
						            <%-- 집들이 썸네일 사진이 있는 경우 --%>
						            <c:if test="${!empty houseBoard.thumbnail_filename}">
							            <img class="d-block w-100" src="${pageContext.request.contextPath}/houseBoard/imageView.do?house_num=${houseBoard.house_num}" style="border-radius:1% width:300px; height:206px;" >
						            </c:if>
								</figure>
									
								<div class="storydesc">
									<p>${houseBoard.house_title}</p>
								</div>
							</li>
			       		</div>
			       	</c:forEach>
				</ul>
			</section>
		</div>
		<!-- 홈픽 스토리 - 2) 바로가기 버튼 -->
		<div class="main-item" id="main-item-link">
			<br/>
			<div class="main-story">
				<div class="main-story-link link1" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/houseBoard/list.do';">
					<div class="description">예쁜집 구경하기</div>
					<div class="title">
						<span class="text">집들이 바로가기 ></span>
					</div>
				</div> 
				<div class="main-story-link link2" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do';">
					<div class="description">새로운 특가상품</div>
					<div class="title">
						<span class="text">스토어 바로가기 ></span>
					</div>
				</div>
				<div class="main-story-link link3" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/event/eventList.do';">
					<div class="description">홈픽은 처음이세요?</div>
					<div class="title">
						<span class="text">이벤트 바로가기</span>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 카테고리별 상품 찾기 -->
		<div class="main-item my-5">
			<p class="mb-2" style="text-align:left; font-size:20px; font-weight:bold;">카테고리별 상품 찾기</p>
			<ul class="cateul2" style="margin-top: 40px; text-align: center;">
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category1.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=furniture'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category2.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=fabric'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category3.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=lamp'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category4.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=electronic'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category5.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=kitchen'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category6.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=deco'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category7.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=storage'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category8.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=daily_necessities'"></a></li>
				<li class="cateli2"><a><img src ="${pageContext.request.contextPath}/resources/images/category9.png" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do?prod_cate=necessities'"></a></li>
			</ul>
		</div>
		
		<!-- 오늘의 딜 -->
		<div class="main-item mt-5" style="text-align :center;">
			<p class="mb-2" style="text-align:left; font-size:20px; font-weight:bold;">오늘의 딜</p>
			<section class="bestitem">
				<ul class="bestitemul">
				
			  	  	<c:forEach var="store" items="${SList}">
			  	  		<div align="center" style="cursor: pointer;"  onclick="location.href='${pageContext.request.contextPath}/store/storeDetail.do?prod_num=${store.prod_num}'">
							<li class="mx-3">
								<figure class="bestimage p-3" style="height: 300px; width : 280px;">
									<%-- 상품 썸네일이 없는 경우 --%>
									<c:if test="${empty store.thumbnail_filename}">
					            		<img class="d-block w-100" src="${pageContext.request.contextPath}/resources/images/gift.png" style="border-radius:1%; width:280; height:280px;"/>
					            	</c:if>
					            	<%-- 상품 썸네일이 있는 경우 --%>
					            	<c:if test="${!empty store.thumbnail_filename}">
						            	<img class="d-block w-100" src="${pageContext.request.contextPath}/store/imageView.do?prod_num=${store.prod_num}" style="border-radius:1%; width:280px; height: 280px;" >
					            	</c:if>
								</figure>
								
								<div class="bestdesc">
									${store.prod_name}<br>
									<span id = "prod_price" style="font-size: 20px; font-weight: bold;"><fmt:formatNumber value = "${store.prod_price}" type = "number"/>원<br></span>
								</div>
							</li>
						</div>
					</c:forEach>
				</ul>
			</section>		
		</div>
	</div>
</div>
