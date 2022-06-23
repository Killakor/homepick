package com.teamproject.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.teamproject.event.bean.EventDTO;
import com.teamproject.event.service.EventService;
import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.service.HouseBoardService;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.service.StoreService;
import com.teamproject.util.PagingUtil;

@Controller
public class MainController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	//의존성 주입
	@Autowired
	private HouseBoardService houseBoardService;
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private StoreService storeService;

	
	//메인 페이지
	@RequestMapping("/main/main.do")
	public String main(@RequestParam(value="keyword", defaultValue = "") String keyword, Model model) {
		
		/* 싱픔 게시물 */
		Map<String, Object>smap = new HashMap<String, Object>();
		//Map을 통해 전송된 키워드 값 등록
		smap.put("keyword", keyword);
		
		//상품 게시물 갯수
		int SCount = storeService.selectRowCount(smap);
		
		logger.debug("[상품 게시물 갯수]: " + SCount);
		
		//페이지 처리
		PagingUtil SPage = new PagingUtil(1, SCount, 4, 1, null);
		smap.put("start", SPage.getStartCount());
		smap.put("end", SPage.getEndCount());
		
		//상품 게시물의 리스트
		List<StoreDTO> SList = null;
		
		if(SCount > 0) {
			SList =storeService.selectList(smap);
			logger.debug("[상품 게시물의 리스트] : " + SList);
		}
		

		
		/* 집들이 게시물 */
		Map<String, Object>hmap = new HashMap<String, Object>();
		
		//집들이 게시물 갯수
		int HCount = houseBoardService.selectRowCount(hmap);
		
		logger.debug("[집들이 게시물 갯수] : " + HCount);
		
		//페이지 처리
		PagingUtil HPage = new PagingUtil(1, HCount, 4, 1, null);
		hmap.put("start", HPage.getStartCount());
		hmap.put("end", HPage.getEndCount());
		
		//집들이 게시물의 리스트
		List<HouseBoardDTO> HList = null;
		
		if(HCount > 0) {
			HList = houseBoardService.selectHBoardList(hmap);
			logger.debug("[집들이 게시물 리스트] : " + HList);
		}
		
		
		
		/* 이벤트 게시물 */
		Map<String, Object>emap = new HashMap<String, Object>();
		
		//이벤트 게시물 갯수
		int ECount = eventService.selectRowCount(emap);
		
		logger.debug("[이벤트 게시물 갯수] " + ECount);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(1, ECount, 4, 1, null);
		emap.put("start", page.getStartCount());
		emap.put("end", page.getEndCount());
		
		//이벤트 리스트
		List<EventDTO> EList = null;
		if(ECount > 0) {
			EList = eventService.eventGetList(emap);
			logger.debug("[이벤트 게시물의 리스트] : " + EList);
		}
		
		model.addAttribute("SCount", SCount);
		model.addAttribute("SList", SList);
		
		model.addAttribute("HCount", HCount);
		model.addAttribute("HList", HList);
		
		model.addAttribute("ECount", ECount);
		model.addAttribute("EList", EList);
			
		return "main";
	}
	 
}
