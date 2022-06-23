package com.teamproject.event.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.teamproject.event.bean.ECommentDTO;
import com.teamproject.event.bean.EventDTO;
import com.teamproject.event.service.EventService;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;
import com.teamproject.util.PagingUtil;

@Controller
@RequestMapping("/event")
public class EventController {

	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	
	private int rowCount = 20;	//한 페이지의 게시물의 수
	private int pageCount = 10;	//한 화면에 보여줄 페이지 수
	
	//의존성 주입
	@Autowired
	private EventService eventService;
	
	@Autowired
	private MemberService memberService;
	
	//스프링빈 초기화
	@ModelAttribute
	public EventDTO initEvent() {
		return new EventDTO();
	}
	
	
	//이벤트 등록 폼 호출
	@GetMapping("/eventWrite.do")
	public String form() {
	
		return "eventWrite";
	}

	
	//이벤트 등록 - 이벤트 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/eventWrite.do")
	public String submit(@Valid EventDTO eventDTO, BindingResult result, HttpSession session) {
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return form();
		}
		
		Integer mem_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//유효성 체크 : 회원 등급이 관리자가 아닐 경우, 목록 호출
		if(user_auth != 4) {
			return "redirect:eventList.do";
		}
		
		eventDTO.setMem_num(mem_num);
		eventService.eventWrite(eventDTO);
				
		logger.debug("[이벤트 게시물 등록 내용] : " + eventDTO);
		
		return "redirect:eventList.do";
	}
	
	
	//이벤트 리스트
	@GetMapping("/eventList.do")
	public String eventList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
							@RequestParam(value="keyword",defaultValue="") String keyword,
							HttpSession session,
							Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		logger.debug("[현재 페이지]: " + currentPage);
		
		//이벤트 갯수
		int count = eventService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(null, keyword, currentPage, count, rowCount, pageCount, "eventList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//이벤트 리스트
		List<EventDTO> list =null;
		if(count > 0) {
			list = eventService.eventGetList(map);
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("user_auth", user_auth);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "eventList";
	}
	
	
	//이벤트 게시물 상세보기
	@GetMapping("/eventDetail.do")
	public String eventDetail(@RequestParam(value="event_num") int event_num, HttpSession session, Model model) {
		
		//이벤트 조회수 증가
		eventService.eventGetHits(event_num);
		
		EventDTO event = eventService.eventDetail(event_num);
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		model.addAttribute("event", event);
		model.addAttribute("user_auth", user_auth);
		
		return "eventDetail";
	}
	
	
	//이벤트 수정 폼 호출
	@GetMapping("/eventUpdate.do")
	public String updateForm(@RequestParam int event_num, Model model, HttpSession session) {
		
		//이벤트 게시물 호출
		EventDTO eventDTO = eventService.eventDetail(event_num);
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		
		model.addAttribute("eventDTO", eventDTO);
		model.addAttribute("user_auth", user_auth);
		
		//세션 유효성 체크, 관리자만 수정 가능
		if(user_auth != 4) {
			return " redirect:eventList.do";
		}
		
		return "eventUpdate";
	}
	
	
	//이벤트 수정 - 이벤트 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/eventUpdate.do")
	public String submitUpdate(@Valid EventDTO eventDTO, BindingResult result, HttpServletRequest request, Model model) {
		
		logger.debug("[이벤트 게시물 수정 내용] : " + eventDTO);
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors()) {
			return "eventUpdate";
		}

		eventService.eventUpdate(eventDTO);
		
		model.addAttribute("message", "이벤트 게시물 수정이 완료 되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/event/eventList.do");
		
		return "common/resultView";
	}
	
	
	//이벤트 수정 - 썸네일 이미지 삭제
	//결과정보 직접 호출
	@RequestMapping("/deleteFile.do")
	@ResponseBody
	public Map<String, String> processFile(int event_num, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//세션 유효성 체크, 관리자만 수정 가능
		if(user_auth != 4) {
			map.put("result", "wrongauth");
			
		} else {
			eventService.deleteFile(event_num);
			map.put("result", "success");
		}
		
		return map;
	}
	
	
	//CKEditor를 이용한 이미지 업로드
	@RequestMapping("/imageUploader.do")
	@ResponseBody
	public Map<String,Object> uploadImage(MultipartFile upload, HttpSession session, HttpServletRequest request) throws Exception {
		
		//업로드 할 절대 경로 구하기
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");
		
		//업로드 할 파일 이름
		String org_filename = upload.getOriginalFilename();
		//저장 할 파일명 : long타입으로 밀리세컨드를 가져와서 중복되지 않은 파일명을 만듦
		String str_filename = System.currentTimeMillis() + org_filename;
		
		logger.debug("[업로드한 파일명] : " + org_filename);
		logger.debug("[저장 할 파일명] : " + str_filename);
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//업로드 할 파일 경로
		String filepath = realFolder + "\\" + user_num + "\\" + str_filename;
		logger.debug("<<파일 경로>> : " + filepath);
		
		//폴더가 존재하지 않는다면 폴더를 생성
		File f = new File(filepath);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		//경로가 존재 시 파일 업로드
		upload.transferTo(f);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uploaded", true);
		map.put("url", request.getContextPath() + "/resources/image_upload/" + user_num + "/" + str_filename);
		
		return map;
	}
	
	
	//이벤트 삭제
	@GetMapping("/eventDelete.do")
	public String delete(@RequestParam int event_num, HttpSession session) {
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//세션 유효성 체크, 관리자만 삭제 가능
		if(user_auth != 4) {
			return " redirect: eventList.do";
		}
		eventService.eventDelete(event_num);
		
		return "redirect:eventList.do";
	}
	
	
	//이벤트 이미지 출력
	@GetMapping("/imageView.do")
	public String viewImage(@RequestParam int event_num, EventDTO event, Model model) {
		
		event = eventService.eventDetail(event_num);
		
		logger.debug("[이벤트 이미지 정보] : " + event);

		model.addAttribute("imageFile", event.getEvent_photo());
		model.addAttribute("filename", event.getEvent_filename());
		
		return "imageView";
	}
	
	
	//이벤트 상세페이지 내 댓글 등록(httpAPI)
	@RequestMapping("/writeComment.do")
	@ResponseBody
	public Map<String, String> writeComment(ECommentDTO eCommentDTO, HttpSession session, HttpServletRequest request){
		
		logger.debug("[댓글 등록 정보] : " + eCommentDTO);
		
		Map<String, String>map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//로그인 여부 체크
		if(user_num == null) {
			map.put("result", "logout");
		} else {
			eventService.insertEComment(eCommentDTO);
			map.put("result", "success");
		}
		
		return map;
	}
	
	
	//이벤트 상세페이지 내 댓글 목록(httpAPI)
	@RequestMapping("/listComment.do")
	@ResponseBody
	public Map<String, Object> getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									   @RequestParam int event_num, HttpSession session) {
			
		logger.debug("[현재 페이지] : " + currentPage);
		logger.debug("[이벤트 번호] : " + event_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("event_num", event_num);
		
		//댓글수
		int count = eventService.selectRowCountComment(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, null);
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//댓글 리스트
		List<ECommentDTO> list = null;
		
		if(count > 0) {
			list = eventService.selectListEComment(map);
		} else {
			//댓글이 없을 경우 빈 리스트 전달
			list = Collections.emptyList();
		}
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);
		
		return mapJson;
	}
	
	


	//댓글 수정
	@RequestMapping("/updateComment.do")
	@ResponseBody
	public Map<String, String> updateComment(ECommentDTO eCommentDTO,
											HttpSession session,
											HttpServletRequest request){
		
		logger.debug("[댓글 수정 정보] : " + eCommentDTO);
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//세션 유효성 체크
		if(user_num == null) {
			map.put("result", "logout");
			
		//로그인 되어있고 로그인한 회원번호와 집들이 게시물 회원번호가 일치하거나 관리자일 경우 수정 가능
		} else if(user_num != null && user_num == eCommentDTO.getMem_num() || user_auth == 4) {
			eventService.updateEComment(eCommentDTO);
			map.put("result", "success");
		} else {
			map.put("result", "wrongAccess");
		}
		
		return map;
	}


	//이벤트 상세페이지 내 댓글 삭제(httpAPI)
	@RequestMapping("/deleteComment.do")
	@ResponseBody
	public Map<String,String> deleteComment(@RequestParam int comm_num, @RequestParam int mem_num, HttpSession session){
		
		logger.debug("[댓글 번호] : " + comm_num);
		logger.debug("[회원 번호] : " + mem_num);
		
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//세션 유효성 체크
		if(user_num == null) {
			map.put("result", "logout");
			
		//로그인 되어있고 로그인한 회원번호와 집들이 게시물 회원번호가 일치하거나 관리자일 경우 삭제 가능
		} else if(user_num != null && user_num == mem_num || user_auth == 4) {
			eventService.deleteEComment(comm_num);
			map.put("result", "success");
		} else {
			map.put("result", "wrongAccess");
		}
		return map;
	}
	
	
	//이벤트 썸네일 이미지 출력
	@GetMapping("/eventPhotoView.do")
	public String eventViewImage(@RequestParam int event_num, EventDTO eventDTO, Model model) {
         
		eventDTO = eventService.eventDetail(event_num);
      
		model.addAttribute("imageFile", eventDTO.getEvent_photo());
		model.addAttribute("filename", eventDTO.getEvent_filename());
         
		return "imageView";
	}
	
	//이벤트 댓글 회원 프로필 사진
	@GetMapping("/commentPhotoView.do")
	public String viewImageComment(@RequestParam int mem_num, MemberDTO memberDTO, Model model) {
	   
		memberDTO = memberService.selectMember(mem_num);

		model.addAttribute("imageFile", memberDTO.getProfile());
		model.addAttribute("filename", memberDTO.getProfile_filename());
	   
		return "imageView";
	}
	
}