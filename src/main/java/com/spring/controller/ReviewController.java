package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.ReviewVO;
import com.spring.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review")
public class ReviewController { 
	@Autowired
	private ShopService service; 
	
	
	@PostMapping("/insertReview")
	public String insertReview(ReviewVO vo) {
		service.insertReview(vo);
		return "redirect:/shop/buypage?pno="+vo.getPno();
	}
	
	
}
