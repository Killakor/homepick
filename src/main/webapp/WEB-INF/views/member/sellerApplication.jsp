<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type ="text/javascript">
	$(document).ready(function() {
		
		var applicationCheck = "${count}";
		
		if(applicationCheck == 1){
			alert("판매자 신청 상태이거나 이미 판매자 회원입니다.");
			history.go(-1);
		}
		
		$("#application_form").submit(function(){
			// 개업일 유효성 체크
			var strStart_date = $('#opening_date').val();
			
			if(confirm("판매자 신청을 하시겠습니까?")){
				var startDate = new Date(strStart_date);
				var startYyyy = startDate.getFullYear();
				var startmm = startDate.getMonth() + 1;
				var startDd = startDate.getDate();
				var startDay = new Date(startYyyy, startmm, startDd);
				
				var now = new Date();         		  // 현재 날짜
				var nowYyyy = now.getFullYear();
				var nowmm = now.getMonth() + 1;       // 1월 == 0
				var nowDd = now.getDate();
				var nowDate = new Date(nowYyyy, nowmm, nowDd);   
				
				// 생년월일이 시스템 상 날짜 보다 나중 날짜를 입력 못하게 함
				
				if(nowDate.getTime() < startDay.getTime()) {
					alert('생년월일을 다시 입력해주세요!');
					$('#opening_date').focus();
					return false;
				}
			}else{
				alert("취소되었습니다.");
				return false;
			}
		});
		
		
		
	});

</script>
<!-- 중앙 내용 시작 -->
<div class = "container-fluid" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	<div align = "left">
			<h3>판매자 신청</h3>
	</div>
	<div class="text-center col-sm-12 my-5">
	<form:form id="application_form" action="sellerApplication.do" modelAttribute="memberBuisDTO">
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_num">사업자번호&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="buis_num" value=" "/>
				<form:errors path="buis_num" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="ceo_name">대표자명&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="ceo_name"/>
				<form:errors path="ceo_name" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_name">회사명&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="buis_name"/>
				<form:errors path="buis_name" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_item">종목명&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="buis_item"/>
				<form:errors path="buis_item" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="opening_date">개업일자&nbsp;</label>
				<input class = "col-sm-4 form-control" type="date" name="opening_date" id="opening_date" max = "today">
				<form:errors path="opening_date" cssClass="error-color"/>
		</div>
		<div class = "form-group row">
				<label> ----------------------회사주소----------------------</label>
		</div>
		<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_zipcode">우편번호&nbsp;</label>
				<input class = "col-sm-4 form-control" id="buis_zipcode" name="buis_zipcode" placeholder="우편번호" type="text" value="" maxlength="5" readonly="readonly"/>&nbsp;&nbsp;&nbsp;
				<input type="button" class = "btn btn-outline-dark" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
				
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">

				</div>
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
				                    document.getElementById("buis_address1").value = extraAddr;
				                
				                } else {
				                    document.getElementById("buis_address1").value = '';
				                }
				
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('buis_zipcode').value = data.zonecode;
				                document.getElementById("buis_address1").value = addr;
				                // 커서를 상세주소 필드로 이동한다.
				                document.getElementById("buis_address2").focus();
				            }
				        }).open();
				    }
			</script>
			<form:errors path="buis_zipcode" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_address1">주소&nbsp;</label>
				<input class = "col-sm-4 form-control" id="buis_address1" name="buis_address1" type="text" value="" maxlength="30" readonly="readonly" placeholder="주소"/>
				<form:errors path="buis_address1" cssClass="error-color"/>
			</div>
			<div class = "form-group row">
				<label class = "col-sm-2 col-form-label" for="buis_address2">나머지주소&nbsp;</label>
				<form:input class = "col-sm-4 form-control" path="buis_address2" maxlength="30" placeholder="상세주소"/>
				<form:errors path="buis_address2" cssClass="error-color"/>
			</div>
				</div>
				
				<div class = "form-group row">
					<div class = "text-center col-sm-10">
						<form:button class = "btn btn-outline-dark">판매자신청</form:button>&nbsp;&nbsp;
						<input type="button" class = "btn btn-outline-dark" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
					</div>
				</div>
		</form:form>
	</div>
</div>
<!-- 중앙 내용 끝 -->