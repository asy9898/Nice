package com.spring.domain;

import lombok.Data;

@Data
public class AttachVO {
	private String uuid;  // uuid
	private String uploadPath;  //폴더 구분방법 기본 
	private String fileName;  // 원본 파일명
	private int pno;  //상품번호
	
}
