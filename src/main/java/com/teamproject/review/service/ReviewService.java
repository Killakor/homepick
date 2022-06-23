package com.teamproject.review.service;

import java.util.List;

import com.teamproject.review.bean.ReviewDTO;

public interface ReviewService {
	
	//리뷰 등록
	public void reviewInsert(ReviewDTO review);
	
	//리뷰 조회
	public ReviewDTO reviewDetail(int rev_num);
	
	//리뷰 수정
	public void reviewUpdate(ReviewDTO review);
	
	//리뷰 삭제
	public void reviewDelete(int rev_num);
	
	//구매 제품이력 리스트
	public List<ReviewDTO> reviewbuyList(int mem_num);
	
	//리뷰 리스트
	public List<ReviewDTO> reviewList(int mem_num);
	
	//스토어 내 리뷰 리스트
	public List<ReviewDTO> reviewListStore(int prod_num);
	
	//나의 리뷰 갯수
	public int reviewMyCount(int mem_num);
	
	//구매이력 리뷰 갯수
	public int reviewBuyCount(int mem_num);
	
	//상품 리뷰 총 갯수
	public int reviewStoreCount(int prod_num);
	
	//리뷰 데이터 검증
	public int reviewExist(int mem_num, int prod_num);
	
	//주문 데이터 검증
	public int orderExist(int mem_num, int prod_num);
	
	//리뷰 등록 폼 호출
	public ReviewDTO productDetail(int prod_num);
	
	//리뷰 수정 시 이미지 삭제
	public void deleteFile(int rev_num);
	
	//리뷰 이미지
	public ReviewDTO reviewImgStore(int prod_num);
	
	//리뷰점수 평균값
	public Integer staravg(int prod_num);
}
