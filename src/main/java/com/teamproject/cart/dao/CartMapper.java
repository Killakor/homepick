package com.teamproject.cart.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.cart.bean.CartDTO;

@Repository
public interface CartMapper {

	/* 장바구니 정보 */
	//장바구니 추가
	@Insert("INSERT INTO cart(cart_num, prod_num, mem_num, cart_quan) select case count(*) when 0 then 1 else max(cart_num) + 1 end,#{prod_num},#{mem_num},#{cart_quan} from cart")
	public void cartInsert(CartDTO cartDTO);
	
	//장바구니 리스트
	@Select("SELECT c.cart_num AS cart_num, c.mem_num AS mem_num, p.prod_num AS prod_num, m.mem_name AS mem_name, p.prod_name AS prod_name, c.cart_quan, p.prod_price AS prod_price,(prod_price * cart_quan) money, p.thumbnail_img AS thumbnail_img, p.thumbnail_filename AS thumbnail_filename FROM mem_detail m, product p, cart c WHERE m.mem_num = c.mem_num AND p.prod_num = c.prod_num AND c.mem_num = #{mem_num} ORDER BY c.cart_num")
	public List<CartDTO> cartList(int mem_num);
	
	//장바구니 수정
	@Update("UPDATE cart SET cart_quan = ${cart_quan} WHERE mem_num = #{mem_num} AND prod_num = ${prod_num}")
	public void cartUpdate(CartDTO cartDTO);
	
	//장바구니 삭제
	@Delete("DELETE FROM cart WHERE cart_num = #{cart_num}")
	public void cartDelete(int cart_num);
	
	//장바구니 금액 합계
	@Select("SELECT ifnull(SUM(prod_price * cart_quan), 0) money FROM cart c, product p WHERE c.prod_num = p.prod_num AND c.mem_num = #{mem_num}")
	public int sumMoney(int mem_num);
	
	//장바구니 갯수
	@Select("SELECT count(*) FROM cart WHERE mem_num = #{mem_num} AND prod_num = #{prod_num}")
	public int cartCount(CartDTO cartDTO);
	
	//장바구니 추가 - 장바구니 갯수 변경 (유효성 검사)
	@Update("UPDATE cart SET cart_quan = cart_quan + ${cart_quan} WHERE mem_num = #{mem_num} AND prod_num = ${prod_num}")
	public void CurrentUpdate(CartDTO cartDTO);
	
	//장바구니 이미지
	@Select("SELECT thumbnail_img,thumbnail_filename FROM product  WHERE prod_num = #{prod_num}")
	public CartDTO cartImg(int prod_num);

	//장바구니 주문량
	@Select("select count(*) FROM cart WHERE mem_num = ${mem_num}")
	public int OrdercartCount(int mem_num);
	
}
