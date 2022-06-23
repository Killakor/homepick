<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%@ include file="/WEB-INF/views/member/common/myPageHeader.jsp" %>
<div class = "container-fluid contents-wrap" style = "width:700px; font-family: 'Gowun Dodum', sans-serif; ">
	<div align = "left">
		<h3>내 포인트 조회</h3>
	</div>
	<%-- 비밀번호 찾기 성공시 --%>
		<br>
	<table class="table table-sm">
			<tr>
				<th scope="col"><div align="center" style="font-size:28px;">${member.mem_id} 님의 포인트</div></th>
			</tr>
			<tr>
				<td align="center"> 
				<div align="center" style="font-size:28px; background-color: #f5f5ff; width :60%; height: 60%;">
				사용가능한 포인트
				 <p style="font-size: 40px; color: #c92662;"><fmt:formatNumber pattern="###,###,###" value="${member.point}"/> P 입니다.</p>	
				언제나 저희 홈픽을 <br>이용해주셔서 감사합니다.</div></td>
			</tr>
		</table>
</div>