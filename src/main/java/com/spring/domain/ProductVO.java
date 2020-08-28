package com.spring.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private String userid;
	private int pno;
	private String producttype;
	private String productsize;
	private String productname;
	private String gender;
	private String explanation;
	private int price;
	private int inventory;
	private String brand;
	private Date regdate;
	private AttachVO attach;
	
	//�Խù� ��ǰ���� ���
	private List<AttachVO> attachList;
}
