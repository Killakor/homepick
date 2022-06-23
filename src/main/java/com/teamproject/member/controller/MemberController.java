package com.teamproject.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.teamproject.houseBoard.bean.HMarkDTO;
import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.service.HouseBoardService;
import com.teamproject.member.bean.MemberBuisDTO;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;
import com.teamproject.serviceBoard.bean.ServiceBoardDTO;
import com.teamproject.serviceBoard.service.ServiceBoardService;
import com.teamproject.store.bean.StoreDTO;
import com.teamproject.util.AuthCheckException;
import com.teamproject.util.PagingUtil;

@Controller
public class MemberController {

	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 게시물, 페이지 카운트 지정
	private int rowCount = 4;	//한 페이지의 게시물의 수
	private int pageCount = 5;	//한 화면에 보여줄 페이지 수
	private int mem_rowCount = 10;	//한 페이지의 회원 게시물 수
	private int mem_pageCount = 5;	//한 화면에 보여줄 회원 페이지 수
	
	//의존성 주입
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HouseBoardService houseBoardService;
	
	@Autowired
	private ServiceBoardService serviceBoardService;
	
	//자바 메일 전송 객체 생성
	@Autowired
	private JavaMailSender mailSender;	
	
	//스프링빈 초기화
	@ModelAttribute
	public ServiceBoardDTO initServiceBoard() {
		return new ServiceBoardDTO();
	}
	
	@ModelAttribute
	public MemberDTO initMember() {
		return new MemberDTO();
	}
	
	@ModelAttribute
	public MemberBuisDTO initMemberBuis() {
		return new MemberBuisDTO();
	}
	
	@ModelAttribute
	public HouseBoardDTO initHouseBoard() {
	 	return new HouseBoardDTO();
	}
	
	@ModelAttribute
	public HMarkDTO initHMark() {
		return new HMarkDTO();
	}
	
	@ModelAttribute
	public StoreDTO initStore() {
		return new StoreDTO();
	}

	
	//회원가입 등록 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		logger.debug("[회원가입 폼 호출]");
		
		return "memberRegister";
	}
	
	//회원가입 등록 - 회원등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberDTO memberDTO, BindingResult result) {
		
		// 유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return form();
		}
		
		logger.debug("[회원등록 정보] : " + memberDTO);
		
		memberService.insertMember(memberDTO);
		
		return "redirect:/main/main.do";
	}
	
	
	//회원가입 시, 이메일 전송 - 이메일로 난수코드 메일 발송 및 httpAPI 사용
	@GetMapping("/member/mailCheck.do")
	@ResponseBody
    public String sendMail(String email) throws Exception {
        
        logger.info("[이메일 난수코드 데이터 전송]");
        logger.info("[전송 이메일] : " + email);
        
        //영문/숫자 포함 랜덤 8자리 난수 생성
        String emailCheckCode = excuteGenerate();
        
        logger.info("[인증번호] : " + emailCheckCode);	
        
        String title = "[홈픽] 이메일 인증 이메일 입니다.";	
        String content = "홈픽 홈페이지를 방문해주셔서 정말 감사합니다." +
		        		"<br><br>" +
		        		"홈픽 이메일 인증번호 인증번호는 : <b style='font-size : 14px; color: red;'>" + emailCheckCode + "</b>입니다." +
		        		"<br><br>" +
		        		"해당 인증 번호를 통해 인증 후 가입이 가능합니다.";
        String fromEmail = "인테리어의 모든 것! 홈픽 <team4.homepickgmail.com>";
        String toEmail = email;
        
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
            
            /* 
             * Multpart 기능을 사용하기 위해서는 아래의 코드로 사용 가능 
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
             * true는 멀티파트 메세지를 사용하겠다는 의미
             */
            
	        //보내는 사람
	        //빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
	        mailHelper.setFrom(fromEmail);	
	        //보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용
	        //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
	        mailHelper.setTo(toEmail);
	        mailHelper.setSubject(title);
	        //단순한 텍스트만 사용 (true는 html을 사용하겠다는 의미.)
	        mailHelper.setText(content, true);	
	        //메일 전송
	        mailSender.send(mail);		
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        return emailCheckCode;
    }
	
	//회원가입 시, 아이디 중복 검사
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String, String> process(@RequestParam String mem_id) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		logger.debug("[아이디] : " + mem_id);
				
		MemberDTO member = memberService.selectCheckMember(mem_id);
		
		if(member != null) { 
			//아이디 중복일 경우
			map.put("result", "idDuplicated");
		} else {
			//아이디 정규표현식 패턴이 맞지 않을 경우 
			if(!Pattern.matches("^(?=.*[a-zA-Z])[-a-zA-Z0-9_.]{6,12}$", mem_id)) {
				//패턴 불일치
				map.put("result", "notMatchPattern");
			} else {
				//아이디 미중복
				map.put("result", "idNotFound");
			}
		}
		return map;	
	}

	//카카오 로그인 - httpAPI
	@PostMapping("/member/kakaologin.do")
	@ResponseBody
	public Map<String, String> kakaoLogin(@RequestParam String id, String nickname, String profile_image_url, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		//카카오에 저장된 회원 정보를 세션으로 처리
		session.setAttribute("account_email", id);
		session.setAttribute("profile_nickname", nickname);
		session.setAttribute("profile_image", profile_image_url);
		
		map.put("knickname", nickname);
		
		return map;
	}
	
	//카카오 로그인 정보에 대해 회원 정보 저장 - 로그인한 내역이 없으면 데이터 등록 후 로그인
	@PostMapping("/member/kakaoLoginProcess.do")
	public String kakaoRegister(MemberDTO memberDTO, HttpSession session) {
		
		//카카오에 저장된 회원 정보를 세션으로 받아온 뒤 변수화
		String id = (String) session.getAttribute("account_email");
		String nickname = (String) session.getAttribute("profile_nickname");
		String photo = (String) session.getAttribute("profile_image");
		
		logger.debug("[회원 정보] : " + memberDTO);
			
		//회원 객체에 세션정보 전달
		memberDTO.setMem_id(id);
		memberDTO.setNickname(nickname);
		memberDTO.setProfile_filename(photo);
		
		//비밀번호는 카카오에서 전달받았다는 것을 알기 위해 Kakao + 8자리 난수 활용하여 생성
		String radomPasswd = "Kakao" + excuteGenerate();
		memberDTO.setPasswd(radomPasswd);
		
		//회원 데이터 저장
		memberService.insertMember(memberDTO);
		//아이디 중복 검사
		MemberDTO newMemberDTO = memberService.selectCheckMember(id);
		
		//세션 재설정
		session.setAttribute("user_num", newMemberDTO.getMem_num());
		session.setAttribute("user_auth", newMemberDTO.getMem_auth());
		session.setAttribute("user_photo", newMemberDTO.getProfile());
		session.setAttribute("user_nickname", newMemberDTO.getNickname());
		
		return "redirect:/main/main.do";
	}
	
	
	//로그인 - 로그인 폼 호출
	@GetMapping("/member/login.do")
	public String formLogin() {
		
		return "memberLogin";
	}
	
	//로그인 - 로그인 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberDTO memberDTO,BindingResult result, HttpSession session) {
			
		logger.debug("[로그인 회원 정보] : " + memberDTO);
			
		//유효성 체크 : 아이디 또는 패스워드 오류 발생 시, 로그인 폼으로 호출
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("passwd")) {
			return formLogin();
		}
			
		//유효성 체크 : 로그인 시, 아이디/비밀번호 일치 여부 체크
		try {
			MemberDTO member = memberService.selectCheckMember(memberDTO.getMem_id());	
			
			//아이디 및 비밀번호 일치 여부 체크 후, 존재하지 않다면 실패
			boolean check = false;
			
			//아이디가 있다면 비밀번호 일치 여부 체크
			if(member != null) {
				check = member.isCheckedPassword(memberDTO.getPasswd());
			}
			
			//인증 성공 시, 로그인 처리
			if(check) {
				session.setAttribute("user_num", member.getMem_num());
				session.setAttribute("user_auth", member.getMem_auth());
				session.setAttribute("user_nickname", member.getNickname());
				session.setAttribute("user_photo", member.getProfile());
				
				return "redirect:/main/main.do";
				
			} else {
				//인증 실패 시, 예외발생
				throw new AuthCheckException();
			}
			
		} catch(AuthCheckException e) {
			
			//인증 실패 시, 메시지 생성 및 로그인 폼 호출
			result.reject("invalidIdOrPassword");
				
			return formLogin();
		}
	}
	
	
	//아이디 찾기 폼 호출
	@GetMapping("/member/idSearch.do")
	public String idSearchForm() {
		
		logger.debug("[아이디 찾기 폼 호출]");
		
		return "memberIdSearch";
	}
	
	
	//아이디 찾기 - 아이디 찾기 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/idSearchResult.do")
	public String idSearchProcess(@Valid MemberDTO memberDTO, BindingResult result, Model model) {
		
		logger.debug("[아이디를 찾을 회원 정보] : " + memberDTO);
		
		//Map을 통해 전송된 데이터를 가지고, 저장된 이름과 전화번호와 비교
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mem_name", memberDTO.getMem_name());
		map.put("phone", memberDTO.getPhone());
											
		int count = 0; 
		
		List<MemberDTO> list = null;
		
		//리스트에 아이디 정보 담기
		list = memberService.SelectIdSearch(map);
		
		// 리스트가 null 이라면 count 0으로 지정 (데이터가 있는 경우 1)
		if(list == null) count = 0;
		if(list != null) count = 1;
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
								
		return "memberIdSearchResult";
	}
	
	
	//비밀번호 찾기 폼 호출
	@GetMapping("/member/passwdSearch.do")
	public String passwdSerchForm() {
		
		logger.debug("[비밀번호 찾기 폼 호출]");
		
		return "memberPasswdSearch";
	}
	
	
	//비밀번호 찾기 - 비밀번호 찾기 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/passwdSearchResult.do")
	public String passwdSerchResult(@Valid MemberDTO memberDTO, BindingResult result, Model model) {
		
		logger.debug("[비밀번호를 찾을 회원 정보] : " + memberDTO);
		
		//유효성 체크 : 아이디 또는 전화번호 또는 이메일 오류 발생 시, 비밀번호 찾기 폼으로 호출
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("phone") || result.hasFieldErrors("email")) {

			return "memberPasswdSearch";
		}
		
		//유효성 체크 : 아이디 정보가 확인될 시, 아이디/이메일/전화번호 일치 여부 체크
		try {
			MemberDTO member = memberService.selectCheckMember(memberDTO.getMem_id());
			
			//아이디, 이메일, 전화번호 일치 여부 체크 후, 존재하지 않다면 실패
			boolean check = false;
			
			//아이디가 있다면 이메일과 전화번호 일치 여부 체크
			if(member != null) {
				
				if(member.getEmail().equals(memberDTO.getEmail()) && member.getPhone().equals(memberDTO.getPhone())) {
					check = true;
				}
				
			}
			
			//인증 성공 시, 난수로 된 비밀번호 이메일 발송 처리
			if(check) {
				
				//영문/숫자 포함 랜덤 8자리 난수 생성
				String emailCheckCode = excuteGenerate();
				
				logger.info("[인증번호] : " + emailCheckCode);
				
		     try {
		    	 // 이메일 내용 작성
		    	 String title = "[홈픽] 비밀번호 찾기 이메일 입니다.";	
		    	 String content = "홈픽 비밀번호 찾기가 완료되었습니다." +
					       		"<br><br>" +
					       		"회원님의 임시 비밀번호는 : <b style='font-size : 14px; color: red;'>" + emailCheckCode + "</b>입니다." +
					       		"<br><br>" +
					       		"해당 비밀번호로 로그인 후 비밀번호 변경을 반드시 해주시기 바랍니다.+" + 
					       		"<br><br>" +
					       		"언제나 홈픽을 이용해 주셔서 감사합니다.";
		    	 String fromEmail = "인테리어의 모든 것! 홈픽 <team4.homepickgmail.com>";
		    	 String toEmail = memberDTO.getEmail();
		        
		    	 MimeMessage mail = mailSender.createMimeMessage();
		    	 MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
		        
		    	 //보내는 사람
		    	 mailHelper.setFrom(fromEmail);	
		    	 //받는 사람
		    	 mailHelper.setTo(toEmail);
		    	 //메일 제목
		    	 mailHelper.setSubject(title);
		    	 //단순한 텍스트만 사용 (true는 html을 사용하겠다는 의미.)
		    	 mailHelper.setText(content, true);	
		    	 //메일 전송
		    	 mailSender.send(mail);
				
		    	 model.addAttribute("id", memberDTO.getMem_id());
		    	 model.addAttribute("email", memberDTO.getEmail());
				
		    	 //회원 비밀번호 변경(8자리의 난수 코드 비밀번호 지정)
		    	 member.setPasswd(emailCheckCode);
		    	 memberService.updateMemberPasswd(member);
				
		    	 return "memberPasswdSearchResult";
				
		     } catch(Exception e) {
				
	    	 	//인증 실패 시, 메시지 생성 및 비밀번호 찾기 폼 호출
				result.reject("invalidSearchPassword");
				
				return "memberPasswdSearch";
	        }
		     	
			} else {
				//인증 실패 시, 예외발생
				throw new AuthCheckException();
			}
		} catch(AuthCheckException e) {
			
			//인증 실패 시, 메시지 생성 및 비밀번호 찾기 폼 호출
			result.reject("invalidSearchPassword");
			
			return "memberPasswdSearch";
	}
}

	
	//로그아웃
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session) {
		
		//세션 만료처리
		session.invalidate();
			
		return "redirect:/main/main.do";
	}
	
	
	//마이페이지 호출
	@GetMapping("/member/myPage.do")
	public String myPageMain(HttpSession session, Model model) {
		
		//SQL문 실행을 위한 변수 지정
		String keyfield = "";
		String keyword = "1";
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//Map을 통한 SQL문 지정
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//판매자 신청 글의 총 개수 또는 검색된 글의 개수
		int count = memberService.selectMemberBuisCount(map);								
		
		logger.debug("<<count>> : " + count);
		
		//SQL WHERE 절 지정
		map.put("start", 1);
		map.put("end", 10);
		
		//판매자 신청 리스트
		List<MemberBuisDTO> list = null;
		
		if(count > 0) {
			list = memberService.selectMemberBuisList(map);		
		}
		
		//Map을 통한 이메일 문의 SQL문 지정
		Map<String,Object> qnamap = new HashMap<String,Object>();
		qnamap.put("keyfield", "0");
		qnamap.put("keyword", "");
		qnamap.put("start", 1);
		qnamap.put("end", 10);
		
		//이메일 문의 갯수
		int qnacount = serviceBoardService.selectRowCount(qnamap);
		
		//목록 호출
		List<ServiceBoardDTO> qnalist = null;
		
		if(qnacount > 0) {
			qnalist = serviceBoardService.getServiceBoardList(qnamap);
		}

		MemberDTO member = memberService.selectMember(user_num);
		
		logger.debug("[판매자 신청 리스트] : " + list);
		logger.debug("[회원 상세정보] : " + member);
		logger.debug("[이메일 문의 글 갯수] : " + qnacount);
		logger.debug("[이메일 문의 리스트] : " + qnalist);
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("qnacount", qnacount);
		model.addAttribute("qnalist", qnalist);
		model.addAttribute("member", member);

		return "memberView";
	}
	
	
	//로그인 된 회원 프로필 사진
	@GetMapping("/member/photoView.do")
	public String viewImage(HttpSession session, Model model) {
			
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberDTO memberDTO = memberService.selectMember(user_num);
		
		model.addAttribute("imageFile", memberDTO.getProfile());
		model.addAttribute("filename", memberDTO.getProfile_filename());
			
		return "imageView";
	}
	
	
	//회원 프로필 사진
	@GetMapping("/member/boardPhotoView.do")
	public String boardViewImage(@RequestParam int mem_num, Model model) {
		
		MemberDTO memberDTO = memberService.selectMember(mem_num);
		
		model.addAttribute("imageFile", memberDTO.getProfile());
		model.addAttribute("filename", memberDTO.getProfile_filename());
			
		return "imageView";
	}
	
	
	//마이페이지 내 썸네일 사진 출력
	@GetMapping("/member/thumbnailPhotoView.do")
	public String thumbnailViewImage(HouseBoardDTO houseBoardDTO, @RequestParam int house_num, Model model) {
		
	   Map<String, Object> myMap = new HashMap<String, Object>();
	   
	   myMap.put("house_num", house_num);
	   myMap.put("start", 1);
	   myMap.put("end", 4);
	
	   houseBoardDTO = memberService.myRecommScrapBoardList(myMap);
	   
	   model.addAttribute("imageFile", houseBoardDTO.getHouse_thumbnail());
	   model.addAttribute("filename", houseBoardDTO.getThumbnail_filename());
			
		return "imageView";
	}
	
	
	//회원정보 수정 폼 호출
	@GetMapping("/member/memberUpdate.do")
	public String modifyForm(MemberDTO memberDTO, HttpSession session, Model model) {
		Integer user_num = (Integer) session.getAttribute("user_num");
		
		memberDTO = memberService.selectMember(user_num);
		
		model.addAttribute("memberDTO", memberDTO);
		
		return "memberModify";
	}
	
	//회원정보 수정 - 회원정보 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping(value = {"/member/memberUpdate.do" , "/member/adminMemberUpdate.do"})	//다중매핑
	public String submitUpdate(@Valid MemberDTO memberDTO, BindingResult result, HttpSession session) {
				
		logger.debug("[회원정보 수정 회원] : " + memberDTO);
				
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors()) {
			return "memberModify";
		}
		
		//관리자권한 체크(true=관리자 / false=일반회원)
		boolean adminCheck = false;
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		
		//관리자권한 회원정보 수정 - 탈퇴회원을 제외한 데이터 호출
		if(memberDTO.getMem_num() != 0) {	
			
			//관리자권한으로 회원정보를 수정 시 회원정보를 세션으로 받지 않고 데이터 내 등록된 정보를 받아옴
			user_num = (memberDTO.getMem_num());
			 
			//관리자 권한 부여(리턴 값 달리하기 위함)
			adminCheck = true;			
		}
		
		memberDTO.setMem_num(user_num);
		
		logger.debug("[세션 내 회원 번호] : " + user_num);
		logger.debug("[등록 된 회원 번호] : " + memberDTO.getMem_num());
		
		//회원정보 수정
		memberService.updateMember(memberDTO);
		
		if(adminCheck == false) {
			
			//일반적인 회원인 경우 마이페이지 호출
			return "redirect:/member/myPage.do";
			
		} else {
			
			//관리자 회원인 경우 회원리스트 호출
			return "redirect:/member/memberList.do";
		}
	}
	
	
	//회원정보 수정 - 프로필 사진 변경
	@GetMapping("/member/updateMyPhoto.do")
	@ResponseBody
	public Map<String,String> processProfile(MemberDTO memberDTO, HttpSession session){
		
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//관리자권한 회원정보 수정 - 탈퇴회원을 제외한 데이터 호출
		if(memberDTO.getMem_num() != 0) {
			
			//관리자권한으로 회원정보를 수정 시 회원정보를 세션으로 받지 않고 데이터 내 등록된 정보를 받아옴
			user_num = (memberDTO.getMem_num());
		}
		
		logger.debug("[세션 내 회원 번호] : " + user_num);
		logger.debug("[등록 된 회원 번호] : " + memberDTO.getMem_num());
		
		//로그인 세션이나 데이터에 조회되지 않을 경우
		if(user_num == null) {
			map.put("result", "logout");
			
		} else {
			memberDTO.setMem_num(user_num);
			memberService.updateProfile(memberDTO);
			
			//이미지를 업로드한 후 세션에 저장된 프로필 사진 정보 갱신
			session.setAttribute("user_photo", memberDTO.getProfile());
			
			map.put("result", "success");
		}
		return map;
	}
	
	
	//회원정보 수정 - 비밀번호 변경 폼 호출
	@GetMapping("/member/memberPasswdUpdate.do")
	public String memberPasswdUpdateForm() {
		
		logger.debug("[회원정보 수정 비밀번호 변경 폼 호출]");
		
		return "memberPasswdUpdate";
	}
	
	//회원정보 수정 - 비밀번호 변경 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/memberPasswdUpdate.do")
	public String submitUpdatePasswd(@Valid MemberDTO memberDTO, BindingResult result, HttpSession session) {
		
		logger.debug("[비밀번호 변경 회원] : " + memberDTO);
		
		//유효성 체크 : 현 패스워드나 변경할 패스워드가 다를 시, 수정 폼으로 호출
		if(result.hasFieldErrors("passwd") || result.hasFieldErrors("now_passwd")) {
			
			return memberPasswdUpdateForm();
		}
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//회원정보 데이터 호출
		MemberDTO member = memberService.selectMember(user_num);
		
		//유효성 체크 : 현재 비밀번호와 변경할 패스워드가 같은지 확인
		if(!member.getPasswd().equals(memberDTO.getNow_passwd())) {
			
			//비밀번호가 불일치 할 경우
			result.rejectValue("now_passwd", "invalidPassword");
			
			return memberPasswdUpdateForm();
		}
		
		//회원 번호 전달
		memberDTO.setMem_num(user_num);
		//비밀번호 변경
		memberService.updateMemberPasswd(memberDTO);
		
		return "redirect:/member/myPage.do";
	}
	
	
	//회원정보 내 회원탈퇴
	@PostMapping("/member/memberDelete.do")
	@ResponseBody
	public Map<String, String> memberDelete(String input_pass, HttpSession session){
		
		Map<String, String> map = new HashMap<String, String>();
	
		// 회원 번호 가져오기
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberDTO memberDTO = memberService.selectMember(user_num); // 회원 정보 가져오기
		
		//비밀번호 검증
		boolean check = false;
		check = memberDTO.isCheckedPassword(input_pass);
		
		//로그인 되어있지 않을 경우 로그아웃
		if(user_num == null) {
			map.put("result", "logout");
		}
		
		//비밀번호 검증 시, 비밀번호가 일치한 경우
		if(check) {		
			memberService.deleteMember(user_num);
			map.put("result", "success");
			//로그인 된 세션 삭제 (로그 아웃)
			session.invalidate();
		} else {
			map.put("result", "NotEqualsPasswd");
		}
		
		return map;
	}
	
	
	//판매자 페이지 - 상품 등록 조회
	@GetMapping("/member/myProduct.do")
	public String myProductView(HttpSession session, @RequestParam(value="pageNum", defaultValue="1") int currentPage, Model model) {
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//판매자가 등록한 상품 갯수
		int count = memberService.myProductCount(user_num);
		
		logger.debug("[회원이 등록한 상품 갯수] : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 8, 5, "myProduct.do");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		map.put("mem_num", user_num);
		
		//판매자가 등록한 상품 리스트
		List<StoreDTO> list = null;
		
		if(count > 0) {
			list = memberService.myProductList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "myProductView";
	}
	
	
	//마이페이지 - 내 포인트 조회
	@GetMapping("/member/myPoint.do")
	public String callMyPointView(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		//회원 데이터 조회
		MemberDTO member = memberService.selectMember(user_num);
		
		model.addAttribute("member", member);
		
		return "myPointView";
	}
	
	
	//마이페이지 - 스크랩한 글 리스트 호출
	@GetMapping("/member/myScrap.do")
	public String myScrapBookPage(MemberDTO member, HouseBoardDTO houseBoardDTO, HMarkDTO hMark, HttpSession session, 
								  @RequestParam(value="pageNum", defaultValue="1") int currentPage, 
								  Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mem_num", user_num);
		
		//회원이 스크랩한 게시글의 갯수
		int count = memberService.myScrapBookBoardCounts(map);	
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "myScrap.do");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//회원이 스크랩 누른 글 번호와 게시글을 담을 리스트 List 생성
		List<HouseBoardDTO> myScrapNumList = new ArrayList<HouseBoardDTO>();
		List<HouseBoardDTO> myScrapBoardList = new ArrayList<HouseBoardDTO>();
		
		//회원정보 조회
		member = memberService.selectMember(user_num);
		//회원이 스크랩한 게시글의 번호 변수화 
		myScrapNumList = memberService.myScrapBooksNum(map);		
		
		//게시글의 갯수 검증
		if(count > 0) {
			//스크랩한 게시글 List를, for문을 돌려서 글번호를 추출한 뒤 회원이 스크랩한 게시글 추출
			for(HouseBoardDTO board : myScrapNumList) {
				
				//추천 중복 체크 변수
				int heartCheckNum = 0;
				
				//스크랩 중복 체크 변수
				int scrapCheckNum = 0;
				
				logger.debug("[집들이 게시글 번호] : " + board.getHouse_num());
				
				//집들이 데이터 담을 Map 생성
				Map<String, Object> myMap = new HashMap<String, Object>();
				myMap.put("house_num", board.getHouse_num());
				
				houseBoardDTO = memberService.myRecommScrapBoardList(myMap);
				
				//회원 번호 및 집들이 번호 데이터 
				hMark.setHouse_num(board.getHouse_num());
				hMark.setMem_num(user_num);
				
				//유효성 검사 : 추천 중복 체크
				String alreadyHeart = houseBoardService.checkHeart(hMark);
				
				//추천을 이미 누른 데이터가 있는 경우
				if(alreadyHeart != null) {
					heartCheckNum = 1;
				}
				
				//유효성 검사 : 스크랩 중복 체크
				String alreadyScrap = houseBoardService.checkScrap(hMark);
				//스크랩을 이미 누른 데이터가 있는 경우
				if(alreadyScrap != null) {
					scrapCheckNum = 1;
				}
				
				//추천 수, 스크랩 수 전달, 각각의 중복 체크 전달
				houseBoardDTO.setHouse_recom(houseBoardService.countHeart(board.getHouse_num()));
				houseBoardDTO.setHouse_Scrap(houseBoardService.countScrap(board.getHouse_num()));
				
				//추천/스크랩 각각의 중복 체크 번호 전달
				houseBoardDTO.setScrapCheckNum(scrapCheckNum);
				houseBoardDTO.setHeartCheckNum(heartCheckNum);
				
				myScrapBoardList.add(houseBoardDTO);
			}
		}
		
		model.addAttribute("count", count);
		model.addAttribute("myScrapBoardList", myScrapBoardList);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		model.addAttribute("member", member);
		
		logger.debug("[회원이 스크랩한 집들이 게시물] : " + houseBoardDTO);
		
		return "myScrapView";
	}

	
	//마이페이지 - 추천한 글 리스트 호출
	@GetMapping("/member/myRecomm.do")
	public String myRecommPage(MemberDTO member, HouseBoardDTO houseBoardDTO, HMarkDTO hMark, HttpSession session, 
							   @RequestParam(value="pageNum", defaultValue="1") int currentPage, 
							   Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mem_num", user_num);
		
		//회원이 추천한 게시글의 갯수
		int count = memberService.myRecommBoardCount(map);	
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "myRecomm.do");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//회원이 추천 누른 글 번호와 게시글을 담을 리스트 List 생성
		List<HouseBoardDTO> myRecommNumList = new ArrayList<HouseBoardDTO>();
		List<HouseBoardDTO> myRecommBoardList = new ArrayList<HouseBoardDTO>();
		
		//회원정보 조회
		member = memberService.selectMember(user_num);
		//회원이 추천한 게시글의 번호 변수화 
		myRecommNumList = memberService.myRecommBoardNum(map);	
		
		//게시글의 갯수 검증
		if(count > 0) {
			//추천한 게시글 List를, for문을 돌려서 글번호를 추출한 뒤 회원이 추천한 게시글 추출
			for(HouseBoardDTO board : myRecommNumList) {
				
				//추천 중복 체크 변수
				int heartCheckNum = 0;
				
				//스크랩 중복 체크 변수
				int scrapCheckNum = 0;
				
				logger.debug("[집들이 게시글 번호] : " + board.getHouse_num());
				
				//집들이 데이터 담을 Map 생성
				Map<String, Object> myMap = new HashMap<String, Object>();
				myMap.put("house_num", board.getHouse_num());
				
				houseBoardDTO = memberService.myRecommScrapBoardList(myMap);
				
				//회원 번호 및 집들이 번호 데이터 
				hMark.setHouse_num(board.getHouse_num());
				hMark.setMem_num(user_num);
				
				//유효성 검사 : 추천 중복 체크
				String alreadyHeart = houseBoardService.checkHeart(hMark);
				
				//추천을 이미 누른 데이터가 있는 경우
				if(alreadyHeart != null) {
					heartCheckNum = 1;
				}
				
				//유효성 검사 : 스크랩 중복 체크
				String alreadyScrap = houseBoardService.checkScrap(hMark);
				//스크랩을 이미 누른 데이터가 있는 경우
				if(alreadyScrap != null) {
					scrapCheckNum = 1;
				}
				
				//추천 수, 스크랩 수 전달, 각각의 중복 체크 전달
				houseBoardDTO.setHouse_recom(houseBoardService.countHeart(board.getHouse_num()));
				houseBoardDTO.setHouse_Scrap(houseBoardService.countScrap(board.getHouse_num()));
				
				//추천/스크랩 각각의 중복 체크 번호 전달
				houseBoardDTO.setScrapCheckNum(scrapCheckNum);
				houseBoardDTO.setHeartCheckNum(heartCheckNum);
				
				myRecommBoardList.add(houseBoardDTO);
			}
		}
		
		model.addAttribute("count", count);
		model.addAttribute("myRecommBoardList", myRecommBoardList);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		model.addAttribute("member", member);
		
		logger.debug("[회원이 추천한 집들이 게시물] : " + houseBoardDTO);
		
		return "myRecommView";
	}
	
	
	//마이페이지 - 내가 쓴 글 목록 리스트 호출
	@GetMapping("/member/myBoard.do")
	public String myBoardView(MemberDTO member, HttpSession session, 
							  @RequestParam(value="pageNum", defaultValue="1") int currentPage, 
							  Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");

		Map<String,Object> map = new HashMap<String,Object>();
		
		//내가 쓴 글의 갯수
		int count = houseBoardService.selectMyBoardRowCount(user_num);
				
		logger.debug("[내가 쓴 글의 갯수] : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,pageCount,"myBoard.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		map.put("mem_num", user_num);
		
		member = memberService.selectMember(user_num);
		
		logger.debug("[내가 쓴 글 목록 리스트] : " + member);
		
		List<HouseBoardDTO> list = null;
		
		if(count > 0) {
			list = houseBoardService.selectMyBoardList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		model.addAttribute("member", member);
		
		return "myBoardView";
	}
	
	//마이페이지 - 판매자 신청 등록 폼 호출
	@GetMapping("/member/sellerApplication.do")
	public String sellerApplication(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
					    
		//판매자 신청 수
		int count = memberService.selectCountSeller(user_num);		
		
		logger.debug("[판매자 신청 등록 갯수] : " + count);
		
		model.addAttribute("count", count);
		
		return "sellerApplication";
	}
	
	
	//마이페이지 - 판매자 신청 등록 - 판매자 신청 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/sellerApplication.do")
	public String sellerApplicationProcess(@Valid MemberBuisDTO memberBuisDTO, BindingResult result, HttpSession session) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//유효성 체크 : 오류 발생 시, 판매자 신청 등록 폼으로 호출
		if(result.hasErrors()) {
		
			return "sellerApplication";
		}
		
		memberBuisDTO.setMem_num(user_num);
		
		logger.debug("[판매자 신청 등록 정보] : " + memberBuisDTO);

		memberService.insertSeller(memberBuisDTO);
		
		return "redirect:/member/myPage.do";
	}
	
	
	//마이페이지 - 나의 쿠폰 조회
	@GetMapping("/member/myCoupon.do")
	public String myCouponList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		//회원이 보유한 쿠폰 갯수
		int count = memberService.selectGetCouponCount(user_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,mem_rowCount,mem_pageCount,"myCoupon.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		map.put("mem_num", user_num);
		
		//나의 쿠폰 리스트
		List<MemberDTO> list = null;
		
		if(count > 0) {
			list = memberService.selectGetCouponList(map);
		}
		
		logger.debug("[나의 쿠폰 리스트] : " + list);
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		return "myCouponView";
	}
	
	
	//관리자 페이지 - 전체 회원 리스트
	@GetMapping("/member/memberList.do")
	public String memberListForm(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								 @RequestParam(value="keyfield",defaultValue = "") String keyfield,
						         @RequestParam(value="keyword",defaultValue = "1") String keyword, 
						         Model model) {
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
	    map.put("keyword", keyword);
	    
		//회원 수
		int count = memberService.selectMemberCount(map);
						
		logger.debug("[회원 수] : " + count);
				
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage,count,mem_rowCount,mem_pageCount,"memberList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());

		//회원 리스트
		List<MemberDTO> list = null;
		
		if(count > 0) {
			list = memberService.selectMemberList(map);
		}
				
		logger.debug("[회원 리스트]: " + list);
				
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
				
		return "memberAllList";
	}
	
	
	//관리자 페이지 - 회원 수정
	@GetMapping("/member/adminMemberUpdate.do")
	public String adminMemberUpdate(MemberDTO memberDTO, @RequestParam int mem_num, Model model) {
		
		memberDTO = memberService.selectMember(mem_num);
		
		model.addAttribute("memberDTO", memberDTO);
		
		return "adminMemberUpdate";
	}
	
	
	//관리자 페이지 - 회원 정지
	@PostMapping("/member/stopAdminMember.do")
	@ResponseBody
	public Map<String, String> memberStop(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateMemberStop(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	//관리자 페이지 - 일반회원으로 등급 변경(정지회원도 일반회원으로 변경가능)
	@PostMapping("/member/upCommonaMember.do")
	@ResponseBody
	public Map<String, String> memberStopCancel(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateMemberStopCancel(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
		
	}
	
	//관리자 페이지 - 판매자 회원으로 등급 변경
	@PostMapping("/member/upSellerMember.do")
	@ResponseBody
	public Map<String, String> memberUpdateSeller(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateMemberSellerAuth(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}


	//관리자 페이지 - 관리자로 등급 변경
	@PostMapping("/member/upAdminMember.do")
	@ResponseBody
	public Map<String, String> memberUpdateAdmin(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateMemberAdminAuth(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}	
	
	
	//관리자 페이지 - 회원 탈퇴
	@PostMapping("/member/deleteAdminMember.do")
	@ResponseBody
	public Map<String, String> adminMemberDelete(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		for(String mem_num : stopChecked) {
			memberService.deleteMember(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
		
	}
	
	//관리자 페이지 - 비밀번호 초기화
	@PostMapping("/member/resetPasswdMember.do")
	@ResponseBody
	public Map<String, String> resetPasswdMember(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateMemberPasswdReset(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	
	//관리자 페이지 - 판매자 신청내역 조회
	@GetMapping("/member/sellerApplyList.do")
	public String sellerApplyListForm(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
										 	@RequestParam(value="keyfield",defaultValue = "") String keyfield,
										 	@RequestParam(value="keyword",defaultValue = "1") String keyword,
										 	Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
	    map.put("keyword", keyword);
			    
		//판매자 신청 수
		int count = memberService.selectMemberBuisCount(map);								
		
		logger.debug("[판매자 신청] : " + count);
						
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage,count,mem_rowCount,mem_pageCount,"sellerApplyList.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//판매자 신청 리스트
		List<MemberBuisDTO> list = null;
		
		if(count > 0) {
			list = memberService.selectMemberBuisList(map);
		}
						
		logger.debug("[판매자 신청 수] : " + list);
						
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
						
		return "sellerApplyList";
	}
	
	
	//관리자 페이지 - 판매자 등록
	@PostMapping("/member/memberRegistSeller.do")
	@ResponseBody
	public Map<String, String> sellerRegistMember(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String mem_num : stopChecked) {
			memberService.updateSellerMember(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	
	//관리자 페이지 - 판매자 등록 신청 취소
	@PostMapping("/member/memberCancelSeller.do")
	@ResponseBody
	public Map<String, String> sellerCancelMember(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		for(String mem_num : stopChecked) {
			memberService.deleteSellerMember(Integer.parseInt(mem_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	
	//관리자 페이지 - 쿠폰 등록 폼 호출
	@GetMapping("/member/couponRegisterView.do")
	public String couponRegisterForm() {
		
		return "couponRegister";
	}
	
	//관리자 페이지 - 쿠폰 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/couponRegisterView.do")
	public String couponRegisterSubmit(@Valid MemberDTO memberDTO, BindingResult result) {
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return couponRegisterForm();
		}
		
		logger.debug("[쿠폰 등록할 회원 정보] : " + memberDTO);
		
		//특정회원 쿠폰 등록
		memberService.insertCoupon(memberDTO);
		
		return "redirect:/member/myPage.do";
	}
	
	
	//관리자 페이지 - 전체 쿠폰 조회 폼 호출
	@GetMapping("/member/aminCouponAllView.do")
	public String adminCouponAllView(@RequestParam(value="pageNum", defaultValue="1") int currentPage, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//쿠폰 갯수
		int count = memberService.selectCouponAllCount();
		
		logger.debug("[쿠폰 갯수] : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,mem_rowCount,mem_pageCount,"couponAllView.do");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//쿠폰 리스트
		List<MemberDTO> list = null;
		
		if(count > 0) {
			list = memberService.selectCouponAllList(map);
		}
		
		logger.debug("[쿠폰 리스트] : " + list);
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		
		return "couponAllView";

	}
	
	
	//관리자 페이지 - 쿠폰 삭제
	@PostMapping("/member/deleteCoupon.do")
	@ResponseBody
	public Map<String, String> couponDelete(@RequestParam String output) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		for(String coupondetail_num : stopChecked) {
			memberService.deleteCoupon(Integer.parseInt(coupondetail_num));
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	//관리자 페이지 - 쿠폰 수정 폼 호출
	@GetMapping("/member/couponModifyView.do")
	public String couponModifyForm(MemberDTO memberDTO, @RequestParam int coupondetail_num, Model model) {
		
		memberDTO = memberService.couponSelect(coupondetail_num);
		
		model.addAttribute("member", memberDTO);
		
		return "couponModify";
	}
	
	// 관리자 페이지 - 쿠폰 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/member/couponModifyView.do")
	public String couponModify(@Valid MemberDTO memberDTO, BindingResult result) {
		
		logger.debug("[쿠폰 수정 회원] : " + memberDTO);
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors())
			return "couponModify";
		
		//쿠폰 정보 변경
		memberService.updateCoupon(memberDTO);
		
		return "redirect:/member/aminCouponAllView.do";
	}
	
	
	//관리자 페이지 - 회원별 쿠폰 배정
	@PostMapping("/member/memberCouponRegister.do")
	@ResponseBody
	public Map<String, String> CouponMemberReg(MemberDTO member, @RequestParam String output, @RequestParam int coupondetail_num) {
		
		String[] stopChecked = output.split(",");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		member = memberService.couponSelect(coupondetail_num);
		
		logger.debug("[전달받은 쿠폰 문자] : " + output);
		logger.debug("[쿠폰의 고유 번호] : " + coupondetail_num);
		logger.debug("[회원 정보] : " + member);
		
		if(member.getCoupon_name() == null) {
			mapAjax.put("result", "fail");
			
		} else {
			for(String mem_num : stopChecked) {
				memberService.insertMemberCouponReg(Integer.parseInt(mem_num), coupondetail_num);
				
				mapAjax.put("result", "success");
			}
		}
		
		return mapAjax;
	}
	
	
	/* 회원가입 시 이메일 인증 난수코드 생성 메서드 */
	//인증 키 범위
	private int certCharLength = 8;
	//난수코드 데이터
    private final char[] characterTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
                                            'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 
                                            'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };

	public String excuteGenerate() {
		//난수코드 
        Random random = new Random(System.currentTimeMillis());
       
        int tablelength = characterTable.length;
        
        StringBuffer buf = new StringBuffer();
        
        //난수코드 for문을 통해 반복문 출력
        for(int i = 0; i < certCharLength; i++) {
            buf.append(characterTable[random.nextInt(tablelength)]);
        }
        
        return buf.toString();
    }

	//@Getter @Setter
    public int getCertCharLength() {
        return certCharLength;
    }

    public void setCertCharLength(int certCharLength) {
        this.certCharLength = certCharLength;
    }
}
