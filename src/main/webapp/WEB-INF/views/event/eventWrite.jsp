<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
.container{
	width: 900px;
	margin : 0 auto;
}
h2{
	padding : 10px 0px 20px 8px;
	border-bottom : 1px solid #dbdbdb;
}
.li-title input{
	width : 700px;
	margin : 10px 0px 10px 15px;
}
.li-title{
	padding : 20px 0px 10px 8px;
}
.li-content{
	padding : 10px 0px 0px 8px;
}
.li-content label{
	text-align: left;
}
.submit-button{
	padding : 20px 0px 20px 0px;
	border-bottom : 1px solid #dbdbdb;
	text-align: center;
}
textarea{
	width : 750px;
	height : 300px;
	resize:none;
	margin : 20px 0px 0px 0px;
}
.main-container{
	margin: 0 auto;
	text-align: center;
}
.ck-editor__editable_inline {
	min-height: 500px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>

<div class="container">
	<div class="main-container">
		<h2>이벤트 등록</h2>
		<form:form action="eventWrite.do" modelAttribute="eventDTO" enctype="multipart/form-data">
			<ul>
				<li class="li-title">
					<label for="event_title">제목</label>
					<form:input path="event_title"/><br>
					<form:errors path="event_title" cssClass="error-color"/>
				</li>
				
				<li>
					<label for="event_type">카테고리</label>
					<select name="event_type" id="event_type">
						<option value="">카테고리</option>
						<option value="진행중">진행중</option>
						<option value="종료">종료</option>
					</select>
					<form:errors path="event_type" cssClass="error-color"/>
				</li>
				
				<li class="align-right">
					<label for="event_day">진행날짜</label>
					<form:input path="event_day"/><br>
					<form:errors path="event_day" cssClass="error-color"/>
				</li>
				
				<!-- CKEditor -->
				<li class="li-content">
					<form:textarea path="event_content"/>
					<form:errors path="event_content" cssClass="error-color"/>
					<script>
						function MyCustomUploadAdapterPlugin(editor) {
							editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
								return new UploadAdapter(loader);	
							}
						}
						
						ClassicEditor.create(document.querySelector('#event_content'), {
							extraPlugins:[MyCustomUploadAdapterPlugin]
						}).then(editor => {
							window.editor = editor;
						}).catch(error => {
							console.error(error);
						})
					</script>
				</li>
				
	 			<li class="li-content">
					<label for="upload">썸네일 파일</label>
					<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
				</li>
			</ul>
			<div class="submit-button">
				<input type="submit" value="등록">
				<input type="button" value="목록으로" onclick="location.href='${pageContext.request.contextPath}/event/eventList.do'">
			</div>
		</form:form>
	</div>
</div>