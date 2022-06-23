package com.teamproject.serviceBoard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.serviceBoard.bean.ServiceBoardDTO;

@Repository
public interface ServiceBoardMapper {  

	//고객문의 등록
	@Insert("INSERT INTO service_board (service_num, service_title, service_nickname, service_content, service_email, service_keyword, service_filename, service_file)\r\n"
			+ "select case count(*) when 0 then 1 else max(service_num) + 1 end, #{service_title}, #{service_nickname}, #{service_content}, #{service_email},#{service_keyword}, #{service_filename},#{service_file} from service_board")
	public void serviceBoardInsert(ServiceBoardDTO serviceboard);
	
	//고객문의 갯수
	@Select("SELECT COUNT(*) FROM service_board")
	public int getServiceBoardCount();
	
	//검색 조회되는 고객문의 갯수
	public int selectRowCount(Map<String, Object> map);
	
	//고객문의 리스트
	public List<ServiceBoardDTO> getServiceBoardList(Map<String, Object> map);
	
	//고객문의 정보
	@Select("SELECT * FROM service_board WHERE service_num = #{service_num}")
	public ServiceBoardDTO getServiceBoard(int service_num);
	
	//고객문의 수정
	@Update("UPDATE service_board SET service_title=#{service_title},service_content=#{service_content},service_keyword=#{service_keyword},service_file=#{service_file} WHERE service_num=#{service_num}")
	public void serviceBoardUpdate(ServiceBoardDTO serviceboard);
	
	//고객문의 삭제
	@Delete("DELETE FROM service_board WHERE service_num = #{service_num}")
	public void serviceBoardDelete(int service_num);
	
    
}
