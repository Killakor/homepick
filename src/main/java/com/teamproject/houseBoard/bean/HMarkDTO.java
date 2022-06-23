package com.teamproject.houseBoard.bean;

public class HMarkDTO {
	
	/* 추천 & 스크랩 */
	//추천 갯수
	private int house_recom;
	//스크랩 번호
	private int scrap_num;
	
	/* 회원 정보(MemberDTO 회원정보 FK) */
	//회원 번호
	private int mem_num;
	
	/* 집들이 게시물 정보(HouseBoardDTO 게시물 정보 FK) */
	//집들이게시판 글번호
	private int house_num;

	
	//@Getter @Setter @ToString
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
	
	public int getHouse_recom() {
		return house_recom;
	}
	
	public void setHouse_recom(int house_recom) {
		this.house_recom = house_recom;
	}
	
	public int getScrap_num() {
		return scrap_num;
	}
	
	public void setScrap_num(int scrap_num) {
		this.scrap_num = scrap_num;
	}

	@Override
	public String toString() {
		return "HMarkDTO [mem_num=" + mem_num + ", house_num=" + house_num + ", house_recom=" + house_recom
				+ ", scrap_num=" + scrap_num + "]";
	}
	
}
