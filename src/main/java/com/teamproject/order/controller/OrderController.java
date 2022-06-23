package com.teamproject.order.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;
import com.teamproject.order.bean.OrderDTO;
import com.teamproject.order.service.OrderService;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.service.StoreService;
import com.teamproject.util.PagingUtil;

@Controller
public class OrderController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private StoreService storeService;
	
	//스프링빈 초기화
	@ModelAttribute
	public OrderDTO initOrder() {
		return new OrderDTO();
	}
	
	private int rowCount = 20;	//한 페이지의 게시물의 수
	private int pageCount = 10;	//한 화면에 보여줄 페이지 수
	
	//주문 등록 폼 호출
	@GetMapping("/order/orderMain.do")
	public String orderPage(OrderDTO order, MemberDTO member, StoreDTO storeDTO, HttpServletRequest request, HttpSession session, Model model) {
		
		logger.debug("[주문 페이지 호출]");
		
		//로그인 된 회원정보 체크
		Integer check = (Integer)session.getAttribute("user_num");
		
		//로그인 세션 체크(미로그인 시 세팅X)
		if(check != null) {
			//회원 정보를 주문 테이블에 세팅
			member.setMem_num((Integer)session.getAttribute("user_num"));
			order.setMem_num(member.getMem_num());
			member = memberService.selectMember(member.getMem_num());
			
			model.addAttribute("memberDTO", member);
		}
		
		//파라미터를 통해 갯수를 불러옴
		Integer quan = Integer.parseInt(request.getParameter("quan"));
		//파라미터를 통해 옵션정보 불러옴
		String prod_option = request.getParameter("prod_option");
		
		logger.debug("[회원 정보] : " + member.getMem_num());
		
		storeDTO = storeService.selectProduct(storeDTO.getProd_num());
		
		//수량 정보 주문 테이블에 세팅
		storeDTO.setQuan(quan);
		//상품 옵션 주문 테이블에 세팅
		storeDTO.setCommit_option(prod_option);
		 
		logger.debug("[주문한 회원 정보] : " + member);
		logger.debug("[주문한 상품 정보] : " + storeDTO);
		 
		model.addAttribute("storeDTO", storeDTO);
		
		return "orderMain";
	}
	
	//카카오 결제 API(https://blog.naver.com/dudghks2814/222470808715 참고)
	@RequestMapping("/order/kakao.do")
	@ResponseBody
	public String kakaopay(OrderDTO orderDTO, HttpServletRequest request) {
		
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			
			//주문 정보 세팅
			String receiver_name = request.getParameter("receiver_name");
			orderDTO.setReceiver_name(receiver_name);
			String receiver_phone = request.getParameter("receiver_phone");
			orderDTO.setReceiver_phone(receiver_phone);
			String order_zipcode = request.getParameter("order_zipcode");
			orderDTO.setOrder_zipcode(order_zipcode);
			String order_address1 = request.getParameter("order_address1");
			orderDTO.setOrder_address1(order_address1);
			String order_address2 = request.getParameter("order_address2");
			orderDTO.setOrder_address2(order_address2);
			String buis_name = request.getParameter("buis_name");
			orderDTO.setBuis_name(buis_name);
			String prod_name = request.getParameter("prod_name");
			orderDTO.setProd_name(prod_name);
			int pay_price = Integer.parseInt(request.getParameter("final_price"));
			orderDTO.setPay_price(pay_price);
			int quan = Integer.parseInt(request.getParameter("quan"));
			orderDTO.setPay_quan(quan);
			String prod_opt = request.getParameter("commit_option");
			orderDTO.setProd_opt(prod_opt);
			
			//전송 정보(rest API key)
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 451f684667a4cd87e650c6e715759bf5");
			conn.setRequestProperty("Accept", "APPLICATION_JSON_UTF8_VALUE");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("cid", "TC0ONETIME");
			map.put("partner_order_id", "partner_order_id");
			map.put("partner_user_id", orderDTO.getBuis_name());
			map.put("item_name", orderDTO.getProd_name());
			map.put("quantity", String.valueOf(orderDTO.getPay_quan()));
			map.put("total_amount", String.valueOf(orderDTO.getPay_price()));
			map.put("tax_free_amount", "0");
			map.put("approval_url", "http://localhost:8080/teamproject/order/orderSuccess.do");
			map.put("fail_url", "http://localhost:8080/teamproject/member/login.do");
			map.put("cancel_url", "http://localhost:8080/teamproject/store/storeCategory.do");
			
			String params = new String();
			for(Map.Entry<String, String> emap : map.entrySet()) {
				params += (emap.getKey() + "=" + emap.getValue() + "&");
			}
			
			OutputStream os = conn.getOutputStream();
			DataOutputStream dos = new DataOutputStream(os);
			dos.writeBytes(params);
			dos.flush();
			dos.close();
			
			int result = conn.getResponseCode();
			logger.debug("result" + result);
			
			InputStream is;
			
			if(result == 200) {
				is = conn.getInputStream();
			} else {
				is = conn.getErrorStream();
			}
			
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			
			return br.readLine();
			
		} catch(MalformedURLException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	//주문내역 저장
	@RequestMapping("/order/orderInsert.do")
	@ResponseBody
	public Map<String, String> orderInsert(OrderDTO orderDTO, HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		logger.debug("[주문 정보] : " + orderDTO);
		
		Integer prod_num = Integer.parseInt(request.getParameter("prod_num"));
		orderDTO.setProd_num(prod_num);
		
		orderService.insertOrder(orderDTO);
		map.put("result", "success");
		
		return map;
	}
	
	//카카오 페이 주문 완료 시, 카카오 성공 페이지 호출 후 주문 성공 페이지로 호출 
	@GetMapping("/order/orderSuccess.do")
	public String orderSuccess() {
		
		logger.debug("카카오 페이를 통한 주문 성공");
		
		return "redirect:/order/orderComplete";
	}
	
	//주문 완료 
	@GetMapping("/order/orderComplete.do")
	public String orderComplete() {
		
		logger.debug("주문 성공 완료");
		
		return "orderComplete";
	}
	
	//주문 조회 폼(비회원)
	@GetMapping("/order/nonCheck.do")
	public String nonCheck() {
		
		logger.debug("비회원 주문 조회");
		
		return "nonCheck";
	}
	
	//주문 조회 리스트(비회원) [@Valid - 객체 검증]
	@RequestMapping("/order/orderNonCheck.do")
	public String process(@Valid OrderDTO orderDTO, BindingResult result, 
						  @RequestParam(value="pageNum", defaultValue="1") int currentPage,
						  @RequestParam String receiver_phone, 
						  Model model) {
		
		logger.debug("[비회원 주문 조회]");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiver_phone", receiver_phone);
		
		//전화번호 데이터를 통한 회원정보 확인
		int count = orderService.selectNonRowCount(map);
		
		logger.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "orderNonCheck.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<OrderDTO> list = null;
		
		if(count > 0) {
			list = orderService.selectNonList(map);
			logger.debug("[주문 데이터 리스트 조회] : " + list);
		}
		
		//조회 값에 오류가 발생할 시 조회 폼 호출
		if(result.hasErrors()) {
			return "nonCheck";
		}
		model.addAttribute("orderDTO", orderDTO);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "orderNonCheck";
	}
	
	//주문 조회 리스트(회원)
	@GetMapping("/order/myOrder.do")
	public String process(OrderDTO orderDTO, @RequestParam(value="pageNum", defaultValue="1") int currentPage, HttpSession session, Model model) {
		
		logger.debug("[주문 내역 조회]");
		
		Integer mem_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_num", mem_num);
		
		//회원 번호 데이터를 통한 주문정보 확인
		int count = orderService.selectRowCount(map);
		
		logger.debug("[주문량] : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "myOrder.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//주문 리스트
		List<OrderDTO> list = null;
		
		if(count > 0) {
			list = orderService.selectList(map);
			logger.debug("<<list>> : " + list);
		}
		
		model.addAttribute("orderDTO", orderDTO);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "myOrder";
	}
}
