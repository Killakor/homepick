package com.teamproject.houseBoard.service;

import java.util.List;
import java.util.Map;

import com.teamproject.houseBoard.bean.HCommentDTO;
import com.teamproject.houseBoard.bean.HMarkDTO;
import com.teamproject.houseBoard.bean.HouseBoardDTO;

public interface HouseBoardService {

	/* 집들이 게시물 정보 */
	//집들이 게시물 등록
	public void insertHBoard(HouseBoardDTO houseBoard);
	
	//집들이 게시물 상세보기	
	public HouseBoardDTO selectHBoard(Integer house_num);
	
	//조회수 증가
	public void updateHBoardHits(Integer house_num);
	
	//집들이 게시물 수정
	public void updateHBoard(HouseBoardDTO houseBoard);
	
	//집들이 게시물 수정 - 썸네일 삭제
	public void deleteFile(Integer house_num);
	
	//집들이 게시물 삭제
	public void deleteHBoard(Integer house_num);

	//집들이 리스트
	public List<HouseBoardDTO> selectHBoardList(Map<String, Object> map);
	
	//집들이 게시물 갯수
	public int selectRowCount(Map<String,Object> map);
	
	//집들이 내가 쓴 게시물 리스트
	public List<HouseBoardDTO> selectMyBoardList(Map<String, Object> map);
	
	//내가 쓴 게시물 갯수
	public int selectMyBoardRowCount(Integer mem_num);

	
	/* 댓글 */
	//댓글 등록
	public void insertComm(HCommentDTO hComment);
	
	//댓글 수정
	public void updateComm(HCommentDTO hComment);
	
	//댓글 삭제
	public void deleteComm(Integer comm_num);
	
	//댓글 리스트
	public List<HCommentDTO> selectListComm(Map<String, Object> map);
	
	//댓글 갯수(Map)
	public int selectRowCountComm(Map<String, Object> map);
	
	//댓글 갯수
	public int countComm(Integer house_num);

	
	/* 추천 */
	//추천 추가
	public void insertHeart(HMarkDTO hMark);
	
	//추천 제거
	public void deleteHeart(HMarkDTO hMark);
	
	//추천수
	public int countHeart(Integer house_num);
	
	//추천 중복 체크
	public String checkHeart(HMarkDTO hMark);

	
	/* 스크랩 */
	//스크랩 추가
	public void insertScrap(HMarkDTO hMark);
	
	//스크랩 제거
	public void deleteScrap(HMarkDTO hMark);
	
	//스크랩수
	public int countScrap(Integer house_num);
	
	//스크랩 중복 체크
	public String checkScrap(HMarkDTO hMark);

	
	/* 통합 검색 */
	//통합검색 결과 조회되는 집들이 게시물 갯수
	public int selectAllSearchRowCount(Map<String, Object> map);
	
	//통합검색 결과 조회되는 집들이 게시물 리스트
	public List<HouseBoardDTO> selectAllSearchList(Map<String, Object> map);
	
}
