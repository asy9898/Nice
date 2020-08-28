package com.spring.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String password;
	private String username;
	private String gender;
	private String email;
	private String phone;
	private String address;
}
