package com.teamproject.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.order.bean.OrderDTO;
import com.teamproject.order.dao.OrderMapper;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderDAO;
	
	@Override
	public void insertOrder(OrderDTO orderDTO) {
		orderDAO.insertOrder(orderDTO);
	}

	@Override
	public List<OrderDTO> selectNonList(Map<String, Object> map) {
		return orderDAO.selectNonList(map);
	}

	@Override
	public int selectNonRowCount(Map<String, Object> map) {
		return orderDAO.selectNonRowCount(map);
	}

	@Override
	public List<OrderDTO> selectList(Map<String, Object> map) {
		return orderDAO.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return orderDAO.selectRowCount(map);
	}

}
