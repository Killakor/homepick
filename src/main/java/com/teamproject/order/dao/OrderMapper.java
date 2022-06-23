package com.teamproject.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

import com.teamproject.order.bean.OrderDTO;

@Repository
public interface OrderMapper {

	//주문 등록
	@Insert("INSERT INTO orders(order_num, order_date, order_zipcode, order_address1, order_address2, receiver_name, receiver_phone, mem_num, prod_num, pay_quan, pay_price, buis_name, receiver_email) \r\n"
			+ "select case count(*) when 0 then 1 else max(order_num) + 1 end, now(), #{order_zipcode}, #{order_address1}, #{order_address2}, \r\n"
			+ "#{receiver_name}, #{receiver_phone}, #{mem_num}, #{prod_num}, #{pay_quan}, #{pay_price}, #{buis_name}, #{receiver_email} from orders")
	public void insertOrder(OrderDTO orderDTO);
	
	//비회원 주문 조회(비회원)
	public List<OrderDTO> selectNonList(Map<String, Object> map);
	
	//전화번호 데이터를 통한 주문정보 확인(비회원)
	public int selectNonRowCount(Map<String, Object> map);

	//주문 내역 조회(회원)
	public List<OrderDTO> selectList(Map<String, Object> map);
	
	//회원 번호 데이터를 통한 주문정보 확인(회원)
	public int selectRowCount(Map<String, Object> map);

}
