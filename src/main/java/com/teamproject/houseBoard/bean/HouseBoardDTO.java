package com.teamproject.houseBoard.bean;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.teamproject.util.DurationFromNow;

public class HouseBoardDTO {
	
	/* 집들이 게시물 정보 */
	//집들이 게시물 번호
	private int house_num;
	//집들이 게시물 제목
	private String house_title;
	//집들이 게시물 내용
	private String house_content;
	//집들이 게시물 등록일
	private String house_reg_date;
	//집들이 게시물 수정일
	private String house_mod_date;
	//집들이 게시물 조회수
	private int house_hits;
	//집들이 게시물 추천수
	private int house_recom;
	//집들이 게시물 스크랩수
	private int house_Scrap;
	//추천 중복 체크
	private int heartCheckNum;
	//스크랩 중복 체크
	private int scrapCheckNum;	
	//집들이 썸네일 이미지
	private byte[] house_thumbnail;
	//집들이 썸네일 파일명
	private String thumbnail_filename;
	//주거형태
	private String house_type;
	//공간
	private String house_space;
	//평수
	private String house_area;
	//스타일
	private String house_style;
	
	/* 회원 정보(MemberDTO 회원정보 FK) */
	//회원 번호
	private int mem_num;
	//회원 아이디
	private String mem_id;
	//회원 등급
	private int mem_auth;
	//닉네임
	private String nickname;
	//프로필 사진
	private byte[] profile;
	//프로필 사진 파일명
	private String profile_filename;
	
	/* 회원 정보(HCommentDTO, HMarkDTO FK) */
	//댓글 번호
	private int comm_num;
	//스크랩 번호
	private int scrap_num;
	
	
	/* 추가 메서드 */
	//이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException {
		//MultipartFile -> byte[]
		setHouse_thumbnail(upload.getBytes());
		//파일 이름
		setThumbnail_filename(upload.getOriginalFilename());
	}

	
	//@Getter @Setter @ToString
	public int getHouse_num() {
		return house_num;
	}

	public void setHouse_num(int house_num) {
		this.house_num = house_num;
	}

	public String getHouse_type() {
		return house_type;
	}

	public void setHouse_type(String house_type) {
		this.house_type = house_type;
	}

	public String getHouse_space() {
		return house_space;
	}

	public void setHouse_space(String house_space) {
		this.house_space = house_space;
	}

	public String getHouse_area() {
		return house_area;
	}

	public void setHouse_area(String house_area) {
		this.house_area = house_area;
	}

	public String getHouse_style() {
		return house_style;
	}

	public void setHouse_style(String house_style) {
		this.house_style = house_style;
	}

	public String getHouse_title() {
		return house_title;
	}

	public void setHouse_title(String house_title) {
		this.house_title = house_title;
	}

	public String getHouse_content() {
		return house_content;
	}

	public void setHouse_content(String house_content) {
		this.house_content = house_content;
	}

	public int getHouse_hits() {
		return house_hits;
	}

	public void setHouse_hits(int house_hits) {
		this.house_hits = house_hits;
	}

	public int getHouse_recom() {
		return house_recom;
	}

	public void setHouse_recom(int house_recom) {
		this.house_recom = house_recom;
	}
	
	public int getHouse_Scrap() {
		return house_Scrap;
	}

	public void setHouse_Scrap(int house_Scrap) {
		this.house_Scrap = house_Scrap;
	}

	public String getHouse_reg_date() {
		return house_reg_date;
	}
	
	//날짜 표기 형식을 변경(예: 5초 전)
	public void setHouse_reg_date(String house_reg_date) {
		this.house_reg_date = DurationFromNow.getTimeDiffLabel(house_reg_date);
	}

	public String getHouse_mod_date() {
		return house_mod_date;
	}
	
	//날짜 표기 형식을 변경(예: 5초 전)
	public void setHouse_mod_date(String house_mod_date) {
		this.house_mod_date = DurationFromNow.getTimeDiffLabel(house_mod_date);
	}

	public byte[] getHouse_thumbnail() {
		return house_thumbnail;
	}

	public void setHouse_thumbnail(byte[] house_thumbnail) {
		this.house_thumbnail = house_thumbnail;
	}

	public String getThumbnail_filename() {
		return thumbnail_filename;
	}

	public void setThumbnail_filename(String thumbnail_filename) {
		this.thumbnail_filename = thumbnail_filename;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getScrap_num() {
		return scrap_num;
	}

	public void setScrap_num(int scrap_num) {
		this.scrap_num = scrap_num;
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
	
	public int getComm_num() {
		return comm_num;
	}

	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	
	public int getHeartCheckNum() {
		return heartCheckNum;
	}

	public void setHeartCheckNum(int heartCheckNum) {
		this.heartCheckNum = heartCheckNum;
	}

	public int getScrapCheckNum() {
		return scrapCheckNum;
	}

	public void setScrapCheckNum(int scrapCheckNum) {
		this.scrapCheckNum = scrapCheckNum;
	}
	
	// *주의* - 프로퍼티 타입이 byte[]인 것은 항목에서 제외 (house_thumbnail, profile)
	@Override
	public String toString() {
		return "HouseBoardDTO [house_num=" + house_num + ", house_type=" + house_type + ", house_space=" + house_space
				+ ", house_area=" + house_area + ", house_style=" + house_style + ", house_title=" + house_title
				+ ", house_content=" + house_content + ", house_hits=" + house_hits + ", house_recom=" + house_recom
				+ ", house_Scrap=" + house_Scrap + ", house_reg_date=" + house_reg_date + ", house_mod_date="
				+ house_mod_date + ", thumbnail_filename=" + thumbnail_filename + ", heartCheckNum=" + heartCheckNum
				+ ", scrapCheckNum=" + scrapCheckNum + ", mem_num=" + mem_num + ", mem_id=" + mem_id + ", mem_auth="
				+ mem_auth + ", nickname=" + nickname + ", profile_filename=" + profile_filename + ", comm_num="
				+ comm_num + ", scrap_num=" + scrap_num + "]";
	}

}
