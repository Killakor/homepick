<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<link rel="stylesheet" href="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
.container {
	width: 900px;
	margin : 0 auto;
}
h2 {
	padding : 10px 0px 20px 8px;
	border-bottom : 1px solid #dbdbdb;
}
.li-title input {
	width : 700px;
	margin : 10px 0px 10px 15px;
}
.li-title {
	padding : 20px 0px 10px 8px;
}
.li-content {
	padding : 10px 0px 0px 8px;
}
.li-content label {
	text-align: left;
}
.submit-button {
	padding : 20px 0px 20px 0px;
	border-bottom : 1px solid #dbdbdb;
	text-align: center;
}
textarea {
	width : 750px;
	height : 300px;
	resize:none;
	margin : 20px 0px 0px 0px;
}
.main-container {
	margin: 0 auto;
	text-align: center;
}
.ck-editor__editable_inline {
	min-height: 500px;
}
<
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
<script type="text/javascript">
	//이미지 삭제 시
	$(function() {
		$('#file_del').click(function() {
			var choice = confirm('이미지를 삭제하시겠습니까?');
			if(choice) { // true
				$.ajax({
					data: {event_num: ${eventDTO.event_num}},
					type: 'post',
					url: 'deleteFile.do',
					dataType: 'json',
					cache: false,
					timeout: 30000,
					success: function(param) {
						if(param.result == 'wrongauth') {
							alert('Wrong auth');
						} else if(param.result == 'success') {
							$('#file_detail').hide();
						} else {
							alert('잘못된 접근으로 파일삭제에 오류가 발생하였습니다.');
						}
					},
					error : function(request,status,error) {
						alert("code = " + request.status + " message = " + request.responseText + " error = " + error);
					}
				});
			}
		});
	});
	
	//수정 완료 시
	var update = document.getElementById('update');
	update.onclick=function() {
		var choice = confirm('이벤트를 수정 하시겠습니까?');
		if(choice) {
			return;
		}else {
			return false;
		}
	};
</script>

<div class="container">
	<div class="main-container">
	<h2>이벤트 수정</h2>
	<form:form action="eventUpdate.do" modelAttribute="eventDTO" enctype="multipart/form-data">
		<form:hidden path="event_num"/>
			<ul>
				<li class="li-title">
					<label for="event_title">제목</label>
					<form:input path="event_title"/>
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
					<li>
						<label for="event_content"></label>
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
				
				<!-- 썸네일 파일 -->
				<li>
					<label for="upload">썸네일 파일</label>
					<input type="file" name="upload" id="upload" accept="image/gif,image/png,image/jpeg">
					
					<%--파일 등록되어 있을 시 --%>
					<c:if test="${!empty eventDTO.event_filename}">
						<br>
						<span id="file_detail">(${eventDTO.event_filename}) 파일이 등록되어 있습니다. 다시 업로드 시, 기존 파일은 삭제됩니다.</span>
						<input type="button" value="파일삭제" id="file_del">
					</c:if>
				</li>
			</ul>
			
			
			<div class="submit-button">
				<input class="btn btn-outline-dark" type ="submit" value="글 수정" id = "update">
				<input class="btn btn-outline-dark" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/event/eventList.do'">
			</div>
		</form:form>
	</div>
</div>