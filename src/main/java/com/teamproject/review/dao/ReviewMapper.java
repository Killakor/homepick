package com.teamproject.review.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.review.bean.ReviewDTO;

@Repository
public interface ReviewMapper {
	//리뷰 등록
	@Insert("INSERT INTO product_review(rev_num, rev_content, rev_grade, rev_reg_date, rev_img, rev_filename, prod_num, mem_num)\r\n"
			+ "select case count(*) when 0 then 1 else max(rev_num) + 1 end, #{rev_content}, #{rev_grade}, now(), #{rev_img}, #{rev_filename}, #{prod_num}, #{mem_num} from product_review")
	public void reviewInsert(ReviewDTO review);
	
	//리뷰 조회
	@Select("SELECT r.rev_num, r.rev_content, r.rev_grade, DATE_FORMAT(r.rev_reg_date,'%Y-%m-%d')as rev_reg_date, r.rev_img, r.rev_filename, r.prod_num, r.mem_num, m.mem_name, p.prod_price, p.prod_name, p.prod_num, p.thumbnail_img, p.thumbnail_filename FROM product_review r, mem_detail m, product p WHERE m.mem_num=r.mem_num AND r.prod_num = p.prod_num AND r.rev_num=${rev_num}")
	public ReviewDTO reviewDetail(@Param("rev_num")int rev_num);

	//리뷰 수정
	@Update("UPDATE product_review SET rev_content = #{rev_content}, rev_grade=#{rev_grade}, rev_filename =#{rev_filename}, rev_img = #{rev_img} WHERE rev_num = #{rev_num}")
	public void reviewUpdate(ReviewDTO review);
	
	//리뷰 삭제
	@Delete("DELETE FROM product_review WHERE rev_num = #{rev_num}")
	public void reviewDelete(int rev_num);
	
	//구매 제품이력 리스트
	@Select("SELECT o.prod_num as prod_num, p.prod_name as prod_name, p.prod_option1 as prod_option1, o.order_date as order_date, o.buis_name as buis_name , p.prod_price as prod_price  FROM orders o, product p WHERE  p.prod_num = o.prod_num AND o.mem_num = ${mem_num} ORDER BY o.order_date")
	public List<ReviewDTO> reviewbuyList(@Param("mem_num")int mem_num);
	
	//리뷰 리스트
	@Select("SELECT r.rev_num, r.rev_content, r.rev_grade, DATE_FORMAT(r.rev_reg_date,'%Y-%m-%d')as rev_reg_date,"
			+ " r.rev_img, r.rev_filename, r.prod_num, r.mem_num, m.mem_name,  p.prod_price, p.prod_name, p.prod_num, p.thumbnail_img, p.thumbnail_filename "
			+ "FROM product_review r, mem_detail m, product p WHERE m.mem_num=r.mem_num AND r.prod_num = p.prod_num  AND r.mem_num=${mem_num}")
	public List<ReviewDTO> reviewList(@Param("mem_num")int mem_num);
	
	//스토어 내 리뷰 리스트
	@Select("SELECT r.rev_num, r.rev_content, r.rev_grade, DATE_FORMAT(r.rev_reg_date,'%Y-%m-%d')as rev_reg_date, r.rev_img, r.rev_filename, r.prod_num, r.mem_num, m.mem_name FROM product_review r, mem_detail m WHERE m.mem_num=r.mem_num AND prod_num =${prod_num}")
	public List<ReviewDTO> reviewListStore(@Param("prod_num")int prod_num);
	
	//나의 리뷰 갯수
	@Select("SELECT count(*) FROM product_review WHERE mem_num=#{mem_num}")
	public int reviewMyCount(int mem_num);
	
	//구매이력 리뷰 갯수
	@Select("SELECT COUNT(*) FROM orders o WHERE mem_num = #{mem_num}")
	public int reviewBuyCount(int mem_num);
	
	//상품 리뷰 총 갯수
	@Select("SELECT count(*) FROM product_review WHERE prod_num=#{prod_num}")
	public int reviewStoreCount(int prod_num);

	//리뷰 데이터 검증
	@Select("select count(*) FROM product_review WHERE mem_num = #{mem_num} AND prod_num= #{prod_num}")
	public int reviewExist(@Param("mem_num")int mem_num, @Param("prod_num")int prod_num);
	
	//주문 데이터 검증
	@Select("SELECT COUNT(*) FROM orders o WHERE mem_num =#{mem_num} AND prod_num =#{prod_num}")
	public int orderExist(@Param("mem_num")int mem_num,@Param("prod_num") int prod_num);
	
	//리뷰 등록 폼 호출
	@Select("select p.prod_name as prod_name, p.prod_price as prod_price, b.buis_name as buis_name, p.thumbnail_img as thumbnail_img, p.thumbnail_filename as thumbnail_filename FROM product p, buis_detail b WHERE p.mem_num = b.mem_num AND prod_num=${prod_num}")
	public ReviewDTO productDetail(@Param("prod_num")int prod_num);
	
	//리뷰 수정 시 이미지 삭제
	@Update("UPDATE product_review SET rev_filename = '', rev_img = '' WHERE rev_num = #{rev_num}")
	public void deleteFile(@Param("rev_num")int rev_num);
	
	//리뷰 이미지
	@Select("SELECT rev_filename, rev_img, p.thumbnail_img, p.thumbnail_filename FROM product_review r, product p WHERE r.prod_num=p.prod_num AND rev_num = ${rev_num}")
	public ReviewDTO reviewImgStore(@Param("rev_num")int rev_num);
	
	//리뷰점수 평균값
	@Select("SELECT ROUND(AVG(rev_grade),2) as star FROM product_review WHERE prod_num = #{prod_num}")
	public Integer staravg(int prod_num);
}
