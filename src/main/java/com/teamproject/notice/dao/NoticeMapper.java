package com.teamproject.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.notice.bean.NoticeDTO;

@Repository
public interface NoticeMapper {
	
	//공지사항 등록
	@Insert("INSERT INTO notice (notice_num,notice_title,notice_content,notice_reg_date,notice_hits,mem_num) select case count(*) when 0 then 1 else max(notice_num) + 1 end,#{notice_title},#{notice_content},now(),1,#{mem_num} from notice")
	public void noticeWrite(NoticeDTO noticeDTO);
	
	//공지사항 갯수
	@Select("SELECT COUNT(*) FROM notice")
	public int noticeTotalCount();
	
	//공지사항 조회 수 설정
	@Update("UPDATE notice SET notice_hits=notice_hits+1 WHERE notice_num=#{notice_num}")
	public int noticeHitCount(int notice_num);
	
	//공지사항 상세보기
	@Select("SELECT * FROM notice where notice_num=#{notice_num}")
	public NoticeDTO noticeDetail(int notice_num);
	
	//공지사항 수정
	@Update("UPDATE notice SET notice_title=#{notice_title},notice_content=#{notice_content} WHERE notice_num=#{notice_num}")
	public void noticeUpdate(NoticeDTO noticeDTO);
	
	//공지사항 삭제
	@Delete("DELETE FROM notice WHERE notice_num=#{notice_num}")
	public void noticeDelete(int notice_num);
	
	//공지사항 리스트
	@Select("SELECT * FROM (SELECT @rownum:=@rownum+1 rnum, a.* FROM (SELECT * FROM notice ORDER BY notice_reg_date DESC) a, (SELECT @ROWNUM := 0) R WHERE 1=1) list WHERE rnum >= #{start} AND rnum <= #{end}")
	public List<NoticeDTO> noticeGetList(Map<String, Object> map);
	
}
