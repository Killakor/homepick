package com.teamproject.serviceBoard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.serviceBoard.bean.ServiceBoardDTO;
import com.teamproject.serviceBoard.dao.ServiceBoardMapper;

@Service
@Transactional
public class ServiceBoardServiceImpl implements ServiceBoardService {

	@Autowired
	private ServiceBoardMapper serviceBoardDAO;
	
	@Override
	public void serviceBoardInsert(ServiceBoardDTO serviceboard) {
		serviceBoardDAO.serviceBoardInsert(serviceboard);
	}

	@Override
	public int getServiceBoardCount() { 
		return serviceBoardDAO.getServiceBoardCount(); 
	}

	@Override
	public List<ServiceBoardDTO> getServiceBoardList(Map<String, Object> map) {
		return serviceBoardDAO.getServiceBoardList(map);
	}

	@Override
	public ServiceBoardDTO getServiceBoard(int service_num) {
		return serviceBoardDAO.getServiceBoard(service_num);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return serviceBoardDAO.selectRowCount(map);
	}

	@Override
	public void serviceBoardUpdate(ServiceBoardDTO serviceboard) {
		serviceBoardDAO.serviceBoardUpdate(serviceboard);
	}

	@Override
	public void serviceBoardDelete(int service_num) {
		serviceBoardDAO.serviceBoardDelete(service_num);
	}

}
