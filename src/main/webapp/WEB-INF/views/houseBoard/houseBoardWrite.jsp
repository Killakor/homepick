<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>
.ck-editor__editable_inline {
	min-height: 250px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
<script type="text/javascript">
	$(function() {
		//유효성 검사
		$('#register_form').submit(function() {
			if($('#house_title').val().trim() == '') {
				alert('제목을 입력하세요');
				$('#house_title').val('').focus();
				return false;
			}
					
			if($('#house_area').val() == '') {
				alert('평수를 선택하세요');
				$('#house_area').val('').focus();
				return false;
			}
			
			if($('#house_type').val() == '') {
				alert('주거형태를 선택하세요');
				$('#house_type').val('').focus();
				return false;
			}
			
			if($('#house_style').val() == '') {
				alert('스타일을 선택하세요');
				$('#house_type').val('').focus();
				return false;
			}
			
			if($('#house_space').val() == '') {
				alert('공간을 선택하세요');
				$('#house_type').val('').focus();
				return false;
			}
			
			if($('#house_content').val() == '') {
				alert('내용을 입력하세요');
				$('#house_content').val('').focus();
				return false;
			}
		});
	});
</script>

<div class="page-main2">
	<form:form id="register_form" action="write.do" modelAttribute="houseBoardDTO" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		
		<ul>
			<!-- 게시물 제목 -->
			<li>
				<label for="house_title" class="title"></label>
				<form:input path="house_title" class="form-control" placeholder="제목을 입력하세요"/>
				<form:errors path="house_title" cssClass="error-color"/>
			</li>
			
			<!-- 카테고리 -->
			<li>
				<label for="house_area"></label>
				<select name="house_area" id="house_area" class="form-control">
					<option value="">평수</option>
					<option value="10평 미만">10평 미만</option>
					<option value="10평대">10평대</option>
					<option value="20평대">20평대</option>
					<option value="30평대">30평대</option>
					<option value="40평대">40평대</option>
					<option value="50평 이상">50평 이상</option>
				</select>
				<form:errors path="house_area" cssClass="error-color"/>
				<label for="house_type"></label>
				<select name="house_type" id="house_type" class="form-control">
					<option value="">주거형태</option>
					<option value="원룸&오피스텔">원룸&오피스텔</option>
					<option value="아파트">아파트</option>
					<option value="빌라&연립">빌라&연립</option>
					<option value="단독주택">단독주택</option>
					<option value="사무공간">사무공간</option>
					<option value="상업공간">상업공간</option>
				</select>
				<form:errors path="house_type" cssClass="error-color"/>
				<label for="house_style"></label>
				<select name="house_style" id="house_style" class="form-control">
					<option value="">스타일</option>
					<option value="모던">모던</option>
					<option value="북유럽">북유럽</option>
					<option value="빈티지">빈티지</option>
					<option value="내추럴">내추럴</option>
					<option value="프로방스&로맨틱">프로방스&로맨틱</option>
					<option value="클래식&앤틱">클래식&앤틱</option>
					<option value="한국&아시아">한국&아시아</option>
					<option value="유니크">유니크</option>
				</select>
				<form:errors path="house_style" cssClass="error-color"/>
				<label for="house_space"></label>
				<select name="house_space" id="house_space" class="form-control">
					<option value="">공간</option>
					<option value="원룸">원룸</option>
					<option value="거실">거실</option>
					<option value="침실">침실</option>
					<option value="주방">주방</option>
					<option value="욕실">욕실</option>
					<option value="아이방">아이방</option>
					<option value="드레스룸">드레스룸</option>
					<option value="서재&작업실">서재&작업실</option>
					<option value="베란다">베란다</option>
					<option value="사무공간">사무공간</option>
					<option value="상업공간">상업공간</option>
					<option value="가구&소품">가구&소품</option>
					<option value="현관">현관</option>
					<option value="외관&기타">외관&기타</option>
				</select>
				<form:errors path="house_space" cssClass="error-color"/>
			</li>
			<!-- 게시물 등록 내용 -->
			<!-- CKEditor -->
			<li>
				<label for="house_content"></label>
				<form:textarea path="house_content"/>
				<form:errors path="house_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor) {
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);	
						}
					}
					
					ClassicEditor.create(document.querySelector('#house_content'), {
						extraPlugins:[MyCustomUploadAdapterPlugin]
					}).then(editor => {
						window.editor = editor;
					}).catch(error => {
						console.error(error);
					})
				</script>
			</li>
			<!-- 썸네일 파일 -->
			<li>
				<label for="upload">썸네일 파일</label>
				<input type="file" name="upload" id="upload" class = "btn btn-outline-dark" accept="image/gif,image/png,image/jpeg">
			</li>
		</ul>
		
		<!-- 버튼 -->
		<div class="align-center">
			<form:button class="btn btn-outline-dark">등록</form:button>
			<input type="button" class="btn btn-outline-dark" value="목록" onclick="location.href='list.do'">	
		</div>
	</form:form>
</div>
