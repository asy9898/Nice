package com.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.domain.AttachVO;
import com.spring.domain.CartVO;
import com.spring.domain.CartViewVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.ProductVO;
import com.spring.domain.ReviewVO;

public interface ShopMapper {
	public List<ProductVO> selectProduct(Criteria cri);
	public int insertMember(MemberVO vo);
	public MemberVO login(MemberVO vo);
	public ProductVO productInfo(int pno);
	public List<CartViewVO> cartView(String userid);
	public int totalPrice(String userid);
	public int insertProduct(ProductVO vo);
	public int insertImage(AttachVO vo);
	public AttachVO mainImage(int pno);
	public List<AttachVO> getImage(int pno);
	public int insertCart(CartVO vo);
	public int total(Criteria cri);
	public int cartAmount(String user);
	public int deleteCart(int cartid);
	public int deleteProduct(int pno);
	public int deleteImage(int pno);
	public int deleteProCart(int pno);
	public int deleteUuid(String uuid);
	public int imageAmount(int pno);
	public int updateProduct(ProductVO vo);
	public List<ProductVO> checkCart(CartViewVO vo);
	public int updateCartAmount(CartViewVO vo);
	public CartViewVO getCart(int cartid);
	public int insertReview(ReviewVO vo);
	public List<ReviewVO> getReview(int pno);
	public List<ReviewVO> get3Review(int pno);
}
