package com.teamproject.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;


public class SellerCheckInterceptor implements HandlerInterceptor {
	
private static final Logger logger = LoggerFactory.getLogger(WriterCheckInterceptor.class);
	
	@Autowired
	private MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		logger.debug("===== 로그인한 회원이 판매자인지 확인 =====");
		
		//세션을 통한 로그인 한 회원번호 얻어오기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//로그인 한 회원 정보 확인 및 회원 등급 얻기
		MemberDTO memberDTO = memberService.selectMember(user_num);
		Integer auth = memberDTO.getMem_auth();
		
		logger.debug("[로그인 회원 번호] : " + user_num);
		logger.debug("[로그인 회원 등급] : " + auth);
		
		//회원 등급이 존재하지 않을 경우
		if(auth == 0 || auth == null) {
			
			logger.debug("[회원이 아니거나 장기 미접속으로 인한 휴면 회원입니다]");
			
			response.sendRedirect(request.getContextPath() + "/member/login.do");
			
			return false;
		}
		
		//회원 등급이 판매자가 아닐 경우
		if(auth != 3) {
			
			logger.debug("[로그인 한 회원은 판매자 계정이 아닙니다]");
			
			request.setAttribute("accessMsg", "잘못된 접근을 시도하였습니다.");
			request.setAttribute("accessBtn", "목록");
			request.setAttribute("accessUrl", request.getContextPath() + "/store/storeCategory.do");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			
			dispatcher.forward(request, response);
			
			return false;
		}
		
		logger.debug("[로그인 한 회원은 판매자 계정입니다]");
		
		return true;
	}
}
