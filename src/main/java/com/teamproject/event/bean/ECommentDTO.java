package com.teamproject.event.bean;

import com.teamproject.util.DurationFromNow;

public class ECommentDTO {

	/* 이벤트 댓글 */
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
	//프로필 사진 파일명
	private String profile_filename;
	
	/* 이벤트 게시물 정보(EventDTO 게시물 정보 FK) */
	//이벤트 게시물 번호
	private int event_num;			//event 번호

	
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
	
	//날짜 표시 형식을 변경(예: 5초전)
	public void setComm_reg_date(String comm_reg_date) {
		this.comm_reg_date = DurationFromNow.getTimeDiffLabel(comm_reg_date);
	}
	
	public String getComm_mod_date() {
		return comm_mod_date;
	}
	
	//날짜 표시 형식을 변경(예: 5초전)
	public void setComm_mod_date(String comm_mod_date) {
		this.comm_mod_date = DurationFromNow.getTimeDiffLabel(comm_mod_date);
	}
	
	public String getComm_content() {
		return comm_content;
	}
	
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	
	public int getEvent_num() {
		return event_num;
	}
	
	public void setEvent_num(int event_num) {
		this.event_num = event_num;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
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
	
	public String getProfile_filename() {
		return profile_filename;
	}
	
	public void setProfile_filename(String profile_filename) {
		this.profile_filename = profile_filename;
	}
	
	@Override
	public String toString() {
		return "ECommentDTO [comm_num=" + comm_num + ", comm_reg_date=" + comm_reg_date + ", comm_mod_date="
				+ comm_mod_date + ", comm_content=" + comm_content + ", event_num=" + event_num + ", mem_num=" + mem_num
				+ ", nickname=" + nickname + ", profile_filename=" + profile_filename + "]";
	}

	
}