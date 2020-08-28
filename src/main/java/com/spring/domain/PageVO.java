package com.spring.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageVO {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	private Criteria cri;
	
	public PageVO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		//끝나는 페이지 계산 ceil = 올림(반올림x) 1.1 = 2  == pageNum == 9라면 0.9의 올림 1이되고 1*10으로 10페이지가 최대페이지
		// pageNum == 11 이라면 1.1의 올림 = 2 * 10 이므로 최대페이지는 20이 됨.
		endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		//시작 페이지 계산
		startPage = this.endPage-9;
		
		//끝나는 페이지가 10개가 안될 수 도 있기 떄문에 실제로 끝나는 페이지 구하기
		//total = count * bno같은것으로 총 게시글 수를 구한뒤, 게시글 수가 80개라면, 80 / 10(페이지당 게시글 보여줄 양)  = 8
		//realEnd = 8이되고 만약 endpage(최소 10)>realEnd 라면(realEnd가 더 작다면) endpage = realEnd가 되도록함.
		int realEnd = (int)(Math.ceil((total/1.0)/cri.getAmount()));
		if(realEnd < this.endPage) {
			endPage = realEnd;
		}
		this.prev = startPage > 1; //startPage가 1보다 크다면 true리턴
		this.next = endPage < realEnd; //endPage가 realEnd보다 크다면 true리턴
	}
	
}
