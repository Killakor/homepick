package com.teamproject.member.service;

import java.util.List;
import java.util.Map;

import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.member.bean.MemberBuisDTO;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.store.bean.StoreDTO;

public interface MemberService {
	
	/* 회원 정보 */
	//회원 가입 - 회원 필수 정보
	public void insertMember(MemberDTO member);
	
	//회원 아이디 중복 검사
	public MemberDTO selectCheckMember(String mem_id);
	
	//회원 아이디 찾기
	public List<MemberDTO> SelectIdSearch(Map<String, Object> map);
	
	
	
	/* 마이 페이지 */
	//회원 정보 조회
	public MemberDTO selectMember(Integer mem_num);
	
	//회원의 추천 게시글 번호 리스트
	public List<HouseBoardDTO> myRecommBoardNum(Map<String, Object> map);
	
	//회원이 추천한 게시글의 갯수
	public int myRecommBoardCount(Map<String, Object> map);
	
	//회원이 스크랩한 게시글의 번호 리스트
	public List<HouseBoardDTO> myScrapBooksNum(Map<String, Object> map);
	
	//회원이 스크랩한 게시글의 갯수
	public int myScrapBookBoardCounts(Map<String, Object> map);
	
	//회원이 추천 및 스크랩한 게시글 리스트
	public HouseBoardDTO myRecommScrapBoardList(Map<String, Object> map);
	
	//프로필 사진 수정
	public void updateProfile(MemberDTO member);
	
	//회원 정보 수정
	public void updateMember(MemberDTO member);
	
	//회원 비밀번호 변경
	public void updateMemberPasswd(MemberDTO member);

	//회원 탈퇴
	public void deleteMember(Integer mem_num);
	
	//회원이 보유한 쿠폰 갯수
	public List<MemberDTO> selectGetCouponList(Map<String, Object> map);
	
	
	
	/* 판매자 */
	//판매자 신청 등록 (판매자 회원 상세정보 추가)
	public void insertSeller(MemberBuisDTO memberBuisDTO);
	
	//판매자 신청 수
	public int selectCountSeller(Integer mem_num);
	
	//판매자가 등록한 상품 갯수
	public int myProductCount(Integer mem_num);
	
	//판매자가 등록한 상품 리스트
	public List<StoreDTO> myProductList(Map<String, Object> map);

	//회원이 보유한 쿠폰 갯수
	public int selectGetCouponCount(Integer mem_num);
	

	
	/* 관리자 */
	//전체 회원 리스트
	public List<MemberDTO> selectMemberList(Map<String, Object> map);
	
	//전체 회원 수
	public int selectMemberCount(Map<String, Object> map);
	
	//회원 등급 변경 - 회원 정지
	public void updateMemberStop(Integer mem_num);
	
	//회원 등급 변경 - 일반 회원으로 변경
	public void updateMemberStopCancel(Integer mem_num);
	
	//회원 등급 변경 - 판매자로 변경
	public void updateMemberSellerAuth(Integer mem_num);
	
	//회원 등급 변경 - 관리자로 변경
	public void updateMemberAdminAuth(Integer mem_num);
	
	//회원 비밀번호 초기화
	public void updateMemberPasswdReset(Integer mem_num);
	
	//판매자 신청 리스트
	public List<MemberBuisDTO> selectMemberBuisList(Map<String, Object> map);
	
	//판매자 신청 수
	public int selectMemberBuisCount(Map<String, Object> map);

	//판매자 신청 등록 (회사지원 상태 변경 null:판매자x / 2:판매자)
	public void updateSellerMember(Integer mem_num);
	
	//판매자 등록 신청 취소
	public void deleteSellerMember(Integer mem_num);
	
	//쿠폰 부분
	public void insertCoupon(MemberDTO memberDTO);
	
	//쿠폰 갯수
	public int selectCouponAllCount();
	
	//쿠폰 리스트
	public List<MemberDTO> selectCouponAllList(Map<String, Object> map);
	
	//쿠폰 상세정보
	public MemberDTO couponSelect(Integer coupondetail_num);

	//쿠폰 수정
	public void updateCoupon(MemberDTO memberDTO);

	//쿠폰 삭제
	public void deleteCoupon(Integer coupondetail_num);

	//회원별 쿠폰 배정
	public void insertMemberCouponReg(Integer mem_num, Integer coupondetail_num);
}
