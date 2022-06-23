package com.teamproject.serviceBoard.service;

import java.util.List;
import java.util.Map;

import com.teamproject.serviceBoard.bean.ServiceBoardDTO;

public interface ServiceBoardService {
	
	//고객문의 등록
	public void serviceBoardInsert(ServiceBoardDTO serviceboard);
	
	//고객문의 갯수
	public int getServiceBoardCount();
	
	//검색 조회되는 고객문의 갯수
	public int selectRowCount(Map<String, Object> map);
	
	//고객문의 리스트
	public List<ServiceBoardDTO> getServiceBoardList(Map<String,Object> map);
	
	//고객문의 정보
	public ServiceBoardDTO getServiceBoard(int service_num);
	
	//고객문의 수정
	public void serviceBoardUpdate(ServiceBoardDTO serviceboard);
	
	//고객문의 삭제
	public void serviceBoardDelete(int service_num);
}
