<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script type = "text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	h4 {
		margin : 10px;
	}
	hr {
		margin-bottom : 5px;
		margin-top : 5px;
	}
	#kakao_btn {
		background: url("${pageContext.request.contextPath}/resources/images/kakao_pay_img.png") no-repeat;
		border: none;
        width: 121px;
        height: 50px;
        cursor: pointer;
	}
</style>
<h2>주문/결제</h2>
<div class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: sans-serif;">
	<h4 class = "order">주문자 정보</h4>
	<div>
		<ul>
			<li>
				<label class = "col-sm-3 col-form-label">이름</label>
				<input class = "col-sm-4" type = "text" id = "name" name = "name" value = "${memberDTO.mem_name}">
				<hr>
			</li>
			<li>
				<label class = "col-sm-3 col-form-label">이메일</label>
				<input class = "col-sm-4" type = "email" id = "email" name = "email" value = "${memberDTO.email}">
				<hr>
			</li>
			<li>
				<label class = "col-sm-3 col-form-label">연락처</label>
				<input class = "col-sm-4" type = "text" id = "phone" name = "phone" value = "${memberDTO.phone}">
			</li>
		</ul>
	</div>
</div>
<br>
<form:form id = "orderInsert" action = "orderInsert.do" modelAttribute = "orderDTO">
<div class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: sans-serif;">
	<h4 class = "order">배송지</h4>
	<input type = "hidden" id = "mem_num" name = "mem_num" value = "${memberDTO.mem_num}">
	<ul>
		<li>
			<label class = "col-sm-3 col-form-label">받는 사람</label>
			<input class = "col-sm-4" type = "text" name = "receiver_name" id = "receiver_name">&nbsp;&nbsp;
			<input class = "btn btn-outline-dark" type = "button" id = "equal" value = "위와 동일하게 채우기">
			<hr>
		</li>
		<li>
			<label class = "col-sm-3 col-form-label">연락처</label>
			<input class = "col-sm-4" type = "text" name = "receiver_phone" id = "receiver_phone">
			<hr>	
		</li>
		<li>
			<label class = "col-sm-3 col-form-label">이메일</label>
			<input class = "col-sm-4" type = "email" name = "receiver_email" id = "receiver_email">
			<hr>
		</li>
		<li>
			<label class = "col-sm-3 col-form-label">주소</label>
			<input class = "col-sm-4" type = "text" name = "order_zipcode" id = "order_zipcode" value = "${memberDTO.zipcode}">&nbsp;&nbsp;
			<input style = "margin-bottom : 10px;" class = "btn btn-outline-dark" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
		</li>
		<li>
			<label class = "col-sm-3 col-form-label"></label>
			<input style = "margin-bottom : 10px;" class = "col-sm-7" type = "text" name = "order_address1" id = "order_address1" value = "${memberDTO.address1}">
		</li>
		<li>
			<label class = "col-sm-3 col-form-label"></label>
			<input class = "col-sm-7" type = "text" name = "order_address2" id = "order_address2" value = "${memberDTO.address2}">
		</li>
	</ul>
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	<!-- 카카오 주소 api 호출 -->
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("order_address1").value = extraAddr;
	                
	                } else {
	                    document.getElementById("order_address1").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById("order_zipcode").value = data.zonecode;
	                document.getElementById("order_address1").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("order_address2").focus();
	            }
	        }).open();
	    }
  	</script>
  	<!-- 주문자와 수령자의 정보 동기화 버튼 작업 -->
	<script type = "text/javascript">
		$(document).ready(function() {
			$('#receiver_name').val('');		// 페이지가 새로고침 되면 수령자 이름 초기화
			$('#receiver_phone').val('');		// 페이지가 새로고침 되면 수령자 연락처 초기화
			$('#receiver_email').val('');		// 페이지가 새로고침 되면 수령자 이메일 초기화
			
			$('#equal').click(function() {	// 위와 동일하게 채우기 버튼을 클릭시
				$('#receiver_name').val($('#name').val());		// 수령자 이름에 DB에 저장된 이름 호출
				$('#receiver_phone').val($('#phone').val());	// 수령자 연락처에 DB에 저장된 연락처 호출
				$('#receiver_email').val($('#email').val());	// 수령자 이메일에 DB에 저장된 이메일 호출
			});
			
			var price = ${storeDTO.prod_price};		// DB에 저장된 상품의 가격을 price 변수에 저장
			var delive = ${storeDTO.delive_price};	// DB에 저장된 배송비를 delive 변수에 저장
			var quan = ${storeDTO.quan};				// DB에 저장한 상품 갯수를 quan 변수에 저장
			var won = '원';
			
			var final_price = (price * quan) + delive;	// 최종 결제 금액 = 가격 * 갯수 + 배송비
			var number = final_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#final_price').val(final_price);			// 최종 결제 금액을 final_price 값에 저장 
			$('#final_price_li').append(number);	// 최종 결제 금액을 출력
			$('#final_price_li').append(won);			// 최종 결제 금액 + 원 출력
		});
	</script>
</div>
<br>
<div class = "container-fluid" style = "width:700px; border: 1px solid #d2f1f7; font-family: sans-serif;">
	<h4 class = "order">상품 정보</h4>
	<table class = "table table-bordered">
		<tr>
			<th scope = "col" class = "align-center">상품 정보</th>
			<th scope = "col" class = "align-center">수량</th>
			<th scope = "col" class = "align-center">가격</th>
			<th scope = "col" class = "align-center">배송</th>
			<th scope = "col" class = "align-center">결제 금액</th>
		</tr>
		<tr>
			<td>
				<span style = "font-weight : bold;">[${storeDTO.buis_name}]</span>
				<input type = "hidden" id = "buis_name" name = "buis_name" value = "${storeDTO.buis_name}">
				${storeDTO.prod_name}<br>
				<input type = "hidden" id = "prod_name" name = "prod_name" value = "${storeDTO.prod_name}">		
				<c:if test = "${storeDTO.commit_option != null}">옵션 : </c:if>
				${storeDTO.commit_option}
				<input type = "hidden" id = "commit_option" name = "commit_option" value = "${storeDTO.commit_option}">
			</td>
			<td class = "align-center">
				${storeDTO.quan}개
				<input type = "hidden" id = "quan" name = "quan" value = "${storeDTO.quan}">	
			</td>
			<td class = "align-center">
				<fmt:formatNumber pattern="###,###,###" value="${storeDTO.prod_price}"/>원
				<input type = "hidden" id = "prod_price" name = "prod_price" value = "${storeDTO.prod_price}">
			</td>
			<td class = "align-center">
				${storeDTO.delive_type}
				<input type = "hidden" id = "delive_type" name = "delive_type" value = "${storeDTO.delive_type}">
				<br>
				<fmt:formatNumber pattern="###,###,###" value="${storeDTO.delive_price}"/>원
				<input type = "hidden" id = "delive_price" name = "delive_price" value = "${storeDTO.delive_price}">
			</td>
			<td class = "align-center" id = "final_price_li">
				<input type = "hidden" id = "final_price" name = "final_price" value = "final_price">
			</td>
		</tr>
		<tr>
			<td class = "align-center" colspan = "5">
				<input class = "btn btn-outline-dark" type = "button" value = "" id = "kakao_btn">
			</td>
		</tr>
	</table>
</div>
	<input type = "hidden" id = "prod_num" name = "prod_num" value = "${storeDTO.prod_num}">
	<script type="text/javascript">
		$(document).ready(function() {
				var receiver_name = $('#receiver_name').val();		// 주문 DB에 들어갈 수령자 이름을 변수에 저장
				var receiver_phone = $('#receiver_phone').val();	// 주문 DB에 들어갈 수령자 연락처를 변수에 저장
				var order_zipcode = $('#order_zipcode').val();		// 주문 DB에 들어갈 수령자 우편번호를 변수에 저장
				var order_address1 = $('#order_address1').val();	// 주문 DB에 들어갈 주소를 변수에 저장
				var order_address2 = $('#order_address2').val();	// 주문 DB에 들어갈 나머지 주소를 변수에 저장
				var buis_name = $('#buis_name').val();				// 주문 DB에 들어갈 판매자명을 변수에 저장
				var prod_name = $('#prod_name').val();				// 주문 DB에 들어갈 상품명을 변수에 저장
				var quan = $('#quan').val();						// 주문 DB에 들어갈 수량을 변수에 저장
				var commit_option = $('#commit_option').val();		// 주문 DB에 들어갈 선택한 옵션을 변수에 저장
				var final_price = $('#final_price').val();			// 주문 DB에 들어갈 최종 결제 금액을 변수에 저장
				var prod_num = $('#prod_num').val();				// 주문 DB에 들어갈 상품 번호를 변수에 저장
				var receiver_email = $('#receiver_email').val();	// 주문 DB에 들어갈 수령자 이메일을 변수에 저장
				var mem_num = $('#mem_num').val();					// 주문 DB에 들어갈 회원 번호를 변수에 저장
				
			// 카카오페이 버튼을 클릭시
			$('#kakao_btn').click(function() {
				
				// 유효성 체크
				if($('#name').val().trim() == '') {
					alert('주문자 이름을 입력하세요!');
					$('#name').focus();
					$('#name').val('');
					return false;
				}
				if($('#email').val().trim() == '') {
					alert('주문자 이메일을 입력하세요!');
					$('#email').focus();
					$('#email').val('');
					return false;
				}
				if($('#phone').val().trim() == '') {
					alert('주문자 전화번호를 입력하세요!');
					$('#phone').focus();
					$('#phone').val('');
					return false;
				}
				if($('#receiver_name').val().trim() == '') {
					alert('수령자 이름을 입력하세요!');
					$('#receiver_name').focus();
					$('#receiver_name').val('');
					return false;
				}
				if($('#receiver_phone').val().trim() == '') {
					alert('수령자 전화번호를 입력하세요!');
					$('#receiver_phone').focus();
					$('#receiver_phone').val('');
					return false;
				}
				if($('#receiver_email').val().trim() == '') {
					alert('수령자 이메일을 입력하세요!');
					$('#receiver_email').focus();
					$('#receiver_email').val('');
					return false;
				}
				if($('#order_zipcode').val().trim() == '') {
					alert('우편번호를 입력하세요!');
					$('#order_zipcode').focus();
					$('#order_zipcode').val('');
					return false;
				}
				if($('#order_address1').val().trim() == '') {
					alert('주소를 입력하세요!');
					$('#order_address1').focus();
					$('#order_address1').val('');
					return false;
				}
				if($('#order_address2').val().trim() == '') {
					alert('상세 주소를 입력하세요!');
					$('#order_address2').focus();
					$('#order_address2').val('');
					return false;
				}
				
				// ajax 통신
				$.ajax({
					url: '${pageContext.request.contextPath}/order/kakao.do',
					data : {
						receiver_name : receiver_name,
						receiver_phone : receiver_phone,
						order_zipcode : order_zipcode,
						order_address1 : order_address1,
						order_address2 : order_address2,
						buis_name : buis_name,
						prod_name : prod_name,
						quan : quan,
						commit_option : commit_option,
						final_price : final_price
					},
					dataType: 'json',
					success: function(param) {
						var box = param.next_redirect_pc_url;
						window.open(box, 'about:blank', 'content', 'width=300, height=300');		// 성공시 카카오페이 결제 페이지 호출
							
						var receiver_name = $('#receiver_name').val();		// 주문 DB에 들어갈 수령자 이름을 변수에 저장
						var receiver_phone = $('#receiver_phone').val();	// 주문 DB에 들어갈 수령자 연락처를 변수에 저장
						var order_zipcode = $('#order_zipcode').val();		// 주문 DB에 들어갈 수령자 우편번호를 변수에 저장
						var order_address1 = $('#order_address1').val();	// 주문 DB에 들어갈 주소를 변수에 저장
						var order_address2 = $('#order_address2').val();	// 주문 DB에 들어갈 나머지 주소를 변수에 저장
						var buis_name = $('#buis_name').val();				// 주문 DB에 들어갈 판매자명을 변수에 저장
						var prod_name = $('#prod_name').val();				// 주문 DB에 들어갈 상품명을 변수에 저장
						var quan = $('#quan').val();						// 주문 DB에 들어갈 수량을 변수에 저장
						var commit_option = $('#commit_option').val();		// 주문 DB에 들어갈 선택한 옵션을 변수에 저장
						var final_price = $('#final_price').val();			// 주문 DB에 들어갈 최종 결제 금액을 변수에 저장
						var prod_num = $('#prod_num').val();				// 주문 DB에 들어갈 상품 번호를 변수에 저장
						var receiver_email = $('#receiver_email').val();	// 주문 DB에 들어갈 수령자 이메일을 변수에 저장
						var mem_num = $('#mem_num').val();					// 주문 DB에 들어갈 회원 번호를 변수에 저장
						
						$.ajax({
							url: '${pageContext.request.contextPath}/order/orderInsert.do',
							data : {
								receiver_name : receiver_name,
								receiver_phone : receiver_phone,
								receiver_email : receiver_email,
								order_zipcode : order_zipcode,
								order_address1 : order_address1,
								order_address2 : order_address2,
								buis_name : buis_name,
								prod_name : prod_name,
								pay_quan : quan,
								prod_opt : commit_option,
								pay_price : final_price,
								mem_num : mem_num,
								prod_num : prod_num
							},
							dataType: 'json',
							success: function(param) {
								alert('결제에 성공하였습니다.');
								location.href=('${pageContext.request.contextPath}/order/orderComplete.do');
							},
							error: function(request,status,error) { // 에러메시지 반환
								alert("🤯 code = " + request.status + " message = " + request.responseText + " error = " + error);
							}
						});
					},
					error: function(request,status,error) { // 에러메시지 반환
						alert("🤯 code = " + request.status + " message = " + request.responseText + " error = " + error);
					}
				});
			});
		});
	</script>
</form:form>