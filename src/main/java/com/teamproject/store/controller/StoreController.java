package com.teamproject.store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.review.bean.ReviewDTO;
import com.teamproject.review.service.ReviewService;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.store.service.StoreService;
import com.teamproject.util.PagingUtil;
import com.teamproject.util.StringUtil;

@Controller
public class StoreController {

	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	//의존성 주입
	@Autowired
	private StoreService storeService;
	
	@Autowired
	private ReviewService reviewService;
	
	//스프링빈 초기화
	@ModelAttribute
	public StoreDTO initStore() {
		return new StoreDTO();
	}
	
	@ModelAttribute
	public ReviewDTO initReview() {
		return new ReviewDTO();
	}
	
	
	//상품 등록 폼 호출
	@GetMapping("/store/storeRegister.do")
	public String storeRegisterView() {
		logger.debug("[상품 등록 호출]");

		return "storeRegister";	//타일즈 식별자
	}
	
	//상품 등록 - 상품 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/store/storeRegister.do")
	public String storeRegister(@Valid StoreDTO storeDTO, BindingResult result, HttpSession session) {
		logger.debug("[등록 > 상품 정보] : " + storeDTO);
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors())
			return storeRegisterView();
		
		storeDTO.setMem_num((Integer)session.getAttribute("user_num"));
		storeService.productRegister(storeDTO);
		
		// 		   : 정상일 시, 스토어 카테고리 페이지로 이동
		return "redirect:/store/storeCategory.do";	//타일즈 식별자
	}
	

	
	//상품 수정 폼 호출
	@GetMapping("/store/storeModify.do")
	public String productUpdate(@RequestParam int prod_num, Model model) {
		
		StoreDTO storeDTO = storeService.selectProduct(prod_num);
		model.addAttribute("storeDTO", storeDTO);
		
		return "storeModify";	//타일즈 식별자
	}
	
	//상품 수정 완료 - 상품 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/store/storeModify.do")
	public String submitUpdate(@Valid StoreDTO storeDTO, BindingResult result, HttpServletRequest request, Model model) {
		
		logger.debug("[수정 > 상품 정보] : " + storeDTO);
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors())
			return "storeModify";
		
		//상품 수정
		storeService.updateProduct(storeDTO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "상품 수정이 완료되었습니다.");
		
		//이동할 경로
		model.addAttribute("url", request.getContextPath() + "/store/storeCategory.do");
	
		return "common/resultView";	//JSP 경로 지정
	}
	
	
	//상품 수정 - 썸네일 이미지 삭제
	//결과정보 직접 호출
	@RequestMapping("/store/deleteFile.do")
	@ResponseBody
	public Map<String, String> processFile(int prod_num, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		//세션 유효성 체크
		Integer mem_num = (Integer)session.getAttribute("user_num");
	
		if(mem_num == null) {
			map.put("result", "logout");
		} else {
			storeService.deleteThumbnail(prod_num);
			map.put("result", "success");
		}
		
		return map;
	}
	
	//상품 삭제
	@PostMapping("/store/productDelete.do")
	public String productDelete(@RequestParam int prod_num) {
		
		logger.debug("[삭제 > 상품 번호] : " + prod_num);
		
		storeService.deleteProduct(prod_num);
		
		return "redirect:/store/storeCategory.do";
	}	
	
	
	//스토어 메인 페이지 - 현재 전체를 아우르는 페이지 미작업!
	@GetMapping("/store/storeMain.do")
	public String storeMain() {
		logger.debug("[스토어 메인 호출]");
		
		return "storeMain";	//타일즈 식별자
	}
	
	
	//카테고리 페이지
	@RequestMapping("/store/storeCategory.do")
	public String process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
						  @RequestParam(value="keyfield", defaultValue = "1") String keyfield,
						  @RequestParam(value="prod_cate", defaultValue = "") String keyword,
						  Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//상품의 총 갯수
		int count = storeService.selectRowCount(map);
		logger.debug("[상품 갯수] : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(null, keyfield, currentPage, count, 12, 10, "storeCategory.do");

		
		//상품 리스트
		List<StoreDTO> list = null;
		
		if(count > 0) {
			
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("start", page.getStartCount());
			map1.put("end", page.getEndCount());
			
			list = storeService.selectList(map1);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		//타일즈 식별자
		return "storeCategory";
	}	
	
	
	//상품 상세보기
	@GetMapping("/store/storeDetail.do")
	public String process(@RequestParam int prod_num, Model model) {
		
		StoreDTO storeDTO = storeService.selectProduct(prod_num);
		
		logger.debug("[상품 번호] : " + prod_num);
		logger.debug("[상품 정보] : " + storeDTO);
		
		//리뷰 리스트
		List<ReviewDTO> reviewDTO = reviewService.reviewListStore(prod_num);
		
		//HTML 태그 불허
		storeDTO.setProd_name(StringUtil.useNoHtml(storeDTO.getProd_name()));
		
		//HTML 태그 불허, 줄 바꿈 허용 (CK에디터 사용으로 인한 사용 안함)
		//storeDTO.setProd_content(StringUtil.useBrNoHtml(storeDTO.getProd_content()));
		
		//리뷰 갯수
		int rev_count = reviewService.reviewStoreCount(prod_num);
		
		//리뷰가 1개 이상일 경우
		if(rev_count > 0) {
			//리뷰 - 평균 값
			Integer rev_grade = reviewService.staravg(prod_num);
			//리뷰 - 반올림한 값
			Integer rev_grade_round = Math.round(rev_grade);
			
			model.addAttribute("rev_grade", rev_grade);
			model.addAttribute("rev_grade_round", rev_grade_round);
			model.addAttribute("rev_count", rev_count);
			
			Map<Object,String> ratingOptions = new HashMap<Object,String>();
			
			//데이터베이스 내 리뷰 점수를 호출 후 문자열로 변환
			ratingOptions.put(0, "☆☆☆☆☆");
			ratingOptions.put(1, "★☆☆☆☆");
			ratingOptions.put(2, "★★☆☆☆");
			ratingOptions.put(3, "★★★☆☆");
			ratingOptions.put(4, "★★★★☆");
			ratingOptions.put(5, "★★★★★");
			
			model.addAttribute("ratingOptions",ratingOptions);
			model.addAttribute("reviewDTO", reviewDTO);
		}
		
		model.addAttribute("storeDTO", storeDTO);
		model.addAttribute("rev_count", rev_count);
		
		return "storeProduct";
	}
	
	
	//썸네일 이미지
	@GetMapping("/store/imageView.do")
	public String viewImage(@RequestParam int prod_num, Model model, StoreDTO storeDTO) {
		
		storeDTO = storeService.selectProduct(prod_num);
			
		model.addAttribute("imageFile", storeDTO.getThumbnail_img());
		model.addAttribute("filename", storeDTO.getThumbnail_filename());
		
		return "imageView";
	}
	
	//리뷰 이미지 
	@GetMapping("/store/reviewImageView.do")
	public String reviewImageContent(@RequestParam int rev_num, ReviewDTO reviewDTO, Model model) {
			
		reviewDTO = reviewService.reviewImgStore(rev_num);
		
		model.addAttribute("imageFile", reviewDTO.getRev_img());
		model.addAttribute("filename", reviewDTO.getRev_filename());
			
		return "imageView";
	}
	

	
	


	

}
