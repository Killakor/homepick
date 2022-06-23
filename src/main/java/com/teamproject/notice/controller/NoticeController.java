package com.teamproject.notice.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.notice.bean.NoticeDTO;
import com.teamproject.notice.service.NoticeService;
import com.teamproject.util.PagingUtil;

@Controller
public class NoticeController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	//스프링빈 초기화
	@ModelAttribute
	public NoticeDTO initNotice() {
		return new NoticeDTO();
	}
	
	
	//공지사항 등록 폼 호출
	@GetMapping("/notice/noticeWrite.do")
	public String form() {
		
		return "noticeWrite";
	}
	
	//공지사항 등록 - 공지사항 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/notice/noticeWrite.do")
	public String submit(@Valid NoticeDTO noticeDTO, BindingResult result, HttpSession session) {
		
		logger.debug("[공지사항 정보] : " + noticeDTO);
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//세션을 통한 로그인 된 회원 정보 받기
		Integer mem_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//유효성 체크 : 회원 권한이 관리자가 아닐 경우, 접근 불가토록 조치
		if(user_auth != 4) {
			return "redirect:noticeList.do";
		}
		
		//로그인 된 회원 정보 주입
		noticeDTO.setMem_num(mem_num);
		noticeService.noticeWrite(noticeDTO);
		
		return "redirect:noticeList.do";
	}
	
	//공지사항 리스트
	@GetMapping("notice/noticeList.do")
	public String noticeList(@RequestParam(value="pageNum",defaultValue="1") int currentPage, HttpSession session, Model model) {
		
		//공지사항 갯수
		int count = noticeService.noticeTotalCount();
		
		//페이징 처리
		PagingUtil page = new PagingUtil(currentPage, count , 10, 10, "/EverydayHome/notice/noticeList.do");
		
		//공지사항 리스트
		List<NoticeDTO> list = null;
		
		if(count > 0) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("start", page.getStartCount());
			map.put("end", page.getEndCount());
			
			list = noticeService.noticeGetList(map);
		}
		
		//세션을 통한 로그인 된 회원의 회원 등급 받기
		Integer user_auth = (Integer)session.getAttribute("user_auth");

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		model.addAttribute("user_auth", user_auth);
		
		return "noticeList";
	}
	
	//공지사항 상세보기
	@GetMapping("notice/noticeDetail.do")
	public String noticeDetail(@RequestParam(value="notice_num") int notice_num, HttpSession session, Model model) {
		
		//세션을 통한 로그인 된 회원의 회원 등급 받기
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		//공지사항 데이터
		NoticeDTO notice = noticeService.noticeDetail(notice_num);
		//조회수 증가
		noticeService.noticeHitCount(notice_num);

		model.addAttribute("notice", notice);
		model.addAttribute("user_auth",user_auth);
		
		return "noticeDetail";
	}

	
	//공지사항 수정 폼 호출
	@GetMapping("/notice/noticeUpdate.do")
	public String updateForm(@RequestParam int notice_num, Model model, HttpSession session) {

		//세션을 통한 로그인 된 회원의 회원 등급 받기
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		//공지사항 데이터
		NoticeDTO noticeDTO = noticeService.noticeDetail(notice_num);
		
		model.addAttribute("noticeDTO", noticeDTO);
		model.addAttribute("user_auth",user_auth);
		
		//유효성 체크 : 회원 권한이 관리자가 아닐 경우, 접근 불가토록 조치
		if(user_auth != 4) {
			return "redirect:noticeList.do";
		}
		
		return "noticeUpdate";
	}
	
	
	//공지사항 수정 - 공지사항 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/notice/noticeUpdate.do")
	public String submitUpdate(@Valid NoticeDTO noticeDTO, BindingResult result) {
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors()) {
			return "noticeDetail";
		}
		
		//공지사항 수정
		noticeService.noticeUpdate(noticeDTO);
		
		return "redirect:noticeList.do";
	}
	
	//공지사항 삭제
	@GetMapping("/notice/noticeDelete.do")
	public String deleteForm(@RequestParam int notice_num, HttpSession session) {
		
		//세션을 통한 로그인 된 회원의 회원 등급 받기
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//유효성 체크 : 회원 권한이 관리자가 아닐 경우, 접근 불가토록 조치
		if(user_auth != 4) {
			return "redirect:noticeList.do";
		}
		
		noticeService.noticeDelete(notice_num);
		
		return "redirect:noticeList.do";
	}
	
	
	//CKEditor를 이용한 이미지 업로드
	@RequestMapping("/notice/imageUploader.do")
	@ResponseBody
	public Map<String, Object> uploadImage(MultipartFile upload, HttpSession session, HttpServletRequest request) throws Exception {
		
		//업로드 할 절대 경로 구하기
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");
		
		//업로드할 파일명
		String org_filename = upload.getOriginalFilename();
		//저장 할 파일명 : long타입으로 밀리세컨드를 가져와서 중복되지 않은 파일명을 만듦
		String str_filename = System.currentTimeMillis() + org_filename; 
		
		logger.debug("[업로드한 파일명] : " + org_filename);
		logger.debug("[저장 할 파일명] : " + str_filename);
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		String filepath = realFolder + "\\" + user_num + "\\" + str_filename;
		logger.debug("[업로드 할 파일 경로] : " + filepath);
		
		File f = new File(filepath);
		
		//폴더가 존재하지 않는다면 폴더를 생성
		if(!f.exists()) { 
			f.mkdirs();
		}
		
		//경로가 존재 시 파일 업로드
		upload.transferTo(f); 
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("uploaded", true);
		map.put("url", request.getContextPath() + "/resources/image_upload/" + user_num + "/" + str_filename);
		
		return map;
	}
	
}
