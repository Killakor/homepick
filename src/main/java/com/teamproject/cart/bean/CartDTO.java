package com.teamproject.cart.bean;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class CartDTO {
	
	/* 장바구니 정보 */
	//장바구니 번호
	private int cart_num;
	//장바구니 수량
	private int cart_quan;
	//장바구니 결제 금액
	private int money;
	
	/* 회원 정보(MemberDTO 정보 FK) */
	//회원 번호
	private int mem_num;
	//회원 이름
	private String mem_name;
	
	/* 회원 정보(StoreDTO 회원정보 FK) */
	//상품 번호
	private int prod_num;
	//상품 이름
	private String prod_name;
	//상품 가격
	private int prod_price;
	//상품 썸네일 이미지
	private byte[] thumbnail_img;
	//상품 썸네일 이미지
	private String thumbnail_filename;

	
	/* 추가 메서드 */
	//이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException {
		//MultipartFile -> byte[]
		setThumbnail_img(upload.getBytes());
		//파일 이름
		setThumbnail_filename(upload.getOriginalFilename());
	}
	
	
	//@Getter @Setter @ToString
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
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
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getCart_quan() {
		return cart_quan;
	}
	public void setCart_quan(int cart_quan) {
		this.cart_quan = cart_quan;
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
	
	@Override
	public String toString() {
		return "CartDTO [cart_num=" + cart_num + ", prod_num=" + prod_num + ", mem_num=" + mem_num + ", cart_quan="
				+ cart_quan + ", mem_name=" + mem_name + ", prod_name=" + prod_name + ", prod_price=" + prod_price
				+ ", money=" + money + ", thumbnail_filename=" + thumbnail_filename + "]";
	}
	
}
