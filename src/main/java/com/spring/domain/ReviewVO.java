package com.spring.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewVO {
//	r_title, r_content, r_regdate, userid, pno, score	
	private int rno;
	private int pno;
	private String userid;
	private String r_title;
	private String r_content;
	private Date r_regdate;
	private int score;
	
	
}
