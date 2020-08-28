package com.spring.domain;

import lombok.Data;

@Data
public class CartViewVO {
	private int cartid;
	private int price;
	private String productname;
	private String productsize;
	private int amount;
	private AttachVO attach;
	private int pno;
	private int total;
}
