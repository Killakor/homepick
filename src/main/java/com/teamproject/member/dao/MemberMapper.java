package com.teamproject.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.teamproject.houseBoard.bean.HouseBoardDTO;
import com.teamproject.member.bean.MemberBuisDTO;
import com.teamproject.member.bean.MemberDTO;
import com.teamproject.store.bean.StoreDTO;

@Repository
public interface MemberMapper {

	/* 회원 정보 */
	//회원 번호 [시퀀스 자동생성]
	@Select("SELECT nextval('member_seq') as member_seq from dual")
	public int seleceMem_num(); // 

	//회원 가입 - 회원 필수 정보
	@Insert("INSERT INTO member (mem_num, mem_id) VALUES(#{mem_num}, #{mem_id})")
	public void insertMember(MemberDTO member);

	//회원 가입 - 회원 상세 정보
	@Insert("INSERT INTO mem_detail (mem_num, mem_name, passwd, phone, email, zipcode, address1, address2, nickname, reg_date) VALUES (#{mem_num}, #{mem_name}, #{passwd}, #{phone}, #{email}, #{zipcode}, #{address1}, #{address2}, #{nickname}, now())")
	public void insertMember_datail(MemberDTO member);

	//회원 아이디 중복 검사
	@Select("SELECT m.mem_num, m.mem_id, m.mem_auth, d.passwd, d.profile, d.email, d.nickname, d.phone FROM member m LEFT OUTER JOIN mem_detail d ON m.mem_num=d.mem_num WHERE m.mem_id=#{mem_id}")
	public MemberDTO selectCheckMember(String mem_id);

	//회원 아이디 찾기
	@Select("SELECT m.mem_id FROM member m JOIN mem_detail d ON m.mem_num=d.mem_num WHERE d.mem_name = #{mem_name} AND d.phone = #{phone}")
	public List<MemberDTO> SelectIdSearch(Map<String, Object> map); 

	
	
	/* 마이 페이지 */
	//회원 정보 조회
	@Select("SELECT * FROM member m JOIN mem_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberDTO selectMember(Integer mem_num); 

	//회원이 추천한 게시글 - selectMember() 메서드 호출 시, 데이터 전송
	@Select("SELECT count(*) FROM recommend WHERE mem_num=#{mem_num}")
	public int myRecommCount(Integer mem_num); // 
	
	//회원의 추천 게시글 번호 리스트
	public List<HouseBoardDTO> myRecommBoardNum(Map<String, Object> map);
	
	//회원이 추천한 게시글의 갯수
	public int myRecommBoardCount(Map<String, Object> map);

	//회원이 스크랩한 게시글의 갯수 - selectMember() 메서드 호출 시, 데이터 전송
	@Select("SELECT count(*) FROM scrapbook WHERE mem_num=#{mem_num}")
	public int myScrapBookCount(Integer mem_num);
	
	//회원이 스크랩한 게시글의 번호 리스트
	public List<HouseBoardDTO> myScrapBooksNum(Map<String, Object> map);
	
	//회원이 스크랩한 게시글의 갯수
	public int myScrapBookBoardCounts(Map<String, Object> map);

	//회원이 추천 및 스크랩한 게시글 리스트 
	public HouseBoardDTO myRecommScrapBoardList(Map<String, Object> map);
	
	//회원이 작성한 게시글의 갯수 - selectMember() 메서드 호출 시, 데이터 전송
	@Select("SELECT count(*) FROM house_board WHERE mem_num = #{mem_num}")
	public int selectGetHouseBoardCount(Integer mem_num);

	//프로필 사진 수정
	@Update("UPDATE mem_detail SET profile=#{profile},profile_filename=#{profile_filename} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberDTO member);

	//회원 정보 수정
	@Update("UPDATE mem_detail SET mem_name = #{mem_name}, nickname = #{nickname}, phone = #{phone}, email = #{email}, zipcode = #{zipcode}, address1 = #{address1}, address2 = #{address2} WHERE mem_num = #{mem_num}")
	public void updateMember(MemberDTO member);

	//회원 비밀번호 변경
	@Update("UPDATE mem_detail SET passwd = #{passwd} WHERE mem_num=#{mem_num}")
	public void updateMemberPasswd(MemberDTO member);

	//회원 탈퇴 (회원 등급 정지 회원(0)으로 변경)
	@Update("UPDATE member SET mem_auth=0 WHERE mem_num = #{mem_num}")
	public void deleteMember(Integer mem_num);

	//회원 탈퇴 (회원 정보 삭제)
	@Delete("DELETE FROM mem_detail WHERE mem_num = #{mem_num}")
	public void deleteMemberDetail(Integer mem_num);

	//회원이 보유한 쿠폰 갯수
	public List<MemberDTO> selectGetCouponList(Map<String, Object> map);
	
	
	
	/* 판매자 */
	//판매자 신청 등록 (판매자 회원 상세정보 추가)
	@Insert("INSERT INTO buis_detail (buis_count, mem_num, buis_num, ceo_name, buis_name, buis_item, opening_date, buis_zipcode, buis_address1, buis_address2) VALUES ((select *from (select max(buis_count)+1 from buis_detail) next), #{mem_num}, #{buis_num}, #{ceo_name}, #{buis_name}, #{buis_item}, #{opening_date}, #{buis_zipcode}, #{buis_address1}, #{buis_address2})")
	public void insertSeller(MemberBuisDTO memberBuisDTO);

	//판매자 신청 수
	@Select("select count(*) from buis_detail where mem_num = #{mem_num}")
	public int selectCountSeller(Integer mem_num);

	//판매자가 등록한 상품 갯수
	@Select("SELECT COUNT(*) FROM product WHERE mem_num = #{mem_num}")
	public int myProductCount(Integer mem_num);
	
	//판매자가 등록한 상품 리스트
	public List<StoreDTO> myProductList(Map<String, Object> map);

	//회원이 보유한 쿠폰 갯수
	@Select("SELECT count(*) FROM coupon WHERE mem_num=#{mem_num}")
	public int selectGetCouponCount(Integer mem_num);
	
	
	
	/* 관리자 */
	//전체 회원 리스트
	public List<MemberDTO> selectMemberList(Map<String, Object> map);
	
	//전체 회원 수
	public int selectMemberCount(Map<String, Object> map);

	//회원 등급 변경 - 회원 정지
	@Update("UPDATE member SET mem_auth = 1 WHERE mem_num=#{mem_num}")
	public void updateMemberStop(Integer mem_num);

	//회원 등급 변경 - 일반 회원으로 변경
	@Update("UPDATE member SET mem_auth = 2 WHERE mem_num=#{mem_num}")
	public void updateMemberStopCancel(Integer mem_num);

	//회원 등급 변경 - 판매자로 변경
	@Update("UPDATE member SET mem_auth = 3 WHERE mem_num=#{mem_num}")
	public void updateMemberSellerAuth(Integer mem_num);
	
	//회원 등급 변경 - 관리자로 변경
	@Update("UPDATE member SET mem_auth = 4 WHERE mem_num=#{mem_num}")
	public void updateMemberAdminAuth(Integer mem_num);
	
	//회원 비밀번호 초기화
	@Update("UPDATE mem_detail SET passwd = '1234' WHERE mem_num=#{mem_num}")
	public void updateMemberPasswdReset(Integer mem_num);
	
	//판매자 신청 리스트
	public List<MemberBuisDTO> selectMemberBuisList(Map<String, Object> map);
	
	//판매자 신청 수
	public int selectMemberBuisCount(Map<String, Object> map);

	//판매자 신청 등록 (회사지원 상태 변경 null:판매자x / 2:판매자)
	@Update("UPDATE buis_detail SET application_state = 2 WHERE mem_num=#{mem_num}")
	public void updateSellerMember(Integer mem_num);

	//판매자 등록 신청 취소
	@Delete("DELETE FROM buis_detail WHERE mem_num=#{mem_num}")
	public void deleteSellerMember(Integer mem_num);

	//쿠폰 등록
	@Insert("INSERT INTO coupon_detail (coupondetail_num, coupon_name, coupon_content, discount_price) \r\n"
			+ "select case count(*) when 0 then 1 else max(coupondetail_num) + 1 end, #{coupon_name}, #{coupon_content}, #{discount_price} from coupon_detail")
	public void insertCoupon(MemberDTO memberDTO);

	//쿠폰 갯수
	@Select("SELECT COUNT(*) FROM coupon_detail")
	public int selectCouponAllCount();
	
	//쿠폰 리스트
	public List<MemberDTO> selectCouponAllList(Map<String, Object> map);

	//쿠폰 상세정보
	@Select("SELECT * FROM coupon_detail WHERE coupondetail_num=#{coupondetail_num}")
	public MemberDTO couponSelect(Integer coupondetail_num);

	//쿠폰 수정
	@Update("UPDATE coupon_detail SET coupon_name = #{coupon_name}, discount_price=#{discount_price}, coupon_content=#{coupon_content}")
	public void updateCoupon(MemberDTO memberDTO);
	
	//쿠폰 삭제
	@Delete("DELETE FROM coupon_detail WHERE coupondetail_num=#{coupondetail_num}")
	public void deleteCoupon(Integer coupondetail_num);

	//회원별 쿠폰 배정
	@Insert("INSERT INTO coupon (coupon_num, mem_num, coupondetail_num) \r\n"
			+ "select case count(*) when 0 then 1 else max(coupon_num) + 1 end, #{mem_num}, #{coupondetail_num} from coupon")
	public void insertMemberCouponReg(@Param("mem_num") Integer mem_num, @Param("coupondetail_num") Integer coupondetail_num);

}