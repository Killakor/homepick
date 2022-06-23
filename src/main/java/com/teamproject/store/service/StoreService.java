package com.teamproject.store.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import com.teamproject.store.bean.StoreDTO;

public interface StoreService {

	/* 상품 정보 */
	//상품 등록
	public void productRegister(StoreDTO storeDTO);
	
	//상품 리스트
	public List<StoreDTO> selectList(Map<String, Object> map);
	
	//상품 갯수
	public int selectRowCount(Map<String, Object> map);
	
	//상품 정보
	public StoreDTO selectProduct(Integer prod_num);
	
	//상품 수정
	public void updateProduct(StoreDTO storeDTO);
	
	//상품 썸네일 삭제
	public void deleteThumbnail(Integer prod_num);
	
	//상품 삭제
	public void deleteProduct(Integer prod_num);
	
	//리뷰 삭제
	public void deleteReview(Integer prod_num);
	
	
	/* 통합 검색 */
	//통합검색 결과 조회되는 상품 리스트
	public int selectStoreAllSearchRowCount(Map<String, Object> map);
	
	//통합검색 결과 조회되는 상품 갯수
	public List<StoreDTO> selectStoreAllSearchList(Map<String, Object> map);
}
