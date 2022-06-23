<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
    <div class="container">
    <div class="main-container">
	<h2>공지 수정</h2>
	<form:form action="noticeUpdate.do" modelAttribute="noticeDTO">
		<form:hidden path="notice_num"/>
		<ul>
			<li class="li-title">
				<label for="notice_title" class="notice_label mb-2">제목</label>
				<form:input path="notice_title"/>
				<form:errors path="notice_title" cssClass="error-color"/>
			</li>
			<li class="li-content mt-1">
				<label for="notice_content">내용</label><br>
				<form:textarea path="notice_content"/>
				<form:errors path="notice_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor) {
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);	
						}
					}
					
					ClassicEditor.create(document.querySelector('#notice_content'), {
						extraPlugins:[MyCustomUploadAdapterPlugin]
					}).then(editor => {
						window.editor = editor;
					}).catch(error => {
						console.error(error);
					})
				</script>
			</li>
		</ul>
		<div class="submit-button mt-2 mb-2" >
			<input type="submit" value="등록" class="btn btn-outline-dark">
			<input type="button" value="목록"  class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/notice/noticeList.do'">
		</div>
	</form:form>
	</div>
</div>