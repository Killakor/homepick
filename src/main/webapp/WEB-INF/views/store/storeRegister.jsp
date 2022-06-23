<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
h2 {
	font-family: 'Gowun Dodum', sans-serif;
	text-decoration: none;
}
.ck-editor__editable_inline {
	min-height : 250px;
}
</style>
<script type = "text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type = "text/javascript" src = "${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
<script>
	//상품 옵션 추가 기능
	$(document).ready(function() {
		
		var option = 1;
		
		$('#prod_option2').hide();
		$('#prod_option3').hide();
		$('#prod_option4').hide();
		$('#prod_option5').hide();
		$('#prod_option6').hide();
		$('#prod_option7').hide();
		$('#prod_option8').hide();
		$('#prod_option9').hide();
		$('#prod_option10').hide();
		
		$('#plus').click(function(e) {
			
			option += 1;
			e.preventDefault();
			
			$('#prod_option' + option).show();
			
			if(option == 10) {
				$('#plus').hide();
			}
			
			if(option != 1) {
				$('#minus').show();
			}
		});
		
		if(option == 1) {
			$('#minus').hide();
		}
		
		$('#minus').click(function(e) {
			$('#prod_option' + option).hide();
			option--;
			e.preventDefault();
			
			if(option == 1) {
				$('#minus').hide();
			}
			
			$('#plus').show();
		});
	});
	
	//상품등록 시 확인창 출력
	var regist = document.getElementById('regist');
	regist.onclick=function() {
		var choice = confirm('상품을 등록 하시겠습니까?');
		if(choice) {
			return;
		} else {
			return false;
		}
	};
</script>


<div class="container-fluid" style="width:700px; border: 1px solid #d2f1f7; font-family: 'Gowun Dodum', sans-serif; ">
	<h2>상품 등록</h2>
	<form:form id="productRegister" action="storeRegister.do" modelAttribute="storeDTO" enctype="multipart/form-data">
		<div class="form-group row">	    
			<input type="hidden" value="${user_num}">
			<ul>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_name">상품명</label>
					<form:input path="prod_name"/>
					<form:errors path="prod_name" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_keyword">상품 키워드</label>
					<form:input path="prod_keyword" />
					<form:errors path="prod_keyword" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_cate">카테고리</label>
					<form:select class="col-sm-4 custom-select" path="prod_cate">
						<form:option value="furniture">가구</form:option>
						<form:option value="fabric">패브릭</form:option>
						<form:option value="lamp">조명</form:option>
						<form:option value="electronic">가전</form:option>
						<form:option value="kitchen">주방용품</form:option>
						<form:option value="deco">데코/취미</form:option>
						<form:option value="storage">수납/정리</form:option>
						<form:option value="daily_necessities">생활용품</form:option>
						<form:option value="necessities">생필품</form:option>
						<form:option value="tool_diy">공구/DIY</form:option>
						<form:option value="interior">인테리어시공</form:option>
						<form:option value="pet">반려동물</form:option>
						<form:option value="camping">캠핑용품</form:option>
						<form:option value="indoor">실내운동</form:option>
						<form:option value="baby_pro">유아/아동</form:option>
						<form:option value="rental">렌탈</form:option>
					</form:select>
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_price">가격</label>
					<form:input path="prod_price"/><br>
					<form:errors path="prod_price" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="delive_price">배송비</label>
					<form:input path="delive_price" />
					<form:errors path="delive_price" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="delive_type">배송방법</label>
					<form:input path="delive_type" /><br>
					<form:errors path="delive_type" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_quan">상품 수량</label>
					<form:input path="prod_quan" /><br>
					<form:errors path="prod_quan" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="selec_product">상품선택</label>
					<form:input path="selec_product" />
					<form:errors path="selec_product" cssClass="error-color" />
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="prod_option1">상품옵션1</label>
					<form:input path="prod_option1" />
					<form:errors path="prod_option1" cssClass="error-color" />
				</li>
				<li id="prod_option2">
					<label class="col-sm-3 col-form-label" for="prod_option2">상품옵션2</label>
					<form:input path="prod_option2" />
					<form:errors path="prod_option2" cssClass="error-color" />
				</li>
				<li id="prod_option3">
					<label class="col-sm-3 col-form-label" for="prod_option3">상품옵션3</label>
					<form:input path="prod_option3" />
					<form:errors path="prod_option3" cssClass="error-color" />
				</li>
				<li id="prod_option4">
					<label class="col-sm-3 col-form-label" for="prod_option4">상품옵션4</label>
					<form:input path="prod_option4" />
					<form:errors path="prod_option4" cssClass="error-color" />
				</li>
				<li id="prod_option5">
					<label class="col-sm-3 col-form-label" for="prod_option5">상품옵션5</label>
					<form:input path="prod_option5" />
					<form:errors path="prod_option5" cssClass="error-color" />
				</li>
				<li id="prod_option6">
					<label class="col-sm-3 col-form-label" for="prod_option6">상품옵션6</label>
					<form:input path="prod_option6" />
					<form:errors path="prod_option6" cssClass="error-color" />
				</li>
				<li id="prod_option7">
					<label class="col-sm-3 col-form-label" for="prod_option7">상품옵션7</label>
					<form:input path="prod_option7" />
					<form:errors path="prod_option7" cssClass="error-color" />
				</li>
				<li id="prod_option8">
					<label class="col-sm-3 col-form-label" for="prod_option8">상품옵션8</label>
					<form:input path="prod_option8" />
					<form:errors path="prod_option8" cssClass="error-color" />
				</li>
				<li id="prod_option9">
					<label class="col-sm-3 col-form-label" for="prod_option9">상품옵션9</label>
					<form:input path="prod_option9" />
					<form:errors path="prod_option9" cssClass="error-color" />
				</li>
				<li id="prod_option10">
					<label class="col-sm-3 col-form-label" for="prod_option10">상품옵션10</label>
					<form:input path="prod_option10" />
					<form:errors path="prod_option10" cssClass="error-color" />
				</li>
				<li>
					<input class="btn btn-outline-dark" type="button" id="plus" value="상품 옵션 추가">
					<input class="btn btn-outline-dark" type="button" id="minus" value="상품 옵션 제거">
				</li>
				<li>
					<label class="col-sm-3 col-form-label" for="upload1">썸네일 이미지</label>
					<input class="btn btn-outline-dark" type="file" name="upload1" id="upload1" accept="image/gif,image/png,image/jpeg">
				</li>
				<!-- CKEditor -->
				<li>
					<label class="col-sm-3 col-form-label" for="prod_content">상품 내용</label>
					<form:textarea path="prod_content" />
					<form:errors path="prod_content" cssClass="error-color" />
					<script>
						function MyCustomUploadAdapterPlugin(editor) {
							editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
								return new UploadAdapter(loader);
							}
						}
						
						ClassicEditor.create(document.querySelector('#prod_content'), {
							extraPlugins:[MyCustomUploadAdapterPlugin]
						}).then(editor => {
							window.editor = editor;
						}).catch(error => {
							console.error(error);
						});
					</script>
				</li>
			</ul>
			
			<div class="align-center" style="margin-left : 40px;">
				<input class="btn btn-outline-dark" type="submit" value="상품 등록" id="regist">
	
				<input class="btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/store/storeCategory.do'">
			</div>
			
		</div>
	</form:form>
</div>