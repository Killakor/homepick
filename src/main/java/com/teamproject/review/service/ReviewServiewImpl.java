package com.teamproject.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.review.bean.ReviewDTO;
import com.teamproject.review.dao.ReviewMapper;

@Service
@Transactional
public class ReviewServiewImpl implements ReviewService {
	
	@Autowired
		private ReviewMapper reviewDAO;

	
	@Override
	public void reviewInsert(ReviewDTO review) {
		reviewDAO.reviewInsert(review);
	}

	@Override
	public ReviewDTO reviewDetail(int rev_num) {
		return reviewDAO.reviewDetail(rev_num);
	}

	@Override
	public void reviewUpdate(ReviewDTO review) {
		reviewDAO.reviewUpdate(review);
	}

	@Override
	public void reviewDelete(int rev_num) {
		reviewDAO.reviewDelete(rev_num);
	}

	@Override
	public int reviewMyCount(int mem_num) {
		return reviewDAO.reviewMyCount(mem_num);
	}

	@Override
	public int reviewStoreCount(int prod_num) {
		return reviewDAO.reviewStoreCount(prod_num);
	}

	@Override
	public List<ReviewDTO> reviewbuyList(int mem_num) {
		return reviewDAO.reviewbuyList(mem_num);
	}

	@Override
	public List<ReviewDTO> reviewList(int mem_num) {
		return reviewDAO.reviewList(mem_num);
	}

	@Override
	public List<ReviewDTO> reviewListStore(int prod_num) {
		return reviewDAO.reviewListStore(prod_num);
	}

	@Override
	public int reviewExist(int mem_num, int prod_num) {
		return reviewDAO.reviewExist(mem_num, prod_num);
	}

	@Override
	public int orderExist(int mem_num, int prod_num) {
		return reviewDAO.orderExist(mem_num, prod_num);
	}

	@Override
	public int reviewBuyCount(int mem_num) {
		return reviewDAO.reviewBuyCount(mem_num);
	}

	@Override
	public ReviewDTO productDetail(int prod_num) {
		return reviewDAO.productDetail(prod_num);
	}

	@Override
	public void deleteFile(int rev_num) {
		reviewDAO.deleteFile(rev_num);
	}

	@Override
	public ReviewDTO reviewImgStore(int prod_num) {
		return reviewDAO.reviewImgStore(prod_num);
	}

	@Override
	public Integer staravg(int prod_num) {
		return reviewDAO.staravg(prod_num);
	}
	
}
