package com.spring.domain;

import lombok.Data;

@Data
public class CartVO {
	private int cartid;
	private String userid;
	private int pno;
	private int amount;
	private String productsize;
}
