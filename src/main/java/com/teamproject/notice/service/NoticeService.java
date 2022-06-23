package com.teamproject.notice.service;

import java.util.List;
import java.util.Map;

import com.teamproject.notice.bean.NoticeDTO;

public interface NoticeService {
	
	//공지사항 등록
	public void noticeWrite(NoticeDTO notice);
	
	//공지사항 갯수
	public int noticeTotalCount();
	
	//공지사항 조회 수 설정
	public int noticeHitCount(int notice_num);
	
	//공지사항 상세보기
	public NoticeDTO noticeDetail(int notice_num);
	
	//공지사항 수정
	public void noticeUpdate(NoticeDTO notice);
	
	//공지사항 삭제
	public void noticeDelete(int notice_num);
	
	//공지사항 리스트
	public List<NoticeDTO> noticeGetList(Map<String, Object> map);
}
