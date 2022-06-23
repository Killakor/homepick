package com.teamproject.qna.controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import com.teamproject.qna.bean.QnaDTO;
import com.teamproject.qna.service.QnaService;
import com.teamproject.serviceBoard.bean.ServiceBoardDTO;
import com.teamproject.serviceBoard.service.ServiceBoardService;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.util.PagingUtil;

@Controller
public class QnaController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	private int rowCount = 20;	//한 페이지의 게시물의 수
	private int pageCount = 10;	//한 화면에 보여줄 페이지 수
	
	@Autowired
	private ServiceBoardService serviceBoardService;
	
	//자바 메일 전송 객체 생성
	@Autowired
	private JavaMailSender mailSender;	
	
	@Autowired
	private QnaService qnaService;
	
	//스프링빈 초기화
	@ModelAttribute
	public QnaDTO initQna() {
		return new QnaDTO();
	}
	
	@ModelAttribute
	public ServiceBoardDTO initServiceBoard() {
		return new ServiceBoardDTO();
	}
	
	//QnA 등록 폼 호출
	@GetMapping("/qna/qnaInsert.do")
	public String qnaInsert() {
		logger.debug("[상품 등록 호출]");

		return "qnaInsert";	//타일즈 식별자
	}
	
	
	//QnA 등록 - QnA등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/qna/qnaInsert.do")
	public String qnaInsertSubmit(@Valid QnaDTO qna, BindingResult result) {
		
		logger.debug("[등록 > QnA 정보] : " + qna);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			logger.debug(result.toString());
			return qnaInsert();
		}
		qnaService.qnaInsert(qna);
		
		return "redirect:/qna/qnaList.do";
	}
	
	
	//QnA 리스트[고객센터 - 사용자 페이지]
	@RequestMapping("/qna/qnaList.do")
	public String getQnaList(@RequestParam(value="pageNum", defaultValue="1")int currentPage,
							 @RequestParam(value="keyword", defaultValue="") String keyword,
							 @RequestParam(value="keyfield",defaultValue = "1") String keyfield,
							 Model model) {
		
		logger.debug("[현재 페이지] : " + currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);
		
		//QnA 키워드별 갯수
		int count = qnaService.getQnaCount(map);
		
		//페이지 정보 메서드 호출
		PagingUtil page = new PagingUtil(null, keyfield, currentPage, count, 50, 5, "qnaList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//QnA 리스트
		List<QnaDTO> list = null;
		if(count > 0) {
			list = qnaService.getQnaList(map);
		}
		
		model.addAttribute("count",count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "qnaList";
	}
	
	
	//QnA 리스트[자주묻는설정 - 관리자 페이지]
	@RequestMapping("/qna/qnaServiceList.do")
	public String getQnaServiceList(@RequestParam(value="pageNum", defaultValue="1")int currentPage, Model model) {
		
		logger.debug("<<currentPage>>: " + currentPage);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//QnA 총 갯수
		int count = qnaService.getQnaServiceCount();
		
		//페이지 정보 메서드 호출
		PagingUtil page = new PagingUtil(currentPage, count, 10, 10, "qnaServiceList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//QnA 리스트
		List<QnaDTO> list = null;
		if(count > 0) {
			list = qnaService.getQnaServiceList(map);
		}
		
		model.addAttribute("count",count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "qnaServiceList";
	}
	
	
	//QnA 수정 폼 호출
	@GetMapping("/qna/qnaUpdate.do")
	public String qnaUpdate(@RequestParam int qna_num, Model model) {
		
		logger.debug("[QnA 수정 폼 호출]");
		
		QnaDTO qna = qnaService.getQna(qna_num);
		model.addAttribute("qnaDTO", qna);
		
		return "qnaUpdate";
	}
	
	
	//QnA 수정 완료 - 상품 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/qna/qnaUpdate.do")
	public String qnaUpdateSubmit(@Valid QnaDTO qna, BindingResult result, HttpServletRequest request, Model model) {
		
		logger.debug("[수정 > QnA 정보] : " + qna);
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors())
			return "qnaUpdate";
		
		qnaService.qnaUpdate(qna);
		
		return "redirect:/qna/qnaList.do";
	}
	
	//QnA 삭제
	@PostMapping("/qna/qnaDelete.do")
	public String qnaDeleteSubmit(@RequestParam int num) {
		
		logger.debug("[삭제 > QnA 번호] : " + num);
		
		qnaService.qnaDelete(num);
		
		return "redirect:/qna/qnaServiceList.do";
	}	
	
	
	//이메일 문의 등록 폼 호출
	@GetMapping("/qna/serviceBoardInsert.do")
	public String serviceBoardInsertForm() {
		
		logger.debug("[이메일 문의 폼 호출]");
		
		return "serviceBoardInsert";
	}
	
	
	//이메일 문의 등록 - 문의 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/qna/serviceBoardInsert.do")
	public String submit(@Valid ServiceBoardDTO serviceboard, BindingResult result, HttpSession session, HttpServletRequest request) {
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return serviceBoardInsertForm();
		}
		
		serviceBoardService.serviceBoardInsert(serviceboard);
		
		return "redirect:/qna/serviceBoardList.do";
	}
	
	
	
	//이메일 문의 리스트
	@GetMapping("/qna/serviceBoardList.do")
	public String getServiceBoardList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									  @RequestParam(value="keyfield",defaultValue="") String keyfield,
									  @RequestParam(value="keyword",defaultValue="") String keyword,
									  Model model) {
		
		logger.debug("[현재 페이지] : " + currentPage);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//검색 조회되는 고객센터 문의 갯수
		int count = serviceBoardService.selectRowCount(map);
				
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, rowCount, pageCount, "serviceBoardList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//고객센터 리스트
		List<ServiceBoardDTO> list = null;
		if(count > 0) {
			list = serviceBoardService.getServiceBoardList(map);
		}
		
		model.addAttribute("count",count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "serviceBoardList";
		
	}
	
	
	//이메일 문의 상세보기
	@GetMapping("/qna/serviceBoardDetail.do")
	public String serviceBoardDetail(@RequestParam int service_num, Model model) {
		ServiceBoardDTO serviceboard = serviceBoardService.getServiceBoard(service_num);
		
		ModelAndView mav = new ModelAndView();
		model.addAttribute("serviceboard", serviceboard);
		
		return "serviceBoardDetail";
	}
	
	
	//썸네일 이미지
	@GetMapping("/qna/imageView.do")
	public String viewImage(@RequestParam int service_num, Model model) {
		
	ServiceBoardDTO serviceboard = serviceBoardService.getServiceBoard(service_num);
	
	model.addAttribute("imageFile", serviceboard.getService_file());
	model.addAttribute("filename", serviceboard.getService_filename());
				
		return "imageView";
	}
		
	//이메일 전송
	@GetMapping("/qna/sendEmail.do")
	public String sendMail(String service_email, String service_reply) throws Exception{
		
		logger.info("[이메일 데이터 전송]");
		logger.info("[이메일] : " + service_email);
	    
	    String title = "Re: 홈픽에 문의 주셔서 감사합니다.";	
	    String content = "안녕하세요. 항상 홈픽에 관심을 갖고 이용해 주셔서 감사드립니다.<br>"
		        		+ "요청하신 사항은 담당 부서로 전달하도록 하겠습니다.<br>"
		        		+ "앞으로 이용에 불편함이 없도록 노력하는 홈픽이 되겠습니다.<br>"
		        		+ "오늘도 좋은 하루 보내시길 바랍니다.<br>"
		        		+ "감사합니다.<br><hr size='1' noshade='noshade'><br>" 
		        		+ "Re: " + service_reply;
	    
	    String fromEmail = "인테리어의 모든 것! 홈픽 <team4.homepickgmail.com>";
	    String toEmail = service_email;
	    
	    
	    try {
	        MimeMessage mail = mailSender.createMimeMessage();
	        MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
	        
	        
	        /*
	         * Multipart 기능을 사용하기 위해서는 아래의 코드로 사용 가능 
	         * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
	         * true는 멀티파트 메세지를 사용하겠다는 의미
	         */
	        
	        // 보내는 사람
	        //빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
	        mailHelper.setFrom(fromEmail);	
	        //보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용
	        //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
	        mailHelper.setTo(toEmail);
	        mailHelper.setSubject(title);
	        // 단순한 텍스트만 사용 (true는 html을 사용하겠다는 의미.)
	        mailHelper.setText(content, true);	
	        // 메일 전송
	        mailSender.send(mail);		
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
		return "redirect:/qna/serviceBoardList.do";
	    
	}
}
