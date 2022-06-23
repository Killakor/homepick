package com.teamproject.event.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.teamproject.event.bean.ECommentDTO;
import com.teamproject.event.bean.EventDTO;
import com.teamproject.event.dao.EventMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class EventServiceImpl implements EventService{

	@Autowired
	private EventMapper eventDAO;
	
	@Override
	public void eventWrite(EventDTO event) {
		eventDAO.eventWrite(event);
	}

	@Override
	public EventDTO eventDetail(int event_num) {
		return eventDAO.eventDetail(event_num);
	}

	@Override
	public int eventTotalCount() {
		return eventDAO.eventTotalCount();
	}
	
	@Override
	public void eventUpdate(EventDTO event) {
		eventDAO.eventUpdate(event);
	}
	
	@Override
	public void eventDelete(int event_num) {
		//삭제 전 댓글 먼저 삭제 후 해당 게시물 번호의 글 삭제
		eventDAO.deleteECommentByEventNum(event_num);
		eventDAO.eventDelete(event_num);
	}
	
	@Override
	public List<EventDTO> eventGetList(Map<String, Object> map) {
		return eventDAO.eventGetList(map);
	}
	
	@Override
	public int eventGetHits(int event_num) {
		return eventDAO.eventGetHits(event_num);
	}
	
	@Override
	public void deleteFile(Integer event_num) {
		eventDAO.deleteFile(event_num);
	}
	
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return eventDAO.selectRowCount(map);
	}

	@Override
	public List<ECommentDTO> selectListEComment(Map<String, Object> map) {
		return eventDAO.selectListEComment(map);
	}
	
	@Override
	public int selectRowCountComment(Map<String, Object> map) {
		return eventDAO.selectRowCountComment(map);
	}
	
	@Override
	public void insertEComment(ECommentDTO eComment) {
		eventDAO.insertEComment(eComment);
	}
	
	@Override
	public void updateEComment(ECommentDTO eComment) {
		eventDAO.updateEComment(eComment);
	}
	
	@Override
	public void deleteEComment(Integer comm_num) {
		eventDAO.deleteEComment(comm_num);
	}

	@Override
	public int selectEventAllSearchRowCount(Map<String, Object> map) {
		return eventDAO.selectEventAllSearchRowCount(map);
	}

	@Override
	public List<EventDTO> selectEventAllSearchList(Map<String, Object> map) {
		return eventDAO.selectEventAllSearchList(map);
	}


}
