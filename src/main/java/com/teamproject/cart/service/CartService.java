package com.teamproject.cart.service;

import java.util.List;

import com.teamproject.cart.bean.CartDTO;

public interface CartService {

	/* 장바구니 정보 */
	//장바구니 추가
	public void cartInsert(CartDTO cartDTO);

	//장바구니 리스트
	public List<CartDTO> cartList(int mem_num);

	//장바구니 수정
	public void cartUpdate(CartDTO cartDTO);
	
	//장바구니 삭제
	public void cartDelete(int cart_num);

	//장바구니 금액 합계
	public int sumMoney(int mem_num);

	//장바구니 갯수
	public int cartCount(CartDTO cartDTO);

	//장바구니 추가 - 장바구니 갯수 변경 (유효성 검사)
	public void CurrentUpdate(CartDTO cartDTO);

	//장바구니 이미지
	public CartDTO cartImg(int prod_num);

	//장바구니 주문량
	public int OrdercartCount(int mem_num);
	
}
