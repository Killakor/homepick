package com.teamproject.houseBoard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.houseBoard.bean.HCommentDTO;
import com.teamproject.houseBoard.bean.HMarkDTO;
import com.teamproject.houseBoard.bean.HouseBoardDTO;

@Repository
public interface HouseBoardMapper {
	
	/* 집들이 게시물 정보 */
	//집들이 게시물 등록
	@Insert("INSERT INTO house_board (house_num,house_title,house_area,house_type,house_style,house_space,house_content,house_thumbnail,thumbnail_filename,mem_num)\r\n"
			+ "select case count(*) when 0 then 1 else max(house_num) + 1 end,#{house_title},#{house_area},#{house_type},#{house_style},#{house_space},#{house_content}, #{house_thumbnail},#{thumbnail_filename},#{mem_num} from house_board")
	public void insertHBoard(HouseBoardDTO houseBoard); 
	
	//집들이 게시물 상세보기
	@Select("SELECT * FROM house_board b JOIN mem_detail m ON b.mem_num = m.mem_num WHERE b.house_num = #{house_num}")
	public HouseBoardDTO selectHBoard(Integer house_num);
	
	//조회수 증가
	@Update("UPDATE house_board SET house_hits=house_hits+1 WHERE house_num = #{house_num}")
	public void updateHBoardHits(Integer house_num);
	
	//집들이 게시물 수정
	public void updateHBoard(HouseBoardDTO houseBoard);
	
	//집들이 게시물 수정 - 썸네일 삭제
	@Update("UPDATE house_board SET house_thumbnail = '', thumbnail_filename = '' WHERE house_num = #{house_num}")
	public void deleteFile(Integer house_num);
	
	//집들이 게시물 삭제
	@Delete("DELETE FROM house_board WHERE house_num = #{house_num}")
	public void deleteHBoard(Integer house_num);
	
	//집들이 리스트
	public List<HouseBoardDTO> selectHBoardList(Map<String, Object> map);
	
	//집들이 게시물 갯수
	public int selectRowCount(Map<String, Object> map);
	
	//집들이 내가 쓴 게시물 리스트
	public List<HouseBoardDTO> selectMyBoardList(Map<String, Object> map);
	
	//내가 쓴 게시물 갯수
	@Select("SELECT COUNT(*) FROM house_board b JOIN mem_detail m ON b.mem_num = m.mem_num WHERE m.mem_num = #{mem_num}")
	public int selectMyBoardRowCount(Integer mem_num); 
	
		
	
	/* 댓글 */
	//댓글 등록
	@Insert("INSERT INTO comments (comm_num, comm_reg_date, comm_mod_date, comm_content,house_num,mem_num) select case count(*) when 0 then 1 else max(comm_num) + 1 end,now(),now(),#{comm_content},#{house_num},#{mem_num} from comments")
	public void insertComm(HCommentDTO hComment);
	
	//댓글 수정
	@Update("UPDATE comments SET comm_content = #{comm_content},comm_mod_date=now() WHERE comm_num = #{comm_num}")
	public void updateComm(HCommentDTO hComment);
	
	//댓글 삭제
	@Delete("DELETE FROM comments WHERE comm_num = #{comm_num}")
	public void deleteComm(Integer comm_num);
	
	//댓글 리스트
	public List<HCommentDTO> selectListComm(Map<String, Object> map);
	
	//댓글 갯수(Map)
	public int selectRowCountComm(Map<String, Object> map);
	
	//댓글 갯수
	@Select("SELECT COUNT(*) FROM comments WHERE house_num = #{house_num}")
	public int countComm(Integer house_num);
	
	//게시물 삭제 전, 댓글 먼저 삭제 후 해당 집들이 번호의 글 삭제
	@Delete("DELETE FROM comments WHERE house_num = #{house_num}")
	public void deleteCommByHouseNum(Integer house_num);
	
	
	
	/* 추천 */
	//추천 추가
	@Insert("INSERT INTO recommend (house_num, mem_num) VALUES (#{house_num},#{mem_num})")
	public void insertHeart(HMarkDTO hMark);
	
	//추천 제거
	@Delete("DELETE FROM recommend WHERE house_num = #{house_num} AND mem_num = #{mem_num}")
	public void deleteHeart(HMarkDTO hMark);
	
	//추천수
	@Select("SELECT COUNT(*) FROM recommend WHERE house_num = #{house_num}")
	public int countHeart(Integer house_num);
	
	//추천 중복 체크
	@Select("SELECT mem_num FROM recommend WHERE house_num = #{house_num} AND mem_num = #{mem_num}")
	public String checkHeart(HMarkDTO hMark);
	
	//게시물 삭제 전, 추천 먼저 삭제 후 해당 집들이 번호의 글 삭제
	@Delete("DELETE FROM recommend WHERE house_num = #{house_num}")
	public void deleteHeartByHouseNum(Integer house_num);
	
	
	
	/* 스크랩 */
	//스크랩 추가
	@Insert("INSERT INTO scrapbook (scrap_num,house_num,mem_num) select case count(*) when 0 then 1 else max(scrap_num) + 1 end,#{house_num},#{mem_num} from scrapbook")
	public void insertScrap(HMarkDTO hMark);
	
	//스크랩 제거
	@Delete("DELETE FROM scrapbook WHERE house_num = #{house_num} AND mem_num = #{mem_num}")
	public void deleteScrap(HMarkDTO hMark);
	
	//스크랩수
	@Select("SELECT COUNT(*) FROM scrapbook WHERE house_num = #{house_num}")
	public int countScrap(Integer house_num);
	
	//스크랩 중복 체크
	@Select("SELECT mem_num FROM scrapbook WHERE house_num = #{house_num} AND mem_num = #{mem_num}")
	public String checkScrap(HMarkDTO hMark);
	
	//게시물 삭제 전, 댓글/추천/스크랩 먼저 삭제 후 해당 집들이 번호의 글 삭제
	@Delete("DELETE FROM scrapbook WHERE house_num = #{house_num}")
	public void deleteScrapByHouseNum(Integer house_num);
	
	
	
	/* 통합 검색 */
	//통합검색 결과 조회되는 집들이 게시물 갯수
	public int selectAllSearchRowCount(Map<String, Object> map);
	
	//통합검색 결과 조회되는 집들이 게시물 리스트
	public List<HouseBoardDTO> selectAllSearchList(Map<String, Object> map);
		
}

