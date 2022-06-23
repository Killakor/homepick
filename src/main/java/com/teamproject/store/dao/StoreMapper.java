package com.teamproject.store.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.store.bean.StoreDTO;

@Repository
public interface StoreMapper {
	
	/* 상품 정보 */
	//상품 등록
	@Insert("INSERT INTO product(prod_num, prod_name, prod_price, delive_price, delive_type, selec_product, \r\n"
			+ "prod_option1, prod_option2, prod_option3, prod_option4, prod_option5, prod_option6, prod_option7, prod_option8, prod_option9, prod_option10,\r\n"
			+ "prod_content, thumbnail_img, thumbnail_filename, prod_quan, prod_keyword, mem_num, prod_cate)\r\n"
			+ "select case count(*) when 0 then 1 else max(prod_num) + 1 end, #{prod_name}, #{prod_price}, #{delive_price}, #{delive_type}, #{selec_product}, \r\n"
			+ "#{prod_option1}, #{prod_option2}, #{prod_option3}, #{prod_option4}, #{prod_option5}, #{prod_option6}, #{prod_option7}, #{prod_option8}, #{prod_option9}, #{prod_option10}, \r\n"
			+ "#{prod_content}, #{thumbnail_img}, #{thumbnail_filename}, #{prod_quan}, #{prod_keyword}, #{mem_num}, #{prod_cate} from product")
	public void productRegister(StoreDTO storeDTO);
	
	//상품 리스트
	public List<StoreDTO> selectList(Map<String, Object> map);
	
	//상품 갯수
	public int selectRowCount(Map<String, Object> map);
	
	//상품 정보
	@Select("SELECT * FROM product p JOIN member m ON p.mem_num = m.mem_num JOIN buis_detail d ON d.mem_num = m.mem_num WHERE p.prod_num = #{prod_num}")
	public StoreDTO selectProduct(Integer prod_num);
	
	//상품 수정
	public void updateProduct(StoreDTO storeDTO);
	
	//상품 썸네일 삭제
	@Update("UPDATE product SET thumbnail_img = '', thumbnail_filename = '' WHERE prod_num = #{prod_num}")
	public void deleteThumbnail(Integer prod_num);
	
	//상품 삭제
	@Delete("DELETE FROM product WHERE prod_num = #{prod_num}")
	public void deleteProduct(Integer prod_num);
	
	//장바구니 삭제
	@Delete("DELETE FROM cart WHERE prod_num = #{prod_num}")
	public void deleteCart(Integer prod_num);
	
	//리뷰 삭제
	@Delete("DELETE FROM product_review WHERE prod_num = #{prod_num}")
	public void deleteReview(Integer prod_num);
	
	
	/* 통합 검색 */
	//통합검색 결과 조회되는 상품 리스트
	public List<StoreDTO> selectStoreAllSearchList(Map<String, Object> map);		
	
	//통합검색 결과 조회되는 상품 갯수
	public int selectStoreAllSearchRowCount(Map<String, Object> map);

}
