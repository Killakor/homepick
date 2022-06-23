package com.teamproject.store.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.dao.StoreMapper;

@Service
@Transactional
public class StoreServiceImpl implements StoreService {

	@Autowired
	private StoreMapper storeDAO;
	
	@Override
	public void productRegister(StoreDTO storeDTO) {
		storeDAO.productRegister(storeDTO);
	}

	@Override
	public List<StoreDTO> selectList(Map<String, Object> map) {
		return storeDAO.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return storeDAO.selectRowCount(map);
	}

	@Override
	public StoreDTO selectProduct(Integer prod_num) {
		return storeDAO.selectProduct(prod_num);
	}

	@Override
	public void updateProduct(StoreDTO storeDTO) {
		storeDAO.updateProduct(storeDTO);
	}

	@Override
	public void deleteThumbnail(Integer prod_num) {
		storeDAO.deleteThumbnail(prod_num);
	}

	@Override
	public void deleteProduct(Integer prod_num) {
		storeDAO.deleteCart(prod_num);
		storeDAO.deleteReview(prod_num);
		storeDAO.deleteProduct(prod_num);
	}

	@Override
	public void deleteReview(Integer prod_num) {
		storeDAO.deleteReview(prod_num);
	}
	
	@Override
	public int selectStoreAllSearchRowCount(Map<String, Object> map) {
		return storeDAO.selectStoreAllSearchRowCount(map);
	}

	@Override
	public List<StoreDTO> selectStoreAllSearchList(Map<String, Object> map) {
		return storeDAO.selectStoreAllSearchList(map);
	}


}
