package com.teamproject.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.member.bean.MemberBuisDTO;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.member.dao.MemberMapper;
import com.teamproject.store.bean.StoreDTO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberDAO;

	@Override
	public void insertMember(MemberDTO member) {
		//회원 번호 자동 생성
		member.setMem_num(memberDAO.seleceMem_num());
		memberDAO.insertMember(member);
		memberDAO.insertMember_datail(member);
	}
	
	@Override
	public MemberDTO selectCheckMember(String mem_id) {
		//회원 아이디 중복 체크
		return memberDAO.selectCheckMember(mem_id);
	}
	
	@Override
	public MemberDTO selectMember(Integer mem_num) {
		
		MemberDTO memberDTO = memberDAO.selectMember(mem_num);
		//회원이 보유한 쿠폰 갯수 저장
		memberDTO.setCoupon_count(memberDAO.selectGetCouponCount(mem_num));
		//회원이 추천한 게시글의 갯수 저장
		memberDTO.setRecommend_count(memberDAO.myRecommCount(mem_num));
		//회원이 스크랩한 게시글의 갯수 저장
		memberDTO.setScrapbook_count(memberDAO.myScrapBookCount(mem_num));
		//회원이 작성한 게시글의 갯수 저장
		memberDTO.setHouse_board_count(memberDAO.selectGetHouseBoardCount(mem_num));
		
		return memberDTO;
	}
	
	@Override
	public void updateProfile(MemberDTO member) {
		memberDAO.updateProfile(member);
	}
	
	@Override
	public void updateMember(MemberDTO member) {
		memberDAO.updateMember(member);
	}
	
	@Override
	public void deleteMember(Integer mem_num) {
		memberDAO.deleteMemberDetail(mem_num);
		memberDAO.deleteMember(mem_num);
	}
	
	@Override
	public void insertSeller(MemberBuisDTO memberBuisDTO) {
		memberDAO.insertSeller(memberBuisDTO);
	}
	
	@Override
	public List<MemberDTO> selectMemberList(Map<String, Object> map) {
		return memberDAO.selectMemberList(map);
	}
	
	@Override
	public int selectMemberCount(Map<String, Object> map) {
		return memberDAO.selectMemberCount(map);
	}
	
	@Override
	public void updateMemberStop(Integer mem_num) {
		memberDAO.updateMemberStop(mem_num);
	}
	
	@Override
	public void updateMemberStopCancel(Integer mem_num) {
		memberDAO.updateMemberStopCancel(mem_num);
	}
	
	@Override
	public void updateMemberSellerAuth(Integer mem_num) {
		memberDAO.updateMemberSellerAuth(mem_num);
	}
	
	@Override
	public void updateMemberAdminAuth(Integer mem_num) {
		memberDAO.updateMemberAdminAuth(mem_num);
	}
	
	@Override
	public void updateMemberPasswdReset(Integer mem_num) {
		memberDAO.updateMemberPasswdReset(mem_num);
	}
	
	@Override
	public List<MemberBuisDTO> selectMemberBuisList(Map<String, Object> map) {
		return memberDAO.selectMemberBuisList(map);
	}
	
	@Override
	public int selectMemberBuisCount(Map<String, Object> map) {
		return memberDAO.selectMemberBuisCount(map);
	}
	
	@Override
	public void updateSellerMember(Integer mem_num) {
		memberDAO.updateSellerMember(mem_num);
		memberDAO.updateMemberSellerAuth(mem_num);
	}
	
	@Override
	public void deleteSellerMember(Integer mem_num) {
		memberDAO.deleteSellerMember(mem_num);
		
	}
	
	@Override
	public List<MemberDTO> SelectIdSearch(Map<String, Object> map) {
		return memberDAO.SelectIdSearch(map);
	}
	
	@Override
	public void updateMemberPasswd(MemberDTO member) {
		memberDAO.updateMemberPasswd(member);
	}
	
	@Override
	public int selectCountSeller(Integer mem_num) {
		return memberDAO.selectCountSeller(mem_num);
	}

	@Override
	public List<HouseBoardDTO> myRecommBoardNum(Map<String, Object> map) {
		return memberDAO.myRecommBoardNum(map);
	}
	
	@Override
	public int myRecommBoardCount(Map<String, Object> map) {
		return memberDAO.myRecommBoardCount(map);
	}
	
	@Override
	public HouseBoardDTO myRecommScrapBoardList(Map<String, Object> map) {
		return memberDAO.myRecommScrapBoardList(map);
	}
	
	@Override
	public List<HouseBoardDTO> myScrapBooksNum(Map<String, Object> map) {
		return memberDAO.myScrapBooksNum(map);
	}
	
	@Override
	public int myScrapBookBoardCounts(Map<String, Object> map) {
		return memberDAO.myScrapBookBoardCounts(map);
	}
	
	@Override
	public int myProductCount(Integer mem_num) {
		return memberDAO.myProductCount(mem_num);
	}
	
	@Override
	public List<StoreDTO> myProductList(Map<String, Object> map) {
		return memberDAO.myProductList(map);
	}
	
	@Override
	public void insertCoupon(MemberDTO memberDTO) {
		memberDAO.insertCoupon(memberDTO);
	}
	
	@Override
	public int selectCouponAllCount() {
		return memberDAO.selectCouponAllCount();
	}
	
	@Override
	public List<MemberDTO> selectCouponAllList(Map<String, Object> map) {
		return memberDAO.selectCouponAllList(map);
	}
	
	@Override
	public void deleteCoupon(Integer coupondetail_num) {
		memberDAO.deleteCoupon(coupondetail_num);
	}
	
	@Override
	public MemberDTO couponSelect(Integer coupondetail_num) {
		return memberDAO.couponSelect(coupondetail_num);
	}
	
	@Override
	public void updateCoupon(MemberDTO memberDTO) {
		memberDAO.updateCoupon(memberDTO);
	}
	
	@Override
	public void insertMemberCouponReg(Integer mem_num, Integer coupondetail_num) {
		memberDAO.insertMemberCouponReg(mem_num, coupondetail_num);
	}
	
	@Override
	public List<MemberDTO> selectGetCouponList(Map<String, Object> map) {
		return memberDAO.selectGetCouponList(map);
	}
	
	@Override
	public int selectGetCouponCount(Integer mem_num) {
		return memberDAO.selectGetCouponCount(mem_num);
	}
	
}