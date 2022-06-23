package com.teamproject.houseBoard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.houseBoard.bean.HCommentDTO;
import com.teamproject.houseBoard.bean.HMarkDTO;
import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.dao.HouseBoardMapper;

@Service
@Transactional
public class HouseBoardServiceImpl implements HouseBoardService {
	
	@Autowired
	private HouseBoardMapper houseBoardDAO;
	
	@Override
	public List<HouseBoardDTO> selectHBoardList(Map<String, Object> map) {
		return houseBoardDAO.selectHBoardList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return houseBoardDAO.selectRowCount(map);
	}

	@Override
	public void insertHBoard(HouseBoardDTO houseBoard) {
		houseBoardDAO.insertHBoard(houseBoard);
	}

	@Override
	public HouseBoardDTO selectHBoard(Integer house_num) {
		return houseBoardDAO.selectHBoard(house_num);
	}

	@Override
	public void updateHBoardHits(Integer house_num) {
		houseBoardDAO.updateHBoardHits(house_num);
	}
	
	@Override
	public void updateHBoard(HouseBoardDTO houseBoard) {
		houseBoardDAO.updateHBoard(houseBoard);
	}
	
	@Override
	public void deleteHBoard(Integer house_num) {
		//삭제 전 댓글/추천/스크랩 먼저 삭제 후 해당 게시물 번호의 글 삭제
		houseBoardDAO.deleteCommByHouseNum(house_num);
		houseBoardDAO.deleteHeartByHouseNum(house_num);
		houseBoardDAO.deleteScrapByHouseNum(house_num);
		houseBoardDAO.deleteHBoard(house_num);
	}
	
	@Override
	public void deleteFile(Integer house_num) {
		houseBoardDAO.deleteFile(house_num);	
	}
	
	@Override
	public List<HouseBoardDTO> selectMyBoardList(Map<String, Object> map) {
		return houseBoardDAO.selectMyBoardList(map);
	}

	@Override
	public int selectMyBoardRowCount(Integer mem_num) {
		return houseBoardDAO.selectMyBoardRowCount(mem_num);
	}
	
	@Override
	public List<HCommentDTO> selectListComm(Map<String, Object> map) {
		return houseBoardDAO.selectListComm(map);
	}

	@Override
	public int selectRowCountComm(Map<String, Object> map) {
		return houseBoardDAO.selectRowCountComm(map);
	}
	
	@Override
	public int countComm(Integer house_num) {
		return houseBoardDAO.countComm(house_num);
	}

	@Override
	public void insertComm(HCommentDTO hComment) {
		houseBoardDAO.insertComm(hComment);
	}

	@Override
	public void updateComm(HCommentDTO hComment) {
		houseBoardDAO.updateComm(hComment);
	}

	@Override
	public void deleteComm(Integer comm_num) {
		houseBoardDAO.deleteComm(comm_num);
	}
	
	@Override
	public int countHeart(Integer house_num) {
		return houseBoardDAO.countHeart(house_num);
	}

	@Override
	public String checkHeart(HMarkDTO hMark) {
		return houseBoardDAO.checkHeart(hMark);
	}

	@Override
	public void insertHeart(HMarkDTO hMark) {
		houseBoardDAO.insertHeart(hMark);
	}

	@Override
	public void deleteHeart(HMarkDTO hMark) {
		houseBoardDAO.deleteHeart(hMark);
	}
	
	@Override
	public int countScrap(Integer house_num) {
		return houseBoardDAO.countScrap(house_num);
	}

	@Override
	public String checkScrap(HMarkDTO hMark) {
		return houseBoardDAO.checkScrap(hMark);
	}

	@Override
	public void insertScrap(HMarkDTO hMark) {
		houseBoardDAO.insertScrap(hMark);
		
	}

	@Override
	public void deleteScrap(HMarkDTO hMark) {
		houseBoardDAO.deleteScrap(hMark);
	}

	@Override
	public int selectAllSearchRowCount(Map<String, Object> map) {
		return houseBoardDAO.selectAllSearchRowCount(map);
	}

	@Override
	public List<HouseBoardDTO> selectAllSearchList(Map<String, Object> map) {
		return houseBoardDAO.selectAllSearchList(map);
	}
	
}
