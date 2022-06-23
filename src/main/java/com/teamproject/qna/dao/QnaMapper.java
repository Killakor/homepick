package com.teamproject.qna.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.qna.bean.QnaDTO;

@Repository
public interface QnaMapper {

	//QnA 등록
	@Insert("INSERT INTO qna_list (qna_num, qna_category, qna_content, qna_reply) select case count(*) when 0 then 1 else max(qna_num) + 1 end, #{qna_category}, #{qna_content}, #{qna_reply} from qna_list")
	public void qnaInsert(QnaDTO qna);

	//QnA 키워드별 갯수
	public int getQnaCount(Map<String, Object> map);
	
	//QnA 총 갯수
	@Select("SELECT COUNT(*) FROM qna_list")
	public int getQnaServiceCount();
	
	//QnA 리스트[고객센터 - 사용자 페이지]
	public List<QnaDTO> getQnaList(Map<String, Object> map);
	
	//QnA 리스트[자주묻는설정 - 관리자 페이지]
	@Select("SELECT * FROM (SELECT @rownum:=@rownum+1  rnum, a.* FROM (SELECT * FROM qna_list ORDER BY qna_num DESC) a, (SELECT @ROWNUM := 0) R WHERE 1=1) list WHERE rnum >= #{start} AND rnum <= #{end}")
	public List<QnaDTO> getQnaServiceList(Map<String, Object> map);
	
	//QnA 상세보기
	@Select("SELECT * FROM qna_list WHERE qna_num = #{qna_num}")
	public QnaDTO getQna(int num);
	
	//QnA 수정
	@Update("UPDATE qna_list SET qna_content=#{qna_content},qna_category=#{qna_category},qna_reply=#{qna_reply} WHERE qna_num=#{qna_num}")
	public void qnaUpdate(QnaDTO qna);
	
	//QnA 삭제
	@Delete("DELETE FROM qna_list WHERE qna_num = #{qna_num}")
	public void qnaDelete(int num);

	
}
