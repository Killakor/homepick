package com.teamproject.store.bean;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

public class StoreDTO {
	
	/* 상품 게시물 정보 */
	//상품 번호
	private int prod_num;
	//상품명
	@NotEmpty
	private String prod_name;
	//상품 가격
	@Min(1)
	private	int prod_price;
	//배송비
	private int delive_price;
	//배송 유형
	@NotEmpty
	private String delive_type;
	//상품 선택
	private String selec_product;
	//상품 옵션1
	private String prod_option1;
	//상품 내용
	@NotEmpty
	private String prod_content;
	//상품 이미지
	private byte[] prod_img;
	//상품 파일명
	private String prod_filename;
	//상품 썸네일 이미지
	private byte[] thumbnail_img;
	//상품 썸네일 파일명
	private String thumbnail_filename;
	//수량
	@Min(1)
	private int prod_quan;
	//추가 상품명
	private String add_product;
	//상품 등록일
	private Date prod_reg_date;
	//상품 키워드
	private String prod_keyword;
	//회원 번호
	private int mem_num;				
	//카테고리
	@NotEmpty
	private String prod_cate;
	//상품 옵션2~옵션10 [선택사항]
	private String prod_option2;
	private String prod_option3;
	private String prod_option4;
	private String prod_option5;
	private String prod_option6;
	private String prod_option7;
	private String prod_option8;
	private String prod_option9;
	private String prod_option10;
	//주문 수량
	private int quan;
	//선택한 옵션
	private String commit_option;		
	
	/* 회원 정보(MemberDTO, MemberBuisDTO 정보 FK) */
	//회원 등급
	private int mem_auth;
	//회사명
	private String buis_name;

	
	/* 추가 메서드 */
	//썸네일 BLOB 처리
	public void setUpload1(MultipartFile upload1)throws IOException {
		//MultipartFile -> byte[]
		setThumbnail_img(upload1.getBytes());
		//파일 이름
		setThumbnail_filename(upload1.getOriginalFilename());
	}
	
	//상품 이미지 BLOB 처리
	public void setUpload2(MultipartFile upload2)throws IOException {
		//MultipartFile -> byte[]
		setProd_img(upload2.getBytes());
		//파일 이름
		setProd_filename(upload2.getOriginalFilename());
	}
	
	//@Getter @Setter @ToString
	public int getMem_auth() {
		return mem_auth;
	}
	
	public void setMem_auth(int mem_auth) {
		this.mem_auth = mem_auth;
	}
	
	public String getCommit_option() {
		return commit_option;
	}
	
	public void setCommit_option(String commit_option) {
		this.commit_option = commit_option;
	}
	
	public String getBuis_name() {
		return buis_name;
	}
	
	public void setBuis_name(String buis_name) {
		this.buis_name = buis_name;
	}
	
	public int getQuan() {
		return quan;
	}
	public void setQuan(int quan) {
		this.quan = quan;
	}
	
	public int getProd_num() {
		return prod_num;
	}
	
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	
	public String getProd_name() {
		return prod_name;
	}
	
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	
	public int getProd_price() {
		return prod_price;
	}
	
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	
	public int getDelive_price() {
		return delive_price;
	}
	
	public void setDelive_price(int delive_price) {
		this.delive_price = delive_price;
	}
	
	public String getDelive_type() {
		return delive_type;
	}
	
	public void setDelive_type(String delive_type) {
		this.delive_type = delive_type;
	}
	
	public String getSelec_product() {
		return selec_product;
	}
	
	public void setSelec_product(String selec_product) {
		this.selec_product = selec_product;
	}
	
	public String getProd_option1() {
		return prod_option1;
	}
	
	public void setProd_option1(String prod_option1) {
		this.prod_option1 = prod_option1;
	}
	
	public String getProd_content() {
		return prod_content;
	}
	
	public void setProd_content(String prod_content) {
		this.prod_content = prod_content;
	}
	
	public byte[] getProd_img() {
		return prod_img;
	}
	
	public void setProd_img(byte[] prod_img) {
		this.prod_img = prod_img;
	}
	
	public String getProd_filename() {
		return prod_filename;
	}
	
	public void setProd_filename(String prod_filename) {
		this.prod_filename = prod_filename;
	}
	
	public byte[] getThumbnail_img() {
		return thumbnail_img;
	}
	
	public void setThumbnail_img(byte[] thumbnail_img) {
		this.thumbnail_img = thumbnail_img;
	}
	
	public String getThumbnail_filename() {
		return thumbnail_filename;
	}
	
	public void setThumbnail_filename(String thumbnail_filename) {
		this.thumbnail_filename = thumbnail_filename;
	}
	
	public int getProd_quan() {
		return prod_quan;
	}
	
	public void setProd_quan(int prod_quan) {
		this.prod_quan = prod_quan;
	}
	
	public String getAdd_product() {
		return add_product;
	}
	
	public void setAdd_product(String add_product) {
		this.add_product = add_product;
	}
	
	public Date getProd_reg_date() {
		return prod_reg_date;
	}
	
	public void setProd_reg_date(Date prod_reg_date) {
		this.prod_reg_date = prod_reg_date;
	}
	
	public String getProd_keyword() {
		return prod_keyword;
	}
	
	public void setProd_keyword(String prod_keyword) {
		this.prod_keyword = prod_keyword;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public String getProd_cate() {
		return prod_cate;
	}
	
	public void setProd_cate(String prod_cate) {
		this.prod_cate = prod_cate;
	}
	
	public String getProd_option2() {
		return prod_option2;
	}
	
	public void setProd_option2(String prod_option2) {
		this.prod_option2 = prod_option2;
	}
	
	public String getProd_option3() {
		return prod_option3;
	}
	
	public void setProd_option3(String prod_option3) {
		this.prod_option3 = prod_option3;
	}
	
	public String getProd_option4() {
		return prod_option4;
	}
	
	public void setProd_option4(String prod_option4) {
		this.prod_option4 = prod_option4;
	}
	
	public String getProd_option5() {
		return prod_option5;
	}
	
	public void setProd_option5(String prod_option5) {
		this.prod_option5 = prod_option5;
	}
	
	public String getProd_option6() {
		return prod_option6;
	}
	
	public void setProd_option6(String prod_option6) {
		this.prod_option6 = prod_option6;
	}
	
	public String getProd_option7() {
		return prod_option7;
	}
	
	public void setProd_option7(String prod_option7) {
		this.prod_option7 = prod_option7;
	}
	
	public String getProd_option8() {
		return prod_option8;
	}
	
	public void setProd_option8(String prod_option8) {
		this.prod_option8 = prod_option8;
	}
	
	public String getProd_option9() {
		return prod_option9;
	}
	
	public void setProd_option9(String prod_option9) {
		this.prod_option9 = prod_option9;
	}
	
	public String getProd_option10() {
		return prod_option10;
	}
	
	public void setProd_option10(String prod_option10) {
		this.prod_option10 = prod_option10;
	}
	
	@Override
	public String toString() {
		return "StoreDTO [prod_num=" + prod_num + ", prod_name=" + prod_name + ", prod_price=" + prod_price
				+ ", delive_price=" + delive_price + ", delive_type=" + delive_type + ", selec_product=" + selec_product
				+ ", prod_option1=" + prod_option1 + ", prod_content=" + prod_content + ", prod_filename="
				+ prod_filename + ", thumbnail_filename=" + thumbnail_filename + ", prod_quan=" + prod_quan
				+ ", add_product=" + add_product + ", prod_reg_date=" + prod_reg_date + ", prod_keyword=" + prod_keyword
				+ ", mem_num=" + mem_num + ", prod_cate=" + prod_cate + ", prod_option2=" + prod_option2
				+ ", prod_option3=" + prod_option3 + ", prod_option4=" + prod_option4 + ", prod_option5=" + prod_option5
				+ ", prod_option6=" + prod_option6 + ", prod_option7=" + prod_option7 + ", prod_option8=" + prod_option8
				+ ", prod_option9=" + prod_option9 + ", prod_option10=" + prod_option10 + ", quan=" + quan
				+ ", buis_name=" + buis_name + ", commit_option=" + commit_option + ", mem_auth=" + mem_auth + "]";
	}
}
