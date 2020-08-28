package com.spring.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private String keyword;
	
	public Criteria() {
		this(1,12);
	}
	public Criteria(String keyword,int pageNum,int amount) {		
		this.pageNum=pageNum;
		this.amount=amount;
		this.keyword=keyword;
	}
	public Criteria(int pageNum,int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}

	
	
	
}
