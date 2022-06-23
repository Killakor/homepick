package com.teamproject.qna.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.qna.bean.QnaDTO;
import com.teamproject.qna.dao.QnaMapper;

@Service
@Transactional
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaMapper qnaDAO;
	
	@Override
	public void qnaInsert(QnaDTO qna) {
		qnaDAO.qnaInsert(qna);
	}

	@Override
	public List<QnaDTO> getQnaList(Map<String, Object> map) {
		return qnaDAO.getQnaList(map);
	}

	@Override
	public List<QnaDTO> getQnaServiceList(Map<String, Object> map) {
		return qnaDAO.getQnaServiceList(map);
	}

	@Override
	public QnaDTO getQna(int num) {
		return qnaDAO.getQna(num);
	}

	@Override
	public void qnaUpdate(QnaDTO qna) {
		qnaDAO.qnaUpdate(qna);
	}

	@Override
	public void qnaDelete(int num) {
		qnaDAO.qnaDelete(num);
	}

	@Override
	public int getQnaServiceCount() {
		return qnaDAO.getQnaServiceCount();
	}

	@Override
	public int getQnaCount(Map<String, Object> map) {
		return qnaDAO.getQnaCount(map);
	}


}
