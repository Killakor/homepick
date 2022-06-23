<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
    
<!-- 디폴트 값인 index.jsp로 접속 시, [절대경로 + main/main.do]로 전송 -->
<%
	response.sendRedirect(request.getContextPath() + "/main/main.do");
%>