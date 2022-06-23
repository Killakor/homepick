package com.teamproject.order.service;

import java.util.List;
import java.util.Map;

import com.teamproject.order.bean.OrderDTO;

public interface OrderService {
	
	//주문 등록
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
