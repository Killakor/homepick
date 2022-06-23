package com.teamproject.notice.bean;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class NoticeDTO {
	
	/* 공지사항 */
	//공지사항 번호
	private int notice_num;
	//공지사항 제목
	@NotEmpty
	private String notice_title;
	//공지사항 내용
	@NotEmpty
	private String notice_content;
	//공지사항 등록일
	private Date notice_reg_date;
	//공지사항 조회수
	private int notice_hits;
	
	/* 회원 상세 정보 (MemberDTO FK) */
	//회원 번호
	private int mem_num;
	
	
	//@Getter @Setter @ToString
	public int getNotice_num() {
		return notice_num;
	}
	
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	
	public String getNotice_title() {
		return notice_title;
	}
	
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	
	public String getNotice_content() {
		return notice_content;
	}
	
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	
	public Date getNotice_reg_date() {
		return notice_reg_date;
	}
	
	public void setNotice_reg_date(Date notice_reg_date) {
		this.notice_reg_date = notice_reg_date;
	}
	
	public int getNotice_hits() {
		return notice_hits;
	}
	
	public void setNotice_hits(int notice_hits) {
		this.notice_hits = notice_hits;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	@Override
	public String toString() {
		return "NoticeDTO [notice_num=" + notice_num + ", notice_title=" + notice_title + ", notice_content="
				+ notice_content + ", notice_reg_date=" + notice_reg_date + ", notice_hits=" + notice_hits
				+ ", mem_num=" + mem_num + "]";
	}
	
}
