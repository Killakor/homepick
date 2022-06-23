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

import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.service.StoreService;


public class ProductRegisterCheckInterceptor implements HandlerInterceptor {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(WriterCheckInterceptor.class);
	
	//의존성 주입
	@Autowired
	private StoreService storeService;
	
	//트랜잭션 - 핸들러가 실행되기 전 체크
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		logger.debug("[로그인 회원 번호와, 상품 판매자 회원 번호가 일치하는지 확인]");
		
		//세션을 통한 로그인 한 회원 번호 얻어오기
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//상품 정보 확인
		int prod_num = Integer.parseInt(request.getParameter("prod_num"));
		StoreDTO storeDTO = storeService.selectProduct(prod_num);
		
		logger.debug("[로그인 회원 번호] : " + user_num);
		logger.debug("[상품을 등록한 판매자 번호] : " + storeDTO.getMem_num());
		
		//회원 번호와 판매자 회원 번호가 일치하는 지 여부 체크
		if(user_num != storeDTO.getMem_num()) {
			
			logger.debug("[로그인 회원 번호와 상품 판매자 회원 번호가 일치하지 않습니다]");
			
			request.setAttribute("accessMsg", "잘못된 접근을 시도하였습니다.");
			request.setAttribute("accessBtn", "목록");
			request.setAttribute("accessUrl", request.getContextPath() + "/store/storeCategory.do");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/common/notice.jsp");
			
			dispatcher.forward(request, response);
			
			return false;
		}
		
		logger.debug("[로그인 회원 번호와 상품 판매자 회원 번호가 일치합니다]");
		
		return true;
	}
}
