package com.teamproject.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.cart.bean.CartDTO;
import com.teamproject.cart.service.CartService;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;

@Controller
@RequestMapping("/cart")
public class CartController {

	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	//의존성 주입
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;
	
	//스프링빈 초기화
	@ModelAttribute
	public MemberDTO initMember() {
		return new MemberDTO();
	}
	
	@ModelAttribute
	public CartDTO initCart() {
		return new CartDTO();
	}
	
	
	//장바구니 목록
	@GetMapping("/cartList.do")
	public String cartList(CartDTO cartDTO, HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		logger.debug("[회원 번호] : " + user_num);
		
		//장바구니 리스트
		List<CartDTO> list = cartService.cartList(user_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//구매금액 합계
		int sumMoney = cartService.sumMoney(user_num);
		//배송비 : 구매금액 합계 5만원 이상 무료 (이하일 경우, 배송비 없음)
		int fee = sumMoney >= 50000 ? 0 : 2500;
		
		map.put("sumMoney", sumMoney);
		map.put("fee", fee);
		map.put("allSum", sumMoney+fee);
		map.put("list", list);
		map.put("count", list.size());
		
		//map에 담긴 정보 전달
		model.addAttribute("map", map);
		
		logger.debug("[장바구니 담긴 갯수]:" + list.size());
		
		return "cartList";
	}
	
	
	//장바구니 버튼 클릭 시 추가
	@RequestMapping("/cartInsert.do")
	@ResponseBody
	public Map<String, String> cartInsert(CartDTO cart, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		cart.setMem_num((Integer)session.getAttribute("user_num"));
		
		logger.debug("[장바구니 > 회원 번호] : " + cart.getMem_num());
		
		//장바구니 갯수
		int count = cartService.cartCount(cart);
		
		logger.debug("[장바구니 갯수] : " + count);
		
		//장바구니 유효성 검사
		if(count == 0) {
			//장바구니에 같은 정보가 없을 시, 추가
			cartService.cartInsert(cart);
			map.put("result", "add_success");
		} else {
			//장바구니에 같은 정보가 없을 시, 수정
			cartService.CurrentUpdate(cart);
			map.put("result", "cart_update");
		}
		
		return map;
	}

	
	//장바구니 수정
	@GetMapping("/cartUpdate.do")
	public String cartUpdate(@RequestParam int[] cart_quan, @RequestParam int[] prod_num, HttpSession session, CartDTO cart) {

		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//for문을 통해 회원번호/제품번호/장바구니수량 수정
		for(int i = 0; i < prod_num.length; i++) {
			cart.setMem_num(user_num);
			cart.setProd_num(prod_num[i]);
			cart.setCart_quan(cart_quan[i]);
			
			cartService.cartUpdate(cart);
			
			logger.debug ("[장바구니 수정 정보] : " + cart);
		}
		
		return "redirect:cartList.do";
	}
	
	
	//장바구니 삭제
	@GetMapping("/cartDelete.do")
	public String delete(@RequestParam int cart_num) {
		
		cartService.cartDelete(cart_num);
		
		return "redirect:cartList.do";
	}
	

	
	//장바구니 이미지
	@GetMapping("/imageView.do")
	public String viewImage(@RequestParam int prod_num, CartDTO cart, Model model) {
			
		cart = cartService.cartImg(prod_num);

		model.addAttribute("imageFile", cart.getThumbnail_img());
		model.addAttribute("filename", cart.getThumbnail_filename());
			
		return "imageView";
	}
	
	
	//장바구니 주문 페이지
	@PostMapping("/cartOrderForm.do")
	public String cartOrderForm(Model model,HttpSession session, MemberDTO memberDTO) {
		
		Integer mem_num = (Integer)session.getAttribute("user_num");

		//장바구니 리스트
		List<CartDTO> cartDTO = cartService.cartList(mem_num);
		//장바구니 주문량
		int count = cartService.OrdercartCount(mem_num);
		//회원번호 정보 조회
		memberDTO = memberService.selectMember(mem_num);
		
		logger.debug("[장바구니 리스트] : " + cartDTO);
		logger.debug("[장바구니 주문량] : " + count);
		logger.debug("[장바구니 > 회원 정보] : " + memberDTO);

		//전체 가격
		int totalPrice = 0;
		//장바구니에 담긴 금액만 큼 전체 가격 추가
		for(int i = 0; i < cartDTO.size(); i++) {
			totalPrice += cartDTO.get(i).getMoney();
		}
		
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("count", count);
		model.addAttribute("cartDTO", cartDTO);
		model.addAttribute("memberDTO", memberDTO);
		
		return "cartOrderForm";
	}
}

