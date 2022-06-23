package com.teamproject.util;

public class PagingUtil {
	private int startCount;	 //한 페이지에서 보여줄 게시글의 시작 번호
	private int endCount;	 //한 페이지에서 보여줄 게시글의 끝 번호
	private StringBuffer pagingHtml;	// 페이지 표시 문자열
  
	/**
	 * currentPage : 현재페이지
	 * totalCount : 전체 게시물 수
	 * rowCount : 한 페이지의 게시물의 수
	 * pageCount : 한 화면에 보여줄 페이지 수
	 * pageUrl : 호출 페이지 url
	 * addKey : 부가적인 key 없을 때는 null 처리 [&num=? 형식으로 전달]
	 * */
	public PagingUtil(int currentPage, int totalCount, int rowCount, int pageCount, String pageUrl) {
		this(null,null,currentPage,totalCount,rowCount,pageCount,pageUrl,null);
	}
	public PagingUtil(int currentPage, int totalCount, int rowCount, int pageCount, String pageUrl, String addKey) {
		this(null,null,currentPage,totalCount,rowCount,pageCount,pageUrl,addKey);
	}
	public PagingUtil(String keyfield, String keyword, int currentPage, int totalCount, int rowCount, int pageCount,String pageUrl) {
		this(keyfield,keyword,currentPage,totalCount,rowCount,pageCount,pageUrl,null);
	}
	public PagingUtil(String keyfield, String keyword, int currentPage, int totalCount, int rowCount, int pageCount,String pageUrl,String addKey) {
		
		if(addKey == null) addKey = ""; //부가키가 null 일때 ""처리 진행 (문자열로 읽기때문에 예외발생 안함)
		
		//전체 페이지 수
		int totalPage = (int) Math.ceil((double) totalCount / rowCount);
		if (totalPage == 0)
			totalPage = 1;

		//현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (currentPage > totalPage)
			currentPage = totalPage;

		//현재 페이지의 처음과 마지막 글의 번호 가져오기
		startCount = (currentPage - 1) * rowCount + 1;
		endCount = currentPage * rowCount;
		
		//시작 페이지와 마지막 페이지 값 구하기
		int startPage = (int) ((currentPage - 1) / pageCount) * pageCount + 1;
		int endPage = startPage + pageCount - 1;
		
		//마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if (endPage > totalPage)
			endPage = totalPage;

		//이전 페이지 문자열 생성
		pagingHtml = new StringBuffer();
		if(currentPage > pageCount) {
			// 키워드 없을 시, 별도 파라미터 전달X
			if(keyword==null){
				pagingHtml.append("<a href="+pageUrl+"?pageNum="+ (startPage - 1) + addKey +">");
			} else {
				pagingHtml.append("<a href="+pageUrl+"?keyfield="+keyfield+"&keyword="+keyword+"&pageNum="+ (startPage - 1) + addKey +">");
			}
			pagingHtml.append("이전");
			pagingHtml.append("</a>");
		}
		pagingHtml.append("&nbsp;|&nbsp;");
		
		//페이지 번호 문자열 생성 [현재 보고 있는 페이지 빨강 강조]
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage)
				break;
			
			if (i == currentPage) {
				pagingHtml.append("&nbsp;<b> <font color='red'>");
				pagingHtml.append(i);
				pagingHtml.append("</font></b>");
			} else {
				// 키워드 없을 시, 별도 파라미터 전달X
				if(keyword == null){
					pagingHtml.append("&nbsp;<a href='"+pageUrl+"?pageNum=");
				} else {
					pagingHtml.append("&nbsp;<a href='"+pageUrl+"?keyfield="+keyfield+"&keyword="+keyword+"&pageNum=");
				}
				pagingHtml.append(i);
				pagingHtml.append(addKey+"'>");
				pagingHtml.append(i);
				pagingHtml.append("</a>");
			}
			pagingHtml.append("&nbsp;");
		}
		pagingHtml.append("&nbsp;&nbsp;|&nbsp;&nbsp;");
		
		//다음 페이지 문자열 생성
		if (totalPage - startPage >= pageCount) {
			// 키워드 없을 시, 별도 파라미터 전달X
			if(keyword == null){
				pagingHtml.append("<a href="+pageUrl+"?pageNum="+ (endPage + 1) + addKey +">");
			} else {
				pagingHtml.append("<a href="+pageUrl+"?keyfield="+keyfield+"&keyword="+keyword+"&pageNum="+ (endPage + 1) + addKey +">");
			}
			pagingHtml.append("다음");
			pagingHtml.append("</a>");
		}
	}
	
	
	/* 메서드 정의 */
	//페이지 표시 문자열 표기 얻기
	public StringBuffer getPagingHtml() {
		return pagingHtml;
	}
	
	//한 페이지에서 보여줄 게시글의 시작 번호 얻기
	public int getStartCount() {
		return startCount;
	}
	
	//한 페이지에서 보여줄 게시글의 끝 번호 얻기
	public int getEndCount() {
		return endCount;
	}

}
