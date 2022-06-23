package com.teamproject.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.notice.bean.NoticeDTO;
import com.teamproject.notice.dao.NoticeMapper;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper noticeDAO;
	
	@Override
	public void noticeWrite(NoticeDTO notice) {
		noticeDAO.noticeWrite(notice);
	}

	@Override
	public int noticeTotalCount() {
		return noticeDAO.noticeTotalCount();
	}

	@Override
	public int noticeHitCount(int notice_num) {
		return noticeDAO.noticeHitCount(notice_num);
	}

	@Override
	public NoticeDTO noticeDetail(int notice_num) {
		return noticeDAO.noticeDetail(notice_num);
	}

	@Override
	public void noticeUpdate(NoticeDTO notice) {
		noticeDAO.noticeUpdate(notice);
	}

	@Override
	public void noticeDelete(int notice_num) {
		noticeDAO.noticeDelete(notice_num);
	}

	@Override
	public List<NoticeDTO> noticeGetList(Map<String, Object> map) {
		return noticeDAO.noticeGetList(map);
	}

}
