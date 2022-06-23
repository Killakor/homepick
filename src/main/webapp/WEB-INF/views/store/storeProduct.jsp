<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type = "text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<style>
	div .container-fluid {
		color : #484F5C;
		font-family: 'Gowun Dodum', sans-serif;
		text-decoration: none;	
	}
	div .content {
		height : 500px;
	}
	ul {
		list-style : none;
	}
	a {
		color : inherit;
		text-decoration : none;
	}
	li {
		margin : 0px;
		padding : 0px;
	}
	img {
		border : 0;
	}
	.wrap {
		margin-top : 40px;
	}
	.row {
		display: -webkit-box;
	    display: -webkit-flex;
	    display: -moz-flex;
	    display: -ms-flexbox;
	    display: flex;
	    -webkit-flex-wrap: wrap;
	    -moz-flex-wrap: wrap;
	    -ms-flex-wrap: wrap;
	    flex-wrap: wrap;
	    box-sizing: border-box;
	    margin-right: -10px;
	    margin-left: -10px;
	}
	.side-bar {
		display : bolck;
	}
	.content {
	}
	.thumbnailImg_detail {
		float: left;
		width: 400px;
		position: relative;
		text-align: center;
		height: 400px;
		vertical-align: middle;
		margin : 50px;
	}
	.product_rgt {
		float: right;
		position: relative;
		height : 400px;
		width : 575.35px;
		margin : 50px;
	}
	.prod-title {
		font-size: 35px;
		line-height: 35px;
		color: #222;
		letter-spacing: -0.5px;
		word-wrap: break-word;
		word-break: break-all;
		margin-bottom : 20px;
	}
	#prod_price {
		font-size:25px;
	}
	#del_price {
		font-size : 20px;
	}
	#del_type {
		font-size : 20px;
		margin-bottom : 20px;
	}
	input#quan {
		width : 235px;
	}
	#btn_cart, #btn_order {
		margin-top : 20px;
		width : 190px;
		height : 70px;
	}
</style>
<div class = "container-fluid">
	<div>
		<h2><c:if test = "${storeDTO.prod_cate == 'furniture'}">가구</c:if>
		<c:if test = "${storeDTO.prod_cate == 'fabric'}">패브릭</c:if>
		<c:if test = "${storeDTO.prod_cate == 'lamp'}">조명</c:if>
		<c:if test = "${storeDTO.prod_cate == 'electonic'}">가전</c:if>
		<c:if test = "${storeDTO.prod_cate == 'kitchen'}">주방용품</c:if>
		<c:if test = "${storeDTO.prod_cate == 'deco'}">데코/취미</c:if>
		<c:if test = "${storeDTO.prod_cate == 'storage'}">수납/정리</c:if>
		<c:if test = "${storeDTO.prod_cate == 'daily_necessities'}">생활용품</c:if>
		<c:if test = "${storeDTO.prod_cate == 'necessities'}">생필품</c:if>
		<c:if test = "${storeDTO.prod_cate == 'tool_diy'}">공구/DIY</c:if>
		<c:if test = "${storeDTO.prod_cate == 'interior'}">인테리어시공</c:if>
		<c:if test = "${storeDTO.prod_cate == 'pet'}">반려동물</c:if>
		<c:if test = "${storeDTO.prod_cate == 'camping'}">캠핑용품</c:if>
		<c:if test = "${storeDTO.prod_cate == 'indoor'}">실내운동</c:if>
		<c:if test = "${storeDTO.prod_cate == 'baby_pro'}">유아/아동</c:if>
		<c:if test = "${storeDTO.prod_cate == 'rental'}">렌탈</c:if></h2>
	</div>
<div  class = "align-right">
	<c:if test = "${!empty user_num && user_num == storeDTO.mem_num}">
		<input class = "btn btn-outline-dark" type = "button" value = "수정" onclick="location.href='storeModify.do?prod_num=${storeDTO.prod_num}'">
	</c:if>
	<c:if test = "${storeDTO.mem_auth == 4 || user_num == storeDTO.mem_num}">
		<input class = "btn btn-outline-dark" type = "button" value = "삭제" id = "delete_btn">
		<script type = "text/javascript">
			var delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function() {
				var choice = confirm('삭제하시겠습니까?');
				if(choice) {
					location.replace('productDelete.do?prod_num=${storeDTO.prod_num}');
				}
			};
		</script>
	</c:if>
</div>
<div class = "content">
<form:form id = "order_form" action = "${pageContext.request.contextPath}/order/orderMain.do" modelAttribute = "storeDTO" method = "get">
	<form:hidden path = "prod_num" value = "${storeDTO.prod_num}" />
	<form:hidden path = "mem_num" value = "${user_num}" />
	<div class = "thumbnailImg_detail">
		<c:if test = "${!empty storeDTO.thumbnail_img}">
		<img src = "imageView.do?prod_num=${storeDTO.prod_num}" style = "width:400px; height:400px; max-width:400px; max-height:400px;"><br>
		</c:if>
		<c:if test = "${empty storeDTO.thumbnail_img}">
		<img src = "${pageContext.request.contextPath}/resources/images/gift.png" style = "width:400px; height:400px; max-width:400px; max-height:400px;"><br>
		</c:if>
	</div>
	<div class = "form-group product_rgt">
		<div class = "prod-title">
			${storeDTO.prod_name}<br>
		</div>
		<div>
			<span id = "prod_price"><fmt:formatNumber value = "${storeDTO.prod_price}" type = "number"/>원<br></span>
			<label class = "col-sm-3 col-form-label" for = "del_price">배송비</label>
			<span id = "del_price"> <fmt:formatNumber value = "${storeDTO.delive_price}" type = "number"/>원<br></span>
			<label class = "col-sm-3 col-form-label" for = "del_type">배송방법</label>
			<span id = "del_type">${storeDTO.delive_type}<br></span>
			<c:if test = "${!empty storeDTO.prod_option1}">
			<select class = "col-sm-8 custom-select" id = "product" name = "prod_option">
				<option value = "" id = "selec_option">${storeDTO.selec_product}</option>
				<option value = "${storeDTO.prod_option1}" id = "prod_option">${storeDTO.prod_option1}</option>
				<c:if test = "${!empty storeDTO.prod_option2}">
				<option value = "${storeDTO.prod_option2}" id = "prod_option">${storeDTO.prod_option2}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option3}">
				<option value = "${storeDTO.prod_option3}" id = "prod_option">${storeDTO.prod_option3}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option4}">
				<option value = "${storeDTO.prod_option4}" id = "prod_option">${storeDTO.prod_option4}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option5}">
				<option value = "${storeDTO.prod_option5}" id = "prod_option">${storeDTO.prod_option5}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option6}">
				<option value = "${storeDTO.prod_option6}" id = "prod_option">${storeDTO.prod_option6}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option7}">
				<option value = "${storeDTO.prod_option7}" id = "prod_option">${storeDTO.prod_option7}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option8}">
				<option value = "${storeDTO.prod_option8}" id = "prod_option">${storeDTO.prod_option8}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option9}">
				<option value = "${storeDTO.prod_option9}" id = "prod_option">${storeDTO.prod_option9}</option>
				</c:if>
				<c:if test = "${!empty storeDTO.prod_option10}">
				<option value = "${storeDTO.prod_option10}" id = "prod_option">${storeDTO.prod_option10}</option>
				</c:if>
			</select><br>
			</c:if>
			<c:if test = "${!empty storeDTO.prod_option1}">
			<script type = "text/javascript">
				$(document).ready(function() {
					$('select').val('');
					$('.quan').hide();
					$('#quan').val('1');
					$('.result').hide();
					
					$('#product').change(function() {
					  	var result = '';
						var price = 0;
						$('.quan').show();
						$('.result').show();
		
						var productOption = $('#product option:selected').text();
						var productPrice = $('#prod_price').text();
												
						if($('#product').val() != '') {
							result += productOption + " ";
							price += parseInt(productPrice);
						}
						
						if(price != 0) {
							$('#result').text(result);
							$('#price').text(price + '원');
							
							if(result != '') {
								$('#quan').show();
							}
						}
						
						if($('#product').val() == '') {
							$('#result').text('');
							$('#price').text('');
							$('.quan').hide();
							$('.result').hide();
							$('#quan').hide();
							$('#last_price').hide();
						}
						
						var last_price = quan * ${storeDTO.prod_price};
						var quan = $('#quan').val();
						
						$('#quan').change(function() {							
							var quantity = /^[0-9]/;
							
							if(!quantity.test(quan)) {
								$('#quan_result').text('숫자만 입력 가능합니다.');
								$('#quan').val('');
								$('#quan').focus();
								
							}
							
						});
						
						last_price = quan * ${storeDTO.prod_price};
						
					    var number = last_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						$('#last_price').text(number + '원');
					});					
				});
			</script>
			</c:if>
			<div>
				<div class = "result">
					<label class = "col-sm-3 col-form-label" for = "result">${storeDTO.selec_product}</label>
					<span id = "result"></span>
				</div>
				<div class = "quan">
					<label class = "col-sm-3 col-form-label " for = "quan">수량</label>
					<form:input path = "quan"/><br>
				</div>
				<span id = "quan_result"></span>
			</div>
			<div class = "align-center" style = "margin-left : 120px;">
				<span id = "last_price"></span>
			</div>
		</div>
		<div>
			<c:if test = "${!empty user_num}">
			<input class = "btn btn-outline-dark" type = "button" id = "btn_cart" value = "장바구니">
			</c:if>
			<form:button class = "btn btn-outline-dark" id = "btn_order">구매하기</form:button>
		</div>
	</div>
	<script type = "text/javascript">
		$(document).ready(function() {
			$('#quan').val('1');
			
			$('#quan').change(function() {							
				var last_price = 0;
				var quan = $('#quan').val();
				var quantity = /^[0-9]/;
				
				if(!quantity.test(quan)) {
					$('#quan_result').text('숫자만 입력 가능합니다.');
					$('#quan').val('');
					$('#quan').focus();
				}else {
					$('#quan_result').hide();
				}
				
				last_price = quan * ${storeDTO.prod_price};
							
				var number = last_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$('#last_price').text(number + '원');
				
			});
		});
	</script>
	<script type = "text/javascript">
		// 장바구니 클릭시
		$('#btn_cart').click(function() {
			var quan = $('#quan').val();
			if(quan > ${storeDTO.prod_quan}) {
				alert('재고가 부족합니다.');
				return false;
			}
			if($('select').val() != '') {
				if(quan > 0) {
					$.ajax({
						type : 'post',
						url : '${pageContext.request.contextPath}/cart/cartInsert.do',
						data : {
							prod_num : ${storeDTO.prod_num},
							user_num : $('#mem_num').val(),
							cart_quan : quan
						},
						dataType : 'json',
						cache : false,
						timeout : 30000,
						success : function(param) {
							if(param.result == 'add_success') {
								var check = confirm('카트에 등록 되었습니다. 카트를 확인해보시겠습니까?');
								if(check) {
									location.assign('${pageContext.request.contextPath}/cart/cartList.do');					
								}
							}else if(param.result == 'cart_update') {
								var check = confirm('카트 수량이 변경 되었습니다. 카트를 확인해보시겠습니까?');
								if(check) {
									location.assign('${pageContext.request.contextPath}/cart/cartList.do');					
								}
							}else {
								alert('장바구니 오류!');
							}
						},
						error : function() {
							alert('네트워크 오류!');
						}
						
					});
				}else {
					alert('수량을 입력해주세요!');
					return false;
				}
			}else{
				alert('${storeDTO.selec_product}를 선택해주세요!');
				return false;
			}
		});
		
		$('#btn_order').click(function() {
			var quan = $('#quan').val();
			var price = $('#last_price').text();

			if(price == 'NaN원') {
				alert('숫자만 입력 가능합니다!');
				return false;
			}
			
			if(quan > ${storeDTO.prod_quan}) {
				alert('재고가 부족합니다.');
				return false;
			}
		});
	</script>
</form:form>
</div>
<hr style = "height:2px;color:solid-gray;">
	<div class = "align-center">
		${storeDTO.prod_content}
	</div>
</div>
<!-- 리뷰부분 시작 -->
<!-- 리뷰 총합 -->
<c:if test="${rev_count>0}">
<div class="review-star mt-5">
	<div class="container" style="border:1px solid gray">
	<div class="star-name mt-2 mb-3" style="font-size:20px; text-align:center;">평균평점 : ${rev_grade} <div style="color:red;"><c:forEach var="var" items="${ratingOptions}" varStatus="status" begin="1" end="${rev_grade_round}">★</c:forEach></div>
	<hr>리뷰개수 : ${rev_count} </div>
	</div>
</div>
</c:if>
<c:if test="${rev_count==0}">
<div class="review-star mt-5">
	<div class="container" style="border:1px solid gray">
	<div class="star-name mt-2 mb-3" style="font-size:20px; text-align:center;">
	<hr>리뷰개수 : ${rev_count} </div>
	</div>
</div>
</c:if>

<!-- 리뷰 보기 -->
<div class="review-list mt-5">
	<div class="container">
		<c:if test="${rev_count==0}">
			<div class="reviewlist" style="border:1px solid;">작성한 리뷰가 없습니다.</div>
		</c:if>
		<c:if test="${rev_count>0}">
			<c:forEach var="reviewDTO" items="${reviewDTO}" varStatus="n">
			<div class="reviewList" style="text-align:center;">리뷰 리스트</div>
			<hr>
			<div class="rev-content">
			<div class="mem_name" style="font-size:21px;">ㅣ${reviewDTO.mem_name}</div>
			<div class="rev_grade"><c:forEach var="var" items="${ratingOptions}" varStatus="status" begin="1" end="${reviewDTO.rev_grade}">★</c:forEach></div>
			<br><div class="rev_content">${reviewDTO.rev_content}</div>
			<div class="rev_reg_date" style="text-align:right">작성일 : ${reviewDTO.rev_reg_date}</div>
			
			<c:if test="${!empty reviewDTO.rev_filename}">
			<div class="file-item mt-5 mb-5" style="text-align:center">
			<img src="reviewImageView.do?rev_num=${reviewDTO.rev_num}" style="max-width:px">
			</div>
			</c:if>
			</div>
			<hr>
			</c:forEach>
		</c:if>
	</div>
</div>
<!-- 리뷰부분 끝 -->