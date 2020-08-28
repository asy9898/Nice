package com.spring.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.AttachVO;
import com.spring.domain.CartVO;
import com.spring.domain.CartViewVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.PageVO;
import com.spring.domain.ProductVO;
import com.spring.domain.ReviewVO;
import com.spring.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/shop/*")
public class ShopController {
	@Autowired
	private ShopService service;
	
	//@PreAuthorize("isAuthenticated()")
	@GetMapping("/buypage")
	public void buy(int pno,Model model) {
		List<ReviewVO> review = service.getReview(pno);
		float sum=0;
		for(ReviewVO vo:review) {
			sum+=vo.getScore();
		}
		float score = Float.parseFloat(String.format("%.1f", sum/review.size()));
		model.addAttribute("review",service.get3Review(pno));
		model.addAttribute("vo",service.productInfo(pno));
		model.addAttribute("score",score);
		model.addAttribute("r_count",review.size());
	}
	
	@GetMapping("/cart")
	public void cart(HttpSession session,Model model) {
		log.info("cart 실행");
		if(session.getAttribute("login")!=null) {
			MemberVO login = (MemberVO) session.getAttribute("login");
			List<CartViewVO> vo = service.cartView(login.getUserid());
			model.addAttribute("cart",vo);
			if(service.cartAmount(login.getUserid())!=0) {
				model.addAttribute("total",service.totalPrice(login.getUserid()));
			}else {
				model.addAttribute("total",0);
			}
		}
		log.info("실행끝");
	}
	
	@PostMapping("/cart")
	public ResponseEntity<String> cartPost(CartVO vo){
		log.info("cart담기 "+vo.toString());
		
		
		
		List<CartViewVO> list = service.cartView(vo.getUserid());
		List<CartViewVO> plist = new ArrayList<CartViewVO>();
		
		for(CartViewVO cvo:list) {
//			장바구니에 담는 상품이 카트에 이미있는 pno 인지 확인
			if(cvo.getPno()==vo.getPno()){
				plist.add(cvo);
			}
			if(!plist.isEmpty()) {
				for(CartViewVO pvo:plist) {
//					이미 있는pno중에 사이즈까지 같은 상품이 있다면
					if(pvo.getProductsize().equals(vo.getProductsize())) {
//						update로 기존 갯수 + 장바구니에 담는 갯수로 업데이트 하고 return
						pvo.setAmount(pvo.getAmount()+vo.getAmount());
						if(service.updateCartAmount(pvo)) {
							return new ResponseEntity<String>("success",HttpStatus.OK);
						}
						
					}
				}
				
			}
		}
		
		
		if(service.insertCart(vo)) {
			return new ResponseEntity<String>("success",HttpStatus.OK);
		}
		return new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
		
	}
	
	//검색버튼 클릭 -> /list로 get으로 검색값 가져오기 검색값 = 검색어 - 검색종류는 안받음 select문은
//	select * from shop_product where producttype like '%검색어%' or productname like '%검색어%' or brand like '%검색어%'; 로 함.
//  그냥 페이지만넘기거나 기본시작페이지때는 검색값이 '' 이기때문에 '%%'로 모든 목록이 보여짐. 검색값이 있으면 검색값으만 보여짐 받은 select값은 
	
	
	@GetMapping("/proview")
	public void proview(Model model,@ModelAttribute("cri")Criteria cri,String gender) {
		if (cri.getKeyword()==null){
			cri.setKeyword("");
		}
		List<ProductVO> list = service.selectProduct(cri);
		for(ProductVO vo:list) {
			vo.setAttach(service.mainImage(vo.getPno()));
		}
		model.addAttribute("total",service.total(cri));
		model.addAttribute("list",list);
		model.addAttribute("page",new PageVO(cri,service.total(cri)));
	}
	
	
	
	@PostMapping("/proview")
	public ResponseEntity<List<ProductVO>> proviewAjax(Model model,@ModelAttribute("cri")Criteria cri) {
		List<ProductVO> list = service.selectProduct(cri);
		for(ProductVO vo:list) {
			vo.setAttach(service.mainImage(vo.getPno()));
		}
		System.out.println(service.total(cri));
		if(cri.getAmount()*cri.getPageNum()>service.total(cri)) {
			model.addAttribute("mv","true");
		}
		return new ResponseEntity<List<ProductVO>>(list,HttpStatus.OK);
	}
	
	// cri(Pagenum,amount,keyword)값 받고 cri추가한 select문으로 재검색한 결과값 model에 담기 page수를 담은 page 도 같이 넘김. - 페이징먼저해야함
	//전체게시물 보기
//	@GetMapping("/list")
//	public void list(Model model,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
//			model.addAttribute("list",service.getList(cri));
//			//하단의 페이지 나누기와 관련된 정보들
//			if(service.getList(cri).isEmpty()) {
//				rttr.addFlashAttribute("info","검색값이 없습니다.");
//			}
//			model.addAttribute("page",new PageVO(cri, service.total(cri)));
//	}
	
	
	
	
	@GetMapping("/register")
	public void register() {
		log.info("register 폼 요청");
	}
	
	@PostMapping("/register")
	public String registerPost(ProductVO vo,RedirectAttributes rttr) {
//		log.info("사진 : "+vo.getAttachList().toString());
		if(vo.getAttachList()!=null) {
			log.info(vo.toString());
			vo.getAttachList().forEach(attach -> log.info(attach+""));
		}else {
			rttr.addFlashAttribute("info","상품 이미지는 필수로 등록해야 합니다.");
			return "redirect:/shop/register";
		}
		if(service.insertProduct(vo)) {
			return "redirect:/shop/proview";
		}
		return "redirect:/shop/register";
	}
	
	@GetMapping("/mainImage")
	public ResponseEntity<AttachVO> getImage(int pno){
		AttachVO vo = service.mainImage(pno);
		if(vo!=null) {
			return new ResponseEntity<AttachVO>(vo,HttpStatus.OK);			
		}
		return new ResponseEntity<AttachVO>(HttpStatus.BAD_REQUEST);			
		
	}
	
	@GetMapping("/test")
	public String test() {
		log.info("장바구니 선택기능 테스트 ");
		
		return"";
	}
	
	
	@PostMapping("/deleteCart")
	public String deleteCart(int[] cartid,RedirectAttributes rttr) {
		try {
			System.out.println(""+cartid.length);			
		} catch (Exception e) {
			rttr.addFlashAttribute("info","삭제 할 항목이 없습니다.");
			return "redirect:/shop/cart";
		}
			for(int i:cartid) {
				service.deleteCart(i);
			}
		rttr.addFlashAttribute("info","삭제되었습니다.");
		return "redirect:/shop/cart";
	}
	
	@PostMapping("/deleteProduct")
	public String deletePro(int pno) {
		if(service.deleteProduct(pno)) {			
			return"redirect:/shop/proview";
		}
		return"redirect:/shop/buypage?pno="+pno;
	}
	
	
	@GetMapping("/modify")
	public void updateProForm(int pno,Model model) {
		log.info(""+service.productInfo(pno));
		model.addAttribute("vo",service.productInfo(pno));
	}
	
	@PostMapping("/updateCart")
	public ResponseEntity<CartViewVO> updateCart(CartViewVO vo,String userid) {
		if(service.updateCartAmount(vo)) {
			int total = service.totalPrice(userid);
					vo.setTotal(total);
			return new ResponseEntity<CartViewVO>(vo,HttpStatus.OK);			
		}else {
			return new ResponseEntity<CartViewVO>(HttpStatus.BAD_REQUEST);						
		}
	}
	
	@PostMapping("/updateTotalPrice")
	public ResponseEntity<Integer> MethodName(int[] cartid) throws Exception{
		int sum = 0;
		try {
			for(int cart:cartid) {
				CartViewVO vo = service.getCart(cart);
				int price = vo.getAmount()*vo.getPrice();
				System.out.println(price);
				sum+=price;
			}
		} catch (Exception e) {			
			return new ResponseEntity<Integer>(sum,HttpStatus.OK);
		}
		return new ResponseEntity<Integer>(sum,HttpStatus.OK);
	}

	
	
	@PostMapping("/modify")
	public String updatePro(ProductVO vo,RedirectAttributes rttr) {
		if(vo.getAttachList()!=null||service.imageAmount(vo.getPno())!=0) {
		}else {
			rttr.addFlashAttribute("info","상품 이미지는 필수로 등록해야 합니다.");
			return "redirect:/shop/modify?pno="+vo.getPno();
		}
		
		if(service.updateProduct(vo)) {
			return "redirect:/shop/proview";
		}
		return "redirect:/shop/modify";
	}
	
	@GetMapping("/review")
	public void review(int pno,Model model) {
		List<ReviewVO> review = service.getReview(pno);
		float sum=0;
		for(ReviewVO vo:review) {
			sum+=vo.getScore();
		}
		float score = Float.parseFloat(String.format("%.1f", sum/review.size()));
		System.out.println(score);
		model.addAttribute("review",review);
		model.addAttribute("score",score);
		model.addAttribute("r_count",review.size());
	}
	
	@GetMapping("/paytest")
	public void pay(int total,Model model) {
		System.out.println("pay실행");
		model.addAttribute("total",total);
	}

	
	
}
