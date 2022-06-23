package com.teamproject.event.dao;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.event.bean.ECommentDTO;
import com.teamproject.event.bean.EventDTO;

@Repository
public interface EventMapper {
	
	/* 이벤트 정보 */
	//이벤트 등록
	@Insert("INSERT INTO event (event_num,event_title,event_content,event_type,event_day,event_hits,event_reg_date,event_modi,mem_num,event_filename,event_photo) \r\n"
			+ "select case count(*) when 0 then 1 else max(event_num) + 1 end,#{event_title},#{event_content},#{event_type},#{event_day},1,now(),now(),#{mem_num},#{event_filename},#{event_photo} from event")
	public void eventWrite(EventDTO eventDTO);
	
	//이벤트 수정
	public void eventUpdate(EventDTO eventDTO);
	
	//이벤트 수정 - 썸네일 삭제
	@Update("UPDATE event SET event_filename = '', event_photo = '' WHERE event_num = #{event_num}")
	public void deleteFile(Integer event_num);
	
	//이벤트 삭제
	@Delete("DELETE FROM event WHERE event_num=#{event_num}")
	public void eventDelete(int event_num);
	
	//이벤트 갯수(Map)
	public int selectRowCount(Map<String, Object> map);
	
	//이벤트 리스트
	public List<EventDTO> eventGetList(Map<String, Object> map);
	
	//이벤트 상세보기
	@Select("SELECT * FROM event b JOIN mem_detail m ON b.mem_num=m.mem_num WHERE b.event_num=#{event_num}")
	public EventDTO eventDetail(int event_num);

	//이벤트 갯수
	@Select("select count(*) from event")
	public int eventTotalCount();
	
	//이벤트 조회수
	@Update("UPDATE event SET event_hits=event_hits+1 WHERE event_num=#{event_num}")
	public int eventGetHits(int event_num);
	

	
	/* 댓글 */
	//댓글 등록
	@Insert("INSERT INTO comments (comm_num, comm_reg_date, comm_mod_date, comm_content, event_num, mem_num) select case count(*) when 0 then 1 else max(comm_content) + 1 end,now(),now(),#{comm_content},#{event_num},#{mem_num} from comments")
	public void insertEComment(ECommentDTO eComment);
	
	//댓글 수정
	@Update("UPDATE comments SET comm_content=#{comm_content},comm_mod_date=now() WHERE comm_num=#{comm_num}")
	public void updateEComment(ECommentDTO eComment);
	
	//댓글 삭제
	@Delete("DELETE FROM comments WHERE comm_num=#{comm_num}")
	public void deleteEComment(Integer comm_num);
	
	//댓글 리스트
	public List<ECommentDTO> selectListEComment(Map<String, Object>map);
	
	//댓글 갯수(Map)
	public int selectRowCountComment(Map<String, Object>map);
	
	//게시물 삭제 전, 댓글 먼저 삭제 후 해당 이벤트 번호의 글 삭제
	@Delete("DELETE FROM comments WHERE event_num=#{event_num}")
	public void deleteECommentByEventNum(Integer event_num);

	
	
	/* 통합 검색 */
	//통합검색 결과 조회되는 이벤트 게시물 갯수
	public int selectEventAllSearchRowCount(Map<String,Object> map);
	
	//통합검색 결과 조회되는 이벤트 게시물 리스트
	public List<EventDTO> selectEventAllSearchList(Map<String,Object> map);
	
}
