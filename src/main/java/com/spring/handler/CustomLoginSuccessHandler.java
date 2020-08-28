package com.spring.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("Login Success Handler"+authentication);
		
		//Authentication ���� Ȯ���� ����
		List<String> roleNames = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority -> roleNames.add(authority.getAuthority()));
		
		log.info("roleNames : "+roleNames);
		
		//�ο��� ���ѿ� ���� ������ �̵���Ű��
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/member/admin");
			return;
		}else if(roleNames.contains("ROLE_MEMBER") || roleNames.contains("ROLE_MANAGER")) {
				response.sendRedirect("/board/list");
				return;
		}
		response.sendRedirect("/");
	}

}