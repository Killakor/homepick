package com.teamproject.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor implements HandlerInterceptor {

	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	//트랜잭션 - 핸들러가 실행되기 전 체크
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler)throws Exception{
		
		logger.debug("[로그인이 필요한 페이지일 경우 이동하는 지, 인터셉터 동작 확인]");
		
		//세션을 통한 로그인 한 회원 번호 얻어오기 검사
		HttpSession session = request.getSession();
		
		//로그인이 되지 않은 상태일 경우, 로그인 페이지로 이동
		if(session.getAttribute("user_num") == null) {
			
			response.sendRedirect(request.getContextPath() + "/member/login.do");
			
			return false;
		}
		
		//로그인이 된 상태일 경우, 통과
		return true;
	}
}