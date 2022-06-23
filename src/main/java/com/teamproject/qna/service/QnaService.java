package com.teamproject.qna.service;

import java.util.List;
import java.util.Map;

import com.teamproject.qna.bean.QnaDTO;

public interface QnaService {
	
	//QnA 등록
	public void qnaInsert(QnaDTO qna);
	
	//QnA 리스트[고객센터 - 사용자 페이지]
	public List<QnaDTO> getQnaList(Map<String,Object> map);
	
	//QnA 리스트[자주묻는설정 - 관리자 페이지]
	public List<QnaDTO> getQnaServiceList(Map<String,Object> map);
	
	//QnA 상세보기
	public QnaDTO getQna(int num);
	
	//QnA 수정
	public void qnaUpdate(QnaDTO qna);
	
	//QnA 삭제
	public void qnaDelete(int num);
	
	//QnA 키워드별 갯수
	public int getQnaCount(Map<String, Object> map);
	
	//QnA 총 갯수
	public int getQnaServiceCount();
}
