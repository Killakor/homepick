package com.teamproject.order.bean;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

public class OrderDTO {
	
	/* 주문 정보 */
	//주문 번호
	private int order_num;
	//주문 상세 번호
	private int order_detail_num;
	//주문 일자
	private Date order_date;
	//주문 우편번호
	private String order_zipcode;
	//주문 주소1
	private String order_address1;
	//주문 주소2 - 상세
	private String order_address2;
	//주문자 이름
	private String receiver_name;
	//주문자 전화번호
	@NotEmpty
	private String receiver_phone;
	// 주문자 이메일
	private String receiver_email;
	
	/* 결제 정보 */
	//결재 번호
	private int pay_num;
	//결제 수량
	private int pay_quan;
	//결제 금액
	private int pay_price;
	//결제 쿠폰
	private int coupon;
	//결제 포인트
	private int point;			
	
	/* 회원 상세 정보 (MemberDTO, MemberBuis 회원정보 FK) */
	//회원 번호
	private int mem_num;
	//이메일
	private String email;
	//전화번호
	private String phone;
	//우편번호
	private int zipcode;
	//주소1
	private String address1;
	//주소2 - 상세
	private String address2;
	//회사명
	private String buis_name;
	
	/* 상품 정보 (StoreDTO 상품정보 FK) */
	//상품 번호
	private int prod_num;
	//상품 가격
	private int prod_price;
	//상품 이름
	private String prod_name;
	//배송료
	private int delive_price;
	//배송 유형
	private String delive_type;
	//상품 옵션
	private String prod_opt;		
	
	
	//@Getter @Setter @ToString
	public String getProd_opt() {
		return prod_opt;
	}
	public void setProd_opt(String prod_opt) {
		this.prod_opt = prod_opt;
	}
	public int getOrder_num() {
		return order_num;
	}
	
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	
	public Date getOrder_date() {
		return order_date;
	}
	
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	
	public String getOrder_zipcode() {
		return order_zipcode;
	}
	
	public void setOrder_zipcode(String order_zipcode) {
		this.order_zipcode = order_zipcode;
	}
	
	public String getOrder_address1() {
		return order_address1;
	}
	
	public void setOrder_address1(String order_address1) {
		this.order_address1 = order_address1;
	}
	
	public String getOrder_address2() {
		return order_address2;
	}
	
	public void setOrder_address2(String order_address2) {
		this.order_address2 = order_address2;
	}
	
	public String getReceiver_name() {
		return receiver_name;
	}
	
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	
	public String getReceiver_phone() {
		return receiver_phone;
	}
	
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	
	public String getReceiver_email() {
		return receiver_email;
	}
	
	public void setReceiver_email(String receiver_email) {
		this.receiver_email = receiver_email;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	
	public int getOrder_detail_num() {
		return order_detail_num;
	}
	
	public void setOrder_detail_num(int order_detail_num) {
		this.order_detail_num = order_detail_num;
	}
	
	public int getProd_num() {
		return prod_num;
	}
	
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	
	public int getPay_num() {
		return pay_num;
	}
	
	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}
	
	public int getPay_quan() {
		return pay_quan;
	}
	
	public void setPay_quan(int pay_quan) {
		this.pay_quan = pay_quan;
	}
	
	public int getPay_price() {
		return pay_price;
	}
	
	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}
	
	public int getCoupon() {
		return coupon;
	}
	
	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}
	
	public int getPoint() {
		return point;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public String getBuis_name() {
		return buis_name;
	}
	
	public void setBuis_name(String buis_name) {
		this.buis_name = buis_name;
	}
	
	public int getProd_price() {
		return prod_price;
	}
	
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	
	public String getProd_name() {
		return prod_name;
	}
	
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
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
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public int getZipcode() {
		return zipcode;
	}
	
	public void setZipcode(int zipcode) {
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
	
	@Override
	public String toString() {
		return "OrderDTO [order_num=" + order_num + ", order_date=" + order_date + ", order_zipcode=" + order_zipcode
				+ ", order_address1=" + order_address1 + ", order_address2=" + order_address2 + ", receiver_name="
				+ receiver_name + ", receiver_phone=" + receiver_phone + ", receiver_email=" + receiver_email
				+ ", mem_num=" + mem_num + ", order_detail_num=" + order_detail_num + ", prod_num=" + prod_num
				+ ", pay_num=" + pay_num + ", pay_quan=" + pay_quan + ", pay_price=" + pay_price + ", coupon=" + coupon
				+ ", point=" + point + ", buis_name=" + buis_name + ", prod_price=" + prod_price + ", prod_name="
				+ prod_name + ", delive_price=" + delive_price + ", delive_type=" + delive_type + ", email=" + email
				+ ", phone=" + phone + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2
				+ ", prod_opt=" + prod_opt + "]";
	}
}
