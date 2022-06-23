package com.teamproject.serviceBoard.bean;

import java.io.IOException;
import java.util.Arrays;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

	/* 고객센터 문의 */
	public class ServiceBoardDTO {
	//문의 번호
	private int service_num;	
	//문의 제목
	@NotEmpty
	private String service_title;
	//문의 닉네임
	@NotEmpty
	private String service_nickname;	
	@NotEmpty
	//문의 내용
	private String service_content;
	//답변 내용
	private String service_reply;
	//이메일
	@Email
	@NotEmpty
	private String service_email;
	//문의 키워드
	@NotEmpty
	private String service_keyword;
	//문의 이미지 파일명
	private String service_filename;
	//문의 이미지 파일
	private byte[] service_file;
	
	/* 회원 정보(MemberDTO 회원정보 FK) */
	//회원 번호
	private int mem_num;
	
	
	/* 추가 메서드 */
	//이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException {
		//MultipartFile -> byte[]
		setService_file(upload.getBytes());
		//파일 이름
		setService_filename(upload.getOriginalFilename());
	
	}
	
	//@Getter @Setter @ToString
	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getService_num() {
		return service_num;
	}

	public void setService_num(int service_num) {
		this.service_num = service_num;
	}

	public String getService_title() {
		return service_title;
	}

	public void setService_title(String service_title) {
		this.service_title = service_title;
	}

	public String getService_nickname() {
		return service_nickname;
	}

	public void setService_nickname(String service_nickname) {
		this.service_nickname = service_nickname;
	}

	public String getService_content() {
		return service_content;
	}

	public void setService_content(String service_content) {
		this.service_content = service_content;
	}

	public String getService_email() {
		return service_email;
	}

	public void setService_email(String service_email) {
		this.service_email = service_email;
	}

	public String getService_keyword() {
		return service_keyword;
	}

	public void setService_keyword(String service_keyword) {
		this.service_keyword = service_keyword;
	}

	public String getService_filename() {
		return service_filename;
	}

	public void setService_filename(String service_filename) {
		this.service_filename = service_filename;
	}

	public byte[] getService_file() {
		return service_file;
	}

	public void setService_file(byte[] service_file) {
		this.service_file = service_file;
	}

	
	public String getService_reply() {
		return service_reply;
	}

	public void setService_reply(String service_reply) {
		this.service_reply = service_reply;
	}

	// *주의* - 프로퍼티 타입이 byte[]인 것은 항목에서 제외  
	@Override
	public String toString() {
		return "ServiceBoardDTO [service_num=" + service_num + ", service_title=" + service_title + ", service_nickname="
				+ service_nickname + ", service_content=" + service_content + ", service_reply=" + service_reply
				+ ", service_email=" + service_email + ", service_keyword=" + service_keyword + ", service_filename="
				+ service_filename + ", getService_num()=" + getService_num() + ", getService_title()="
				+ getService_title() + ", getService_nickname()=" + getService_nickname() + ", getService_content()="
				+ getService_content() + ", getService_email()=" + getService_email() + ", getService_keyword()="
				+ getService_keyword() + ", getService_filename()=" + getService_filename() + ", getService_file()="
				+ Arrays.toString(getService_file()) + ", getService_reply()=" + getService_reply() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
}
	