package com.teamproject.mainSearch.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.event.bean.EventDTO;
import com.teamproject.event.service.EventService;
import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.service.HouseBoardService;
import com.teamproject.main.controller.MainController;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.service.StoreService;
import com.teamproject.util.SearchPagingUtil;

@Controller
public class MainSearchController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(MainSearchController.class);
	
	//의존성 주입
	@Autowired
	private HouseBoardService houseBoardService;
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private StoreService storeService;
	
	//스프링 빈 초기화
	@ModelAttribute
	public HouseBoardDTO initHouseBoard() {
		return new HouseBoardDTO();
	}
	
	@ModelAttribute
	public EventDTO initEvent() {
		return new EventDTO();
	}
	
	@ModelAttribute	 
	public StoreDTO initStore() {
		return new StoreDTO();
	}
	

	//검색 결과 페이지
	@GetMapping("/mainSearch/mainSearch.do")
	public String mainAllSearchCall(@RequestParam(value="housePageNum", defaultValue="1") int houseCurrentPage,
									@RequestParam(value="eventPageNum", defaultValue="1") int eventcurrentPage,
									@RequestParam(value="storePageNum", defaultValue="1") int storecurrentPage,
									@RequestParam(value="keyfield", defaultValue="1") String keyfield,
									@RequestParam(value="keyword", defaultValue="") String keyword, 
									Model model) {
				

		/* 싱픔 게시물 */
		Map<String, Object> smap = new HashMap<String, Object>();
		//Map을 통해 전송된 키필드, 키워드 값 등록
		smap.put("keyfield", keyfield);
		smap.put("keyword", keyword);
		
		logger.debug("[상품 게시물에서 검색 된, 키필드 값] : " + keyfield);
		logger.debug("[상품 게시물에서 검색 된, 키필드 값] : " + keyword);
		
		
		//검색 된, 상품 게시물 갯수
		int productCount = storeService.selectStoreAllSearchRowCount(smap);
		
		logger.debug("[검색 된, 상품 게시물 갯수] : " + productCount);
		
		//페이지 처리
		SearchPagingUtil productPage = new SearchPagingUtil(keyfield, keyword, storecurrentPage, productCount, 4, 5, 
															"mainSearch.do?housePageNum=" + houseCurrentPage + "&eventPageNum=" + eventcurrentPage, "store");
		smap.put("start", productPage.getStartCount());
		smap.put("end", productPage.getEndCount());
		
		//검색 된, 상품 게시물의 리스트
		List<StoreDTO> productList = null;
		if(productCount > 0) {
			productList = storeService.selectStoreAllSearchList(smap);
		}
		
		
		
		/* 집들이 게시물 */
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("keyfield", keyfield);
		hmap.put("keyword", keyword);
		
		logger.debug("[집들이 게시물에서 검색 된, 키필드 값] : " + keyfield);
		logger.debug("[집들이 게시물에서 검색 된, 키필드 값] : " + keyword);
		
		//검색 된, 집들이 게시물 갯수
		int houseCount = houseBoardService.selectAllSearchRowCount(hmap);
		
		logger.debug("[검색 된, 집들이 게시물 갯수] : " + houseCount);
		
		//페이지 처리
		SearchPagingUtil housePage = new SearchPagingUtil(keyfield, keyword, houseCurrentPage, houseCount, 4, 5,
														  "mainSearch.do?eventPageNum=" + eventcurrentPage + "&storePageNum=" + storecurrentPage, "house");
		hmap.put("start", housePage.getStartCount());
		hmap.put("end", housePage.getEndCount());
		
		//검색 된, 집들이 게시물의 리스트
		List<HouseBoardDTO> houseList = null;
		if(houseCount > 0) {
			houseList = houseBoardService.selectAllSearchList(hmap);
		}
		
		
		
		/* 이벤트 게시물 */
		Map<String, Object> emap = new HashMap<String, Object>();
		emap.put("keyfield", keyfield);
		emap.put("keyword", keyword);
		
		logger.debug("[이벤트 게시물에서 검색 된, 키필드 값] : " + keyfield);
		logger.debug("[이벤트 게시물에서 검색 된, 키필드 값] : " + keyword);
		
		int eventCount = eventService.selectEventAllSearchRowCount(emap);
		logger.debug("[검색 된, 이벤트 게시물 갯수] : " + eventCount);
		
		//페이지 처리
		SearchPagingUtil eventPage = new SearchPagingUtil(keyfield, keyword, eventcurrentPage, eventCount, 4, 5,
														  "mainSearch.do?housePageNum=" + houseCurrentPage + "&storePageNum" + storecurrentPage, "event");
		emap.put("start", eventPage.getStartCount());
		emap.put("end", eventPage.getEndCount());
		
		//검색 된, 이벤트 게시물의 리스트
		List<EventDTO> eventList = null;
		if(eventCount > 0) {
			eventList = eventService.selectEventAllSearchList(emap);
		}
		

		model.addAttribute("productCount", productCount);
		model.addAttribute("productList", productList);
		model.addAttribute("productPagingHtml", productPage.getPagingHtml());
		
		model.addAttribute("houseCount", houseCount);
		model.addAttribute("houseList", houseList);
		model.addAttribute("housePagingHtml", housePage.getPagingHtml());

		model.addAttribute("eventCount", eventCount);
		model.addAttribute("eventList", eventList);
		model.addAttribute("eventPagingHtml", eventPage.getPagingHtml());
		
		//현재 검색어 출력
		model.addAttribute("keyword", keyword);
		
		return "mainSearch";
	}
	 
}
