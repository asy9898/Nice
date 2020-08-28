package com.spring.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.MemberVO;
import com.spring.service.KakaoAPI;
import com.spring.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private ShopService service;
	@Autowired
	private KakaoAPI kakao;
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@PostMapping("/login")
	public String loginPost(MemberVO vo,HttpSession session,RedirectAttributes rttr) {
		log.info("loginPost 요청 vo : "+vo.toString());
//		log.info("login : "+login.toString());
		if(service.login(vo)!=null) {
			MemberVO login = service.login(vo);
			session.setAttribute("login", login);
			return "redirect:/";
		}
		rttr.addFlashAttribute("msg","아이디 혹은 비밀번호가 잘못되었습니다.");
		return "redirect:/member/login";
	}
	
	@GetMapping("/step1")
	public void step1() {
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("login");
		return "redirect:/";
	}
	@PostMapping("/step2")
	public void stpe2() {
		log.info("step2");
	}
	@PostMapping("/step3")
	public String stpe3(MemberVO vo,Model model) {
		log.info("step3 vo : "+vo.toString());
		if(service.insertMember(vo)) {
			return "redirect:/member/login";
		}else {
			model.addAttribute("vo",vo);
			return "/member/step2";
		}
		
		
	}
	
	@RequestMapping(value="/kakaoauth",produces = "application/json", method= {RequestMethod.GET, RequestMethod.POST})
	public String kakaologin(@RequestParam("code") String code,HttpSession session) {
//		System.out.println(code);
		String access_Token = kakao.getAccessToken(code);
//		System.out.println("controller access_token : " + access_Token);
	    HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
	    System.out.println("login Controller : " + userInfo);
	    
	    //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
	    if (userInfo.get("nickname") != null) {
//	    	MemberVO vo = new MemberVO();
//	    	String userid = (String) userInfo.get("nickname");
//	    	vo.setUserid(userid);
//	        session.setAttribute("login", userid);
//	        session.setAttribute("access_Token", access_Token);
	    }
		return "redirect:/";
	}
	
	
	
	
	
}
