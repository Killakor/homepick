package com.teamproject.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.cart.bean.CartDTO;
import com.teamproject.cart.dao.CartMapper;

@Service
@Transactional
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartDAO;
	
	@Override
	public void cartInsert(CartDTO cartDTO) {
		cartDAO.cartInsert(cartDTO);
	}

	@Override
	public List<CartDTO> cartList(int mem_num) {
		return cartDAO.cartList(mem_num);
	}

	@Override
	public void cartDelete(int cart_num) {
		cartDAO.cartDelete(cart_num);
	}

	@Override
	public void cartUpdate(CartDTO cartDTO) {
		cartDAO.cartUpdate(cartDTO);
	}

	@Override
	public int sumMoney(int mem_num) {
		return cartDAO.sumMoney(mem_num);
	}

	@Override
	public void CurrentUpdate(CartDTO cartDTO) {
		cartDAO.CurrentUpdate(cartDTO);
	}
	
	@Override
	public CartDTO cartImg(int prod_num) {
		return cartDAO.cartImg(prod_num);
	}

	@Override
	public int cartCount(CartDTO cartDTO) {
		return cartDAO.cartCount(cartDTO);
	}

	@Override
	public int OrdercartCount(int mem_num) {
		return cartDAO.OrdercartCount(mem_num);
	}

}
