package com.teamproject.qna.bean;

import javax.validation.constraints.NotEmpty;

public class QnaDTO {
	
	/* QnA */
	//QnA 번호
	private int qna_num;
	//QnA 카테고리
	@NotEmpty
	private String qna_category;
	//QnA 문의내용
	@NotEmpty
	private String qna_content;
	//QnA 답변내용
	@NotEmpty
	private String qna_reply;
	
	//@Getter @Setter @ToString
	public int getQna_num() {
		return qna_num;
	}
	
	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
	}
	
	public String getQna_category() {
		return qna_category;
	}
	
	public void setQna_category(String qna_category) {
		this.qna_category = qna_category;
	}
	
	public String getQna_content() {
		return qna_content;
	}
	
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	
	public String getQna_reply() {
		return qna_reply;
	}
	
	public void setQna_reply(String qna_reply) {
		this.qna_reply = qna_reply;
	}
	
	@Override
	public String toString() {
		return "QnaDTO [qna_num=" + qna_num + ", qna_category=" + qna_category + ", qna_content=" + qna_content
				+ ", qna_reply=" + qna_reply + "]";
	}
	
}
