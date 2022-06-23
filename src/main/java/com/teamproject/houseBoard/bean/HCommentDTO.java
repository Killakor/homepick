package com.teamproject.houseBoard.bean;

import com.teamproject.util.DurationFromNow;

public class HCommentDTO {
	
	/* 집들이 댓글 */
	//댓글 번호
	private int comm_num; 
	//댓글 등록일
	private String comm_reg_date;
	//댓글 수정일
	private String comm_mod_date;
	//댓글 내용
	private String comm_content;
	
	/* 회원 정보(MemberDTO 회원정보 FK) */
	//회원 번호
	private int mem_num;
	//닉네임
	private String nickname;
	//프로필 사진
	private byte[] profile;
	
	/* 집들이 게시물 정보(HouseBoardDTO 게시물 정보 FK) */
	//집들이 게시물 번호
	private int house_num;

	
	//@Getter @Setter @ToString
	public int getComm_num() {
		return comm_num;
	}
	
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	
	public String getComm_reg_date() {
		return comm_reg_date;
	}
	
	//날짜 표기 형식을 변경(예: 5초 전)
	public void setComm_reg_date(String comm_reg_date) {
		this.comm_reg_date = DurationFromNow.getTimeDiffLabel(comm_reg_date);
	}
	
	public String getComm_mod_date() {
		return comm_mod_date;
	}
	
	//날짜 표기 형식을 변경(예: 5초 전)
	public void setComm_mod_date(String comm_mod_date) {
		this.comm_mod_date = DurationFromNow.getTimeDiffLabel(comm_mod_date);
	}
	
	public String getComm_content() {
		return comm_content;
	}
	
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public int getHouse_num() {
		return house_num;
	}
	
	public void setHouse_num(int house_num) {
		this.house_num = house_num;
	}
	
	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public byte[] getProfile() {
		return profile;
	}

	public void setProfile(byte[] profile) {
		this.profile = profile;
	}

	@Override
	public String toString() {
		return "HCommentsVO [comm_num=" + comm_num + ", comm_reg_date=" + comm_reg_date + ", comm_mod_date="
				+ comm_mod_date + ", comm_content=" + comm_content + ", mem_num=" + mem_num + ", house_num=" + house_num
				+ ", nickname=" + nickname + "]";
	}
	
}
