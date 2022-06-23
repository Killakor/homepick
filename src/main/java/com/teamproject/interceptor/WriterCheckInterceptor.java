package com.teamproject.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.HandlerInterceptor;

import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.service.HouseBoardService;

public class WriterCheckInterceptor implements HandlerInterceptor {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(WriterCheckInterceptor.class);
	
	//의존성 주입
	@Autowired
	private HouseBoardService houseBoardService;
	
	//트랜잭션 - 핸들러가 실행되기 전 체크
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		logger.debug("[로그인 회원 번호와, 집들이 게시물 등록한 회원 번호가 일치하는지 확인]");
		
		//세션을 통한 로그인 한 회원 번호 및 회원 등급 얻어오기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer auth = (Integer)session.getAttribute("user_auth");
		
		//집들이 게시물 정보 확인
		int house_num = Integer.parseInt(request.getParameter("house_num"));
		HouseBoardDTO houseBoard = houseBoardService.selectHBoard(house_num);
		
		logger.debug("[로그인 회원 번호] : " + user_num);
		logger.debug("[로그인 회원 등급] : " + auth);
		logger.debug("[집들이 게시물 등록한 회원 번호] : " + houseBoard.getMem_num());
		
		//회원번호와 집들이 게시물 작성자 회원번호가 일치하는 지 여부 체크 혹은 관리자 등급일 경우만
		if(user_num != houseBoard.getMem_num() && auth != 4) {
			
			logger.debug("[로그인 회원 번호와 집들이 게시물 작성자 회원 번호가 일치하지 않습니다]");
			
			request.setAttribute("accessMsg", "잘못된 접근을 시도하였습니다.");
			request.setAttribute("accessBtn", "목록");
			request.setAttribute("accessUrl", request.getContextPath() + "/houseBoard/list.do");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			
			dispatcher.forward(request, response);
			
			return false;
		}
		
		logger.debug("[로그인 회원 번호와 집들이 게시물 작성자 회원 번호가 일치합니다]");
		
		return true;
	}

}
