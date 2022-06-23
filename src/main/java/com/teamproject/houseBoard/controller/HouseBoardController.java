package com.teamproject.houseBoard.controller;

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

import com.teamproject.houseBoard.bean.HCommentDTO;
import com.teamproject.houseBoard.bean.HMarkDTO;
import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.houseBoard.service.HouseBoardService;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.service.MemberService;
import com.teamproject.util.HousePagingUtil;
import com.teamproject.util.PagingUtil;
import com.teamproject.util.StringUtil;

@Controller
public class HouseBoardController {
	
	//로그(@Slf4j와 동일)
	private static final Logger logger = LoggerFactory.getLogger(HouseBoardController.class);
	
	private int rowCount = 12;	//한 페이지의 게시물의 수
	private int pageCount = 7;	//한 화면에 보여줄 페이지 수
	
	//의존성 주입
	@Autowired
	private HouseBoardService houseBoardService;
	
	@Autowired
	private MemberService memberService;
	
	//스프링빈 초기화
	@ModelAttribute
	public HouseBoardDTO initHouseBoard() {
		return new HouseBoardDTO();
	}
	
	
	//집들이 등록 폼 호출
	@GetMapping("/houseBoard/write.do")
	public String form() {
		
		return "houseBoardWrite";
	}
	
	
	//집들이 등록 - 집들이 등록 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/houseBoard/write.do")
	public String submit(@Valid HouseBoardDTO houseBoardDTO, BindingResult result, HttpSession session) {
		
		logger.debug("[집들이 게시물 등록 내용] : " + houseBoardDTO);
		
		//유효성 체크 : 오류 발생 시, 등록 폼으로 호출
		if(result.hasErrors()) {
			return form();
		}
		
		houseBoardDTO.setMem_num((Integer)session.getAttribute("user_num"));
		houseBoardService.insertHBoard(houseBoardDTO);
		
		return "redirect:/houseBoard/list.do";
	}
	
	
	//집들이 리스트
	@GetMapping("/houseBoard/list.do")
	public String Process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
						  @RequestParam(value="size", defaultValue="") String size,
						  @RequestParam(value="residence", defaultValue="") String residence,
						  @RequestParam(value="style", defaultValue="") String style,
						  @RequestParam(value="space", defaultValue="") String space,
						  Model model) {
		
		//출력 값 지정
		String keyfield = "";
		String keyword = "";
		
		String sizeOutput = "";
		String residenceOutput = "";
		String styleOutput = "";
		String spaceOutput = "";
		
		/* 출력값 데이터 지정 */
		if(!size.equals("")) {
			keyfield = "1";
			
			switch(size) {
				case "0":
					keyword = "10평 미만";
					break;
				case "1":
					keyword = "10평대";
					break;
				case "2":
					keyword = "20평대";
					break;
				case "3":
					keyword = "30평대";
					break;
				case "4":
					keyword = "40평대";
					break;
				case "5":
					keyword = "50평 이상";
					break;
				default:
					keyword = "";
			}
			
			sizeOutput = keyword;
		}
		
		if(!residence.equals("")) {
			keyfield = "2";

			switch(residence) {
				case "0":
					keyword = "원룸&오피스텔";
					break;
				case "1":
					keyword = "아파트";
					break;
				case "2":
					keyword = "빌라&연립";
					break;
				case "3":
					keyword = "단독주택";
					break;
				case "4":
					keyword = "사무공간";
					break;
				case "5":
					keyword = "상업공간";
					break;
				default:
					keyword = "";
			}
			
			residenceOutput = keyword;
		}
		
		if(!style.equals("")) {
			keyfield = "3";
			
			switch(style) {
				case "0":
					keyword = "모던";
					break;
				case "1":
					keyword = "북유럽";
					break;
				case "2":
					keyword = "빈티지";
					break;
				case "3":
					keyword = "내추럴";
					break;
				case "4":
					keyword = "프로방스&로맨틱";
					break;
				case "5":
					keyword = "클래식&앤틱";
					break;
				case "6":
					keyword = "한국&아시아";
					break;
				case "7":
					keyword = "유니크";
					break;
				default:
					keyword = "";
			}
			
			styleOutput = keyword;
		}
		
		if(!space.equals("")) {
			keyfield = "4";
			
			switch(space) {
				case "0":
					keyword = "원룸";
					break;
				case "1":
					keyword = "거실";
					break;
				case "2":
					keyword = "침실";
					break;
				case "3":
					keyword = "주방";
					break;
				case "4":
					keyword = "욕실";
					break;
				case "5":
					keyword = "아이방";
					break;
				case "6":
					keyword = "드레스룸";
					break;
				case "7":
					keyword = "서재&작업실";
					break;
				case "8":
					keyword = "베란다";
					break;
				case "9":
					keyword = "사무공간";
					break;
				case "10":
					keyword = "상업공간";
					break;
				case "11":
					keyword = "가구&소품";
					break;
				case "12":
					keyword = "현관";
					break;
				case "13":
					keyword = "외관&기타";
					break;
				default:
					keyword = "";
			}
			
			spaceOutput = keyword;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sizeOutput", sizeOutput);
		map.put("residenceOutput", residenceOutput);
		map.put("styleOutput", styleOutput);
		map.put("spaceOutput", spaceOutput);
		
		//집들이 게시물 갯수
		int count = houseBoardService.selectRowCount(map);
		logger.debug("[집들이 게시물 갯수] : " + count);
		
		//페이지 처리
		HousePagingUtil page = new HousePagingUtil(currentPage, count, rowCount, pageCount, 
												   "list.do?size="+ size +"&residence="+ residence +"&style="+ style +"&space="+space);
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//집들이 게시물 리스트
		List<HouseBoardDTO> list = null;
		if(count > 0) {
			
			list = houseBoardService.selectHBoardList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("pagingHtml", page.getPagingHtml());
		
		model.addAttribute("size", size);
		model.addAttribute("residence", residence);
		model.addAttribute("style", style);
		model.addAttribute("space", space);
		
		model.addAttribute("sizeOutput", sizeOutput);
		model.addAttribute("residenceOutput", residenceOutput);
		model.addAttribute("styleOutput", styleOutput);
		model.addAttribute("spaceOutput", spaceOutput);
		
		return "houseBoardList";
	}
	
	
	//집들이 썸네일 이미지 출력
	@GetMapping("/houseBoard/imageView.do")
	public String thumbnailImage(@RequestParam int house_num, HouseBoardDTO houseBoard, Model model) {
		
		houseBoard = houseBoardService.selectHBoard(house_num);
		logger.debug("[집들이 이미지 정보] : " + houseBoard);
		
		model.addAttribute("imageFile", houseBoard.getHouse_thumbnail());
		model.addAttribute("filename", houseBoard.getThumbnail_filename());
		
		return "imageView";
	}

	//집들이 댓글 회원 프로필 사진
	@GetMapping("/houseBoard/boardProfile.do")
	public String boardProfileImage(@RequestParam int mem_num, MemberDTO memberDTO, Model model) {
		
		memberDTO = memberService.selectMember(mem_num);
		
		model.addAttribute("imageFile", memberDTO.getProfile());
		model.addAttribute("filename", memberDTO.getProfile_filename());
		
		return "imageView";
	}	
	
	
	//집들이 게시물 상세보기
	@GetMapping("/houseBoard/detail.do")
	public String process(@RequestParam int house_num, HttpSession session, HouseBoardDTO houseBoard, HMarkDTO hMark, Model model) {
		
		//게시물 조회수 증가
		houseBoardService.updateHBoardHits(house_num);
		
		//세션을 통한 회원정보 불러오기
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//추천 중복 체크 변수
		int heartCheckNum = 0;
		int countHeart = 0;
		
		//스크랩 중복 체크 변수
		int scrapCheckNum = 0;
		int countScrap = 0;
		
		// selectHBoard에 글번호 전달
		houseBoard = houseBoardService.selectHBoard(house_num);
		
		//HTML 태그 불허용
		houseBoard.setHouse_title(StringUtil.useNoHtml(houseBoard.getHouse_title()));
		//HTML 태그 불허, 줄바꿈 허용
		//houseBoard.setHouse_content(StringUtil.useBrNoHtml(houseBoard.getHouse_content()));
	    //CK에디터 사용하므로 주석 처리
	    
		//추천수
		countHeart = houseBoardService.countHeart(house_num);
		//스크랩수
		countScrap = houseBoardService.countScrap(house_num);
		//댓글수
		int countComm = houseBoardService.countComm(house_num);
		
		//추천 버튼 클릭
		if(user_num == null) {
			//미로그인 시, 추천에 변동 없음
	    	heartCheckNum = 0;
		} else {
			//로그인 시, 추천 클릭 시 변동
			hMark.setHouse_num(house_num);
			hMark.setMem_num(user_num);
			
			//추천 중복 체크
			String alreadyHeart = houseBoardService.checkHeart(hMark);
			
			if(alreadyHeart == null) {
				
			} else {
				heartCheckNum = 1;
			}
		}
		
		//스크랩 버튼 클릭
		if(user_num == null) {
			//미로그인 시, 스크랩에 변동 없음
			scrapCheckNum = 0;
		} else {
			//로그인 시, 스크랩 클릭 시 변동
			hMark.setHouse_num(house_num);
			hMark.setMem_num(user_num);
			
			//스크랩 중복 체크
			String alreadyScrap = houseBoardService.checkScrap(hMark);
			
			if(alreadyScrap == null) {
				
			} else {
				scrapCheckNum = 1;
			}
		}

		model.addAttribute("houseBoard", houseBoard);
	    model.addAttribute("heartCheckNum", heartCheckNum);
	    model.addAttribute("countHeart", countHeart);
	    model.addAttribute("scrapCheckNum", scrapCheckNum);
	    model.addAttribute("countScrap", countScrap);
	    model.addAttribute("countComm", countComm);
	    model.addAttribute("user_auth", user_auth);
	     
		return "houseBoardDetail";
	}
	
	
	//집들이 수정 폼 호출
	@GetMapping("/houseBoard/update.do")
	public String formUpdate(@RequestParam int house_num, HouseBoardDTO houseBoardDTO, Model model) {
		
		houseBoardDTO = houseBoardService.selectHBoard(house_num);
		
		model.addAttribute("houseBoardDTO", houseBoardDTO);
		
		return "houseBoardModify";
	}
	
	
	//집들이 수정 - 집들이 수정 처리 완료 [@Valid - 객체 검증]
	@PostMapping("/houseBoard/update.do")
	public String submitUpdate(@Valid HouseBoardDTO houseBoardDTO, BindingResult result, HttpServletRequest request, Model model) {
		
		logger.debug("[집들이 게시물 수정 내용] : " + houseBoardDTO);
		
		//유효성 체크 : 오류 발생 시, 수정 폼으로 호출
		if(result.hasErrors()) {
			return "houseBoardModify";
		}
		
		houseBoardService.updateHBoard(houseBoardDTO);

		model.addAttribute("message", "집들이 게시물 수정이 완료 되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/houseBoard/list.do");
		
		return "common/resultView";
	}
	
	
	//집들이 수정 - 썸네일 이미지 삭제
	//결과정보 직접 호출
	@RequestMapping("/houseBoard/deleteFile.do")
	@ResponseBody
	public Map<String, String> processFile(int house_num, HttpSession session) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		//세션 유효성 체크
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			map.put("result", "logout");
			
		} else {
			houseBoardService.deleteFile(house_num);
			map.put("result", "success");
		}
		
		return map;
	}
	
	
	//CKEditor를 이용한 이미지 업로드
	@RequestMapping("/houseBoard/imageUploader.do")
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
		logger.debug("[업로드 할 파일 경로] : " + filepath);
		
		File f = new File(filepath);
		
		//폴더가 존재하지 않는다면 폴더를 생성
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

	
	//집들이 삭제
	@GetMapping("/houseBoard/delete.do")
	public String submitDelete(@RequestParam int house_num) {
		
		logger.debug("[집들이 번호 게시물 삭제] : " + house_num);
		
		houseBoardService.deleteHBoard(house_num);
		
		return "redirect:/houseBoard/list.do";
	}
	
	
	//집들이 상세페이지 내 댓글 등록(httpAPI)
	@RequestMapping("/houseBoard/writeComm.do")
	@ResponseBody
	public Map<String, String> writeComm(HCommentDTO hCommentDTO, HttpSession session) {
		
		logger.debug("[댓글 등록 정보] : " + hCommentDTO);
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//로그인 여부 체크
		if(user_num == null) {
			map.put("result", "logout");
			
		} else {
			houseBoardService.insertComm(hCommentDTO);
			map.put("result", "success");
		}
		
		return map;
	}
	
	
	//집들이 상세페이지 내 댓글 목록(httpAPI)
	@RequestMapping("/houseBoard/listComm.do")
	@ResponseBody
	public Map<String,Object> getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									  @RequestParam int house_num) {
		
		logger.debug("[현재 페이지] : " + currentPage);
		logger.debug("[집들이 게시물 번호] : " + house_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("house_num", house_num);
		
		//댓글수
		int count = houseBoardService.selectRowCountComm(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, null);
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		//댓글 리스트
		List<HCommentDTO> list = null;
		
		if(count > 0) {
			list = houseBoardService.selectListComm(map);
		} else {
			//댓글이 없을 경우 빈 리스트 전달
			list = Collections.emptyList();
		}
		
		Map<String,Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);
		
		return mapJson;
	}
	
	
	//집들이 상세페이지 내 댓글 수정(httpAPI)
	@RequestMapping("/houseBoard/updateComm.do")
	@ResponseBody
	public Map<String, String> updateComm(HCommentDTO hCommentDTO, HttpSession session) {
		
		logger.debug("[댓글 수정 정보] : " + hCommentDTO);
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		//세션 유효성 체크
		if(user_num == null) {
			map.put("result", "logout");
		
		//로그인 되어있고 로그인한 회원번호와 집들이 게시물 회원번호가 일치하거나 관리자일 경우 수정 가능
		} else if(user_num != null && user_num == hCommentDTO.getMem_num() || user_auth == 4) {
			houseBoardService.updateComm(hCommentDTO);
			map.put("result", "success");
		} else {
			map.put("result", "wrongAcess");
		}
		
		return map;
	}
	
	
	//집들이 상세페이지 내 댓글 삭제(httpAPI)
	@RequestMapping("/houseBoard/deleteComm.do")
	@ResponseBody
	public Map<String,String> deleteComm(@RequestParam int comm_num, @RequestParam int mem_num, HttpSession session) {
		
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
			houseBoardService.deleteComm(comm_num);
			map.put("result", "success");
		} else {
			map.put("result", "wrongAccess");
		}
		
		return map;
	}
	
	
	//추천 버튼(httpAPI)
	@RequestMapping("/houseBoard/heart.do")
	@ResponseBody
	public Map<String, String> heartButton(@RequestParam int house_num, HttpSession session, HMarkDTO hMark) {
		
		logger.debug("[집들이 게시물 번호] : " + house_num);
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		logger.debug("[회원 번호] : " + user_num);
		
		//추천수
		int countHeart = houseBoardService.countHeart(house_num);
		
		//세션 유효성 체크
		if(user_num == null) {
			map.put("result", "logout");
			
		} else {
			hMark.setHouse_num(house_num);
			hMark.setMem_num(user_num);
			
			//추천 중복 체크
			String alreadyHeart = houseBoardService.checkHeart(hMark);
			
			//추천한 적 없음
			if(alreadyHeart == null) {
				//추천수 증가
				houseBoardService.insertHeart(hMark);
				countHeart += 1;
				
				map.put("result", "success");
				map.put("countHeart", String.valueOf(countHeart));
			
			//추천한 적 있음
			} else {
				//추천수 감소
				houseBoardService.deleteHeart(hMark);
				countHeart -= 1;
				
				map.put("result", "cancel");
				map.put("countHeart", String.valueOf(countHeart));
			}
		}
		
		return map;
	}
	
	
	//스크랩 버튼(httpAPI)
	@RequestMapping("/houseBoard/scrap.do")
	@ResponseBody
	public Map<String,String> scrapButton(@RequestParam int house_num, HttpSession session, HMarkDTO hMark) {
		
		logger.debug("[집들이 게시물 번호] : " + house_num);
		
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		logger.debug("[회원 번호] : " + user_num);
		
		//스크랩수
		int countScrap = houseBoardService.countScrap(house_num);
		
		//세션 유효성 체크
		if(user_num == null) {
			map.put("result", "logout");
			
		} else {
			hMark.setHouse_num(house_num);
			hMark.setMem_num(user_num);
			
			//스크랩 중복 체크
			String alreadyScrap = houseBoardService.checkScrap(hMark);
			
			//스크랩한 적 없음
			if(alreadyScrap == null) {
				//스크랩수 증가
				houseBoardService.insertScrap(hMark);
				countScrap += 1;
				
				map.put("result", "success");
				map.put("countScrap", String.valueOf(countScrap));
			
			//스크랩한 적 있음
			} else {
				//스크랩수 감소
				houseBoardService.deleteScrap(hMark);
				countScrap -= 1;
				
				map.put("result", "cancel");
				map.put("countScrap", String.valueOf(countScrap));
			}
		}
		
		return map;
	}
	
}
