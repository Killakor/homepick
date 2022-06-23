package com.teamproject.review.controller;

import java.util.Collections;
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
import com.teamproject.util.PagingUtil;

@Controller
public class ReviewController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	private int rowCount = 10;	//한 페이지의 게시물의 수
	private int pageCount = 10;	//한 화면에 보여줄 페이지 수
	
	//의존성 주입
	@Autowired
	private ReviewService reviewService;
	
	//스프링빈 초기화
	@ModelAttribute
	public ReviewDTO initReview() {
		return new ReviewDTO();
	}
	
	//구매내역 리스트
	@GetMapping("/review/myBuyList.do")
	public String mybuylist(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		int count = reviewService.reviewBuyCount(user_num);
		
		logger.debug("[구매량] : " + count);
		logger.debug("[구매회원 번호] : " + user_num);
		
		List<ReviewDTO> list = null;
		
		//구매내역 있을 시, 리스트에 등록
		if(count > 0) {
			list = reviewService.reviewbuyList(user_num);
		}
		logger.debug("[구매 리스트] : "+ list);
		logger.debug("[구매량] : " + count);
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		
		return "myBuyList";
	
	}
	

	//리뷰 등록 폼 호출
	@GetMapping("/review/reviewForm.do")
	public String reviewWriteform(@RequestParam int prod_num, HttpSession session, Model model) {
		
		logger.debug("[상품 번호] : " + prod_num);
		
		ReviewDTO reviewDTO = reviewService.productDetail(prod_num);
		Integer mem_num = (Integer)session.getAttribute("user_num");
		
		model.addAttribute("reviewDTO",reviewDTO);
		model.addAttribute("mem_num",mem_num);
		model.addAttribute("prod_num", prod_num);
		
		Map<Object, String> ratingOptions = new HashMap<Object, String>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		
		model.addAttribute("ratingOptions", ratingOptions);
		
		logger.debug("[리뷰 정보] : " + reviewDTO);
		
		return "reviewForm";
	}
	
	
	//리뷰 등록 완료 [@ModelAttribute - 파라미터 내 자동등록 (생락가능)]
	@PostMapping("/review/reviewWrite.do")
	public String reviewWrite(@ModelAttribute ReviewDTO review, HttpSession session, HttpServletRequest request, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		review.setMem_num(user_num);
		
		reviewService.reviewInsert(review);
			
		model.addAttribute("message", "작성하신 리뷰가 정상적으로 등록되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/review/myBuyList.do"); 
		
		return "common/resultView";
	}
	
	
	//리뷰 등록 시, 기존 구매내역 검증 프로세스 (중복리뷰 방지)
	@PostMapping("/review/reviewCheck.do")
	public String reviewCheck(@ModelAttribute("review") ReviewDTO review ,HttpSession session, HttpServletRequest request, Model model){
		
		int mem_num = (Integer)session.getAttribute("user_num");
		int prod_num = review.getProd_num();
		int count = reviewService.reviewExist(mem_num, review.getProd_num());
		
		logger.debug("[구매한 상품 번호] : " + review.getProd_num());
		logger.debug("[회원 번호] : " + mem_num);
		logger.debug("[구매한 상품 갯수] :"+ count);
		
		int orderCheck = 0;
		
		//리뷰 데이터 && 주문 데이터 검증 진행(2번 확인)
		//1.리뷰 등록 데이터 검증 진행[동일한 회원번호와 상품번호가 있는지 체크]
		if(count == 0) {
			
			//2.주문 데이터 검증 진행[동일한 회원번호와 상품번호가 있는지 체크 - 구매이력]
			orderCheck= reviewService.orderExist(mem_num, review.getProd_num());
			
			logger.debug("[구매 이력] : " + orderCheck);
			
			if(orderCheck == 0) {
				model.addAttribute("message", "해당 제품에 대한 구매이력이 없습니다.");
				model.addAttribute("url", request.getContextPath() + "/store/storeCategory.do"); 
				
				return "common/resultView";
				
			} else {
				model.addAttribute("prod_num","prod_num");
				model.addAttribute("message", "구매하신 제품에 대한 리뷰를 작성하시겠습니까?");
				model.addAttribute("url", request.getContextPath() + "/review/reviewForm.do?prod_num=" + prod_num);
				
				return "common/resultView";
			}

		} else {
			model.addAttribute("message", "이미 작성하신 리뷰가 존재합니다. 리뷰를 확인 하시겠습니까?");
			model.addAttribute("url", request.getContextPath() + "/review/reviewList.do"); 
		
			return "common/resultView";
		}
	}
	
	
	//리뷰 리스트
	@GetMapping("/review/reviewList.do")
	public String myReviewList(HttpSession session, Model model) {
		
		Integer mem_num = (Integer)session.getAttribute("user_num");
		int count = reviewService.reviewMyCount(mem_num);
		
		List<ReviewDTO> list = reviewService.reviewList(mem_num);
		Map<Object, String> ratingOptions = new HashMap<Object, String>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		
		model.addAttribute("ratingOptions", ratingOptions);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		
		logger.debug("[리뷰 리스트 정보] : " + list);
	
		return "reviewList";

	}
	
	
	//리뷰 수정 폼 호출
	@GetMapping("/review/reviewDetail.do")
	public String updateForm(@RequestParam int rev_num, HttpSession session, Model model) {
		
		ReviewDTO reviewDTO = reviewService.reviewDetail(rev_num);
		Integer mem_num = (Integer)session.getAttribute("user_num");
		
		model.addAttribute("reviewDTO", reviewDTO);
		model.addAttribute("mem_num", mem_num);
		
		Map<Object, String> ratingOptions = new HashMap<Object, String>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		
		model.addAttribute("ratingOptions", ratingOptions);
		
		logger.debug("[리뷰 정보] : " + reviewDTO);
	
		return "reviewUpdate";

	}

	
	//리뷰 수정 완료 - 리뷰 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/review/reviewUpdate.do")
	public String update(@Valid ReviewDTO reviewDTO, Model model, HttpServletRequest request, BindingResult result) {
		
		logger.debug("[수정 > 리뷰 정보] : "+ reviewDTO);
		
		reviewService.reviewUpdate(reviewDTO);
		
		model.addAttribute("message", "리뷰 수정이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/review/reviewList.do"); 
	
		return "common/resultView";
	
	}
	
	
	//리뷰 삭제
	@GetMapping("/review/reviewDelete.do")
	public String delete(@RequestParam int rev_num) {
	
		logger.debug("[삭제 > 리뷰 번호] : "+ rev_num);
		
		reviewService.reviewDelete(rev_num);
		
		return "redirect:reviewList.do";
	}
	
	
	//리뷰 이미지
	@GetMapping("/review/imageView.do")
	public String viewImage(@RequestParam int rev_num, Model model) {
		
		ReviewDTO review =reviewService.reviewImgStore(rev_num);

		logger.debug("[리뷰 이미지 정보] : " + review);
	  
		model.addAttribute("imageFile", review.getRev_img());
		model.addAttribute("filename", review.getRev_filename());
		
		return "imageView";
 
	}
	
	
	//상품 이미지
	@GetMapping("/review/prodView.do")
	public String prodImage(@RequestParam int rev_num, Model model) {
		
		ReviewDTO review =reviewService.reviewImgStore(rev_num);
		logger.debug("[상품 이미지 정보] : " + review);
		
		model.addAttribute("imageFile", review.getThumbnail_img());
		model.addAttribute("filename", review.getThumbnail_filename());
		
		return "imageView";
 
	}
	
	
	//리뷰 수정 시 이미지 삭제
	@RequestMapping("/review/deleteFile.do")
	@ResponseBody
	public Map<String, String> processFile(int rev_num, HttpSession session) {
		
		logger.debug("[수정 > 리뷰 번호] : " + rev_num);
		
		Map<String, String> map = new HashMap<String, String>();
		reviewService.deleteFile(rev_num);
	
		map.put("result", "success");
	
		return map;
	
	}
	
	
	//상품 상세페이지 내 댓글목록(httpAPI)
	@RequestMapping("/store/reviewList.do")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
			      					   @RequestParam int prod_num) {
		
		logger.debug("[현재 페이지] : " + currentPage);
		logger.debug("[상품 번호] : " + prod_num);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("prod_num", prod_num);
		
		//리뷰 갯수
		int count = reviewService.reviewStoreCount(prod_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, null);
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//리스트 호출
		List<ReviewDTO> list = null;
		
		if(count > 0) {
			list = reviewService.reviewListStore(prod_num);
			logger.debug("[리뷰 리스트 정보] : " + list);
		} else {
			list = Collections.emptyList();
		}

		//리뷰 정보값
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);
		
		return mapJson;
	}
}
