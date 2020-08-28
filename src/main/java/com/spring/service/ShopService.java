package com.spring.service;

import java.util.List;

import com.spring.domain.AttachVO;
import com.spring.domain.CartVO;
import com.spring.domain.CartViewVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.ProductVO;
import com.spring.domain.ReviewVO;

public interface ShopService {
	public List<ProductVO> selectProduct(Criteria cri);
	public boolean insertMember(MemberVO vo);
	public MemberVO login(MemberVO vo);
	public ProductVO productInfo(int pno);
	public List<CartViewVO>cartView(String userid);
	public int totalPrice(String userid);
	public boolean insertProduct(ProductVO vo);
	public AttachVO mainImage(int pno);
	public boolean insertCart(CartVO vo);
	public int total(Criteria cri);
	public int cartAmount(String userid);
	public boolean deleteCart(int cartid);
	public boolean deleteProduct(int pno);
	public boolean deleteUuid(String uuid);
	public boolean updateProduct(ProductVO vo);
	public int imageAmount(int pno);
	public List<ProductVO> checkCart(CartViewVO vo);
	public boolean updateCartAmount(CartViewVO vo);
	public CartViewVO getCart(int cartid);
	public boolean insertReview(ReviewVO vo);
	public List<ReviewVO> getReview(int pno);
	public List<ReviewVO> get3Review(int pno);
	
}
