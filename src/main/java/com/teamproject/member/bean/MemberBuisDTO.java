package com.teamproject.member.bean;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class MemberBuisDTO {
	
	/* 회원 정보(MemberDTO 회원정보 FK) */
	//회원 번호
	private int mem_num;
	//회원 아이디
	private String mem_id; 
	//회원 등급
	private int mem_auth; 

	/* 판매자 정보 */
	//판매자회원 번호
	private int buis_count; 
	@NotEmpty
	//회사번호[사업자번호]
	private String buis_num; 
	//대표자명
	@NotEmpty
	private String ceo_name; 
	//회사명
	@NotEmpty
	private String buis_name; 
	//개업일자
	@NotEmpty
	private String opening_date;
	//회사 종목
	@NotEmpty
	private String buis_item;
	//회사 우편번호
	@Size(min = 5, max = 5)
	private String buis_zipcode; 
	//회사주소1
	@NotEmpty
	private String buis_address1;
	//회사주소2 - 상세
	@NotEmpty
	private String buis_address2;
	//회사지원 상태
	private String application_state; 

	
	//@Getter @Setter @ToString
	public int getMem_num() {
		return mem_num;
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

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getBuis_count() {
		return buis_count;
	}

	public void setBuis_count(int buis_count) {
		this.buis_count = buis_count;
	}

	public String getBuis_num() {
		return buis_num;
	}

	public void setBuis_num(String buis_num) {
		this.buis_num = buis_num;
	}

	public String getCeo_name() {
		return ceo_name;
	}

	public void setCeo_name(String ceo_name) {
		this.ceo_name = ceo_name;
	}

	public String getBuis_name() {
		return buis_name;
	}

	public void setBuis_name(String buis_name) {
		this.buis_name = buis_name;
	}

	public String getOpening_date() {
		return opening_date;
	}

	public void setOpening_date(String opening_date) {
		this.opening_date = opening_date;
	}

	public String getBuis_item() {
		return buis_item;
	}

	public void setBuis_item(String buis_item) {
		this.buis_item = buis_item;
	}

	public String getBuis_zipcode() {
		return buis_zipcode;
	}

	public void setBuis_zipcode(String buis_zipcode) {
		this.buis_zipcode = buis_zipcode;
	}

	public String getBuis_address1() {
		return buis_address1;
	}

	public void setBuis_address1(String buis_address1) {
		this.buis_address1 = buis_address1;
	}

	public String getBuis_address2() {
		return buis_address2;
	}

	public void setBuis_address2(String buis_address2) {
		this.buis_address2 = buis_address2;
	}

	public String getApplication_state() {
		return application_state;
	}

	public void setApplication_state(String application_state) {
		this.application_state = application_state;
	}

	@Override
	public String toString() {
		return "MemberBuisDTO [mem_num=" + mem_num + ", mem_id=" + mem_id + ", mem_auth=" + mem_auth + ", buis_count="
				+ buis_count + ", buis_num=" + buis_num + ", ceo_name=" + ceo_name + ", buis_name=" + buis_name
				+ ", opening_date=" + opening_date + ", buis_item=" + buis_item + ", buis_zipcode=" + buis_zipcode
				+ ", buis_address1=" + buis_address1 + ", buis_address2=" + buis_address2 + ", application_state="
				+ application_state + "]";
	}
}
