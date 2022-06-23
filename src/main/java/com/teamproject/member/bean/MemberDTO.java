package com.teamproject.member.bean;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {

	/* 회원 필수 정보 */
	//회원 번호
	private int mem_num;	
	@Pattern(regexp = "^[a-zA-Z0-9!@#$%^&*()?_~]{6,12}$")
	//회원 아이디 [정규표현식 사용]
	private String mem_id;
	//회원 등급
	private int mem_auth;
	
	/* 회원 상세 정보 */
	//이름
	@NotEmpty
	private String mem_name;
	//비밀번호 [정규표현식 사용]
	@Pattern(regexp = "^(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z!@#$%^&*]{8,16}$")
	private String passwd;
	//전화번호
	@NotEmpty
	private String phone;
	//이메일
	@Email
	@NotEmpty
	private String email;
	//우편번호
	@Size(min = 5, max = 5)
	private String zipcode;
	//주소1
	@NotEmpty
	private String address1; 
	//주소2 - 상세
	@NotEmpty
	private String address2;
	//프로필 사진
	private byte[] profile;
	//프로필 사진 파일명
	private String profile_filename;
	//가입일
	private Date reg_date;
	//포인트
	private int point;

	/* 회원 부가정보 */
	//닉네임
	@NotEmpty
	private String nickname;
	//스크랩 갯수
	private int scrapbook_count;
	//추천 갯수
	private int recommend_count;
	//집들이 게시물 등록 수
	private int house_board_count; 
	
	/* 회원 쿠폰정보 */
	//쿠폰 번호
	private int coupon_num;
	//쿠폰 상세
	private int coupondetail_num;
	//쿠폰명
	private String coupon_name; 
	//쿠폰내용
	private String coupon_content; 
	//쿠폰 갯수
	private int coupon_count;
	//쿠폰 할인가격
	private int discount_price; 

	/* 비밀번호 변경 데이터 */
	//비밀번호 변경 시, 입력한 현재 비밀번호를 저장할 용도로 사용
	@Pattern(regexp = "^[A-Za-z0-9]{4,12}$")
	private String now_passwd;

	
	/* 추가 메서드 */
	//비밀번호 일치 여부 체크
	public boolean isCheckedPassword(String userPasswd) {
		if(mem_auth > 0 && passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}

	
	//이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException {
		//MultipartFile -> byte[]
		setProfile(upload.getBytes());
		//파일 이름
		setProfile_filename(upload.getOriginalFilename());
	}

	
	//@Getter @Setter @ToString
	public int getCoupondetail_num() {
		return coupondetail_num;
	}

	public void setCoupondetail_num(int coupondetail_num) {
		this.coupondetail_num = coupondetail_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getMem_auth() {
		return mem_auth;
	}

	public void setMem_auth(int mem_auth) {
		this.mem_auth = mem_auth;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public byte[] getProfile() {
		return profile;
	}

	public void setProfile(byte[] profile) {
		this.profile = profile;
	}

	public String getProfile_filename() {
		return profile_filename;
	}

	public void setProfile_filename(String profile_filename) {
		this.profile_filename = profile_filename;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getCoupon_num() {
		return coupon_num;
	}

	public void setCoupon_num(int coupon_num) {
		this.coupon_num = coupon_num;
	}

	public String getCoupon_name() {
		return coupon_name;
	}

	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}

	public String getCoupon_content() {
		return coupon_content;
	}

	public void setCoupon_content(String coupon_content) {
		this.coupon_content = coupon_content;
	}

	public int getDiscount_price() {
		return discount_price;
	}

	public void setDiscount_price(int discount_price) {
		this.discount_price = discount_price;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getCoupon_count() {
		return coupon_count;
	}

	public void setCoupon_count(int coupon_count) {
		this.coupon_count = coupon_count;
	}

	public int getScrapbook_count() {
		return scrapbook_count;
	}

	public void setScrapbook_count(int scrapbook_count) {
		this.scrapbook_count = scrapbook_count;
	}

	public int getRecommend_count() {
		return recommend_count;
	}

	public void setRecommend_count(int recommend_count) {
		this.recommend_count = recommend_count;
	}

	public int getHouse_board_count() {
		return house_board_count;
	}

	public void setHouse_board_count(int house_board_count) {
		this.house_board_count = house_board_count;
	}

	public String getNow_passwd() {
		return now_passwd;
	}

	public void setNow_passwd(String now_passwd) {
		this.now_passwd = now_passwd;
	}

	@Override
	public String toString() {
		return "MemberDTO [mem_num=" + mem_num + ", mem_id=" + mem_id + ", mem_auth=" + mem_auth + ", mem_name="
				+ mem_name + ", passwd=" + passwd + ", phone=" + phone + ", email=" + email + ", zipcode=" + zipcode
				+ ", address1=" + address1 + ", address2=" + address2 + ", profile_filename=" + profile_filename
				+ ", reg_date=" + reg_date + ", point=" + point + ", coupon_num=" + coupon_num + ", coupondetail_num="
				+ coupondetail_num + ", coupon_name=" + coupon_name + ", coupon_content=" + coupon_content
				+ ", coupon_count=" + coupon_count + ", discount_price=" + discount_price + ", nickname=" + nickname
				+ ", scrapbook_count=" + scrapbook_count + ", recommend_count=" + recommend_count
				+ ", house_board_count=" + house_board_count + ", now_passwd=" + now_passwd + "]";
	}

}
