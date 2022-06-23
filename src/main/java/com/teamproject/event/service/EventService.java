package com.teamproject.event.service;

import java.util.List;
import java.util.Map;

import com.teamproject.event.bean.ECommentDTO;
import com.teamproject.event.bean.EventDTO;

public interface EventService {
	
	/* 이벤트 정보 */
	//이벤트 등록
	public void eventWrite(EventDTO eventDTO);
	
	//이벤트 수정
	public void eventUpdate(EventDTO eventDTO);
	
	//이벤트 수정 - 썸네일 삭제
	public void deleteFile(Integer event_num);
	
	//이벤트 삭제
	public void eventDelete(int event_num);
	
	//이벤트 갯수(Map)
	public int selectRowCount(Map<String, Object> map);

	//이벤트 리스트
	public List<EventDTO> eventGetList(Map<String, Object> map);
	
	//이벤트 상세보기
	public EventDTO eventDetail(int event_num);
	
	//이벤트 갯수
	public int eventTotalCount();
	
	//이벤트 조회수
	public int eventGetHits(int event_num);

	
	/* 댓글 */
	//댓글 등록
	public void insertEComment(ECommentDTO eComment);
	
	//댓글 수정
	public void updateEComment(ECommentDTO eComment);
	
	//댓글 삭제
	public void deleteEComment(Integer comm_num);
	
	//댓글 리스트
	public List<ECommentDTO> selectListEComment(Map<String, Object>map);
	
	//댓글 갯수(Map)
	public int selectRowCountComment(Map<String, Object>map);

	
	/* 통합 검색 */
	//통합검색 결과 조회되는 이벤트 게시물 갯수
	public int selectEventAllSearchRowCount(Map<String, Object> map);
	
	//통합검색 결과 조회되는 이벤트 게시물 리스트
	public List<EventDTO> selectEventAllSearchList(Map<String, Object> map);
	
}
