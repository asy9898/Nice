package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.AttachVO;
import com.spring.domain.CartVO;
import com.spring.domain.CartViewVO;
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.ProductVO;
import com.spring.domain.ReviewVO;
import com.spring.mapper.ShopMapper;

@Service
public class ShopServiceImpl implements ShopService {
	@Autowired
	private ShopMapper mapper;
	
	@Override
	public List<ProductVO> selectProduct(Criteria cri) {
		return mapper.selectProduct(cri);
	}

	@Override
	public boolean insertMember(MemberVO vo) {
		return mapper.insertMember(vo)==1?true:false;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public ProductVO productInfo(int pno) {
		ProductVO vo = mapper.productInfo(pno);
		vo.setAttachList(mapper.getImage(pno));
		return vo;
	}

	@Override
	public List<CartViewVO> cartView(String userid) {
		List<CartViewVO> list = mapper.cartView(userid);
		for(CartViewVO vo:list) {
			vo.setAttach(mapper.mainImage(vo.getPno()));
		}
		
		
		return list;
	}

	@Override
	public int totalPrice(String userid) {
		return mapper.totalPrice(userid);
	}

	@Override
	public boolean insertProduct(ProductVO vo) {
		//게시글 db 저장 요청
		boolean result = mapper.insertProduct(vo)==1?true:false;
		
		//첨부파일 db 저장 요청
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return result;
		}
		vo.getAttachList().forEach(attach1->{
			attach1.setPno(vo.getPno());
			mapper.insertImage(attach1);
		});
		return true;
	}

	@Override
	public AttachVO mainImage(int pno) {
		return mapper.mainImage(pno);
	}

	@Override
	public boolean insertCart(CartVO vo) {
		return mapper.insertCart(vo)==1?true:false;
	}

	@Override
	public int total(Criteria cri) {
		return mapper.total(cri);
	}

	@Override
	public int cartAmount(String userid) {
		return mapper.cartAmount(userid);
	}

	@Override
	public boolean deleteCart(int cartid) {
		return mapper.deleteCart(cartid)==1?true:false;
	}

	@Override
	public boolean deleteProduct(int pno) {
		mapper.deleteImage(pno);
		mapper.deleteProCart(pno);
		return mapper.deleteProduct(pno)==1?true:false;
	}

	@Override
	public boolean updateProduct(ProductVO vo) {
		
		//첨부파일 db 저장 요청
		if(vo.getAttachList() == null || vo.getAttachList().size()<=0) {
			return mapper.updateProduct(vo)>=1?true:false;
		}
		vo.getAttachList().forEach(attach1->{
			attach1.setPno(vo.getPno());
			mapper.insertImage(attach1);
		});
		
		return mapper.updateProduct(vo)>=1?true:false;
	}

	@Override
	public int imageAmount(int pno) {
		return mapper.imageAmount(pno);
	}

	@Override
	public boolean deleteUuid(String uuid) {
		return mapper.deleteUuid(uuid)==1?true:false;
	}

	@Override
	public List<ProductVO> checkCart(CartViewVO vo) {
		
		return mapper.checkCart(vo);
	}

	@Override
	public boolean updateCartAmount(CartViewVO vo) {
		return mapper.updateCartAmount(vo)>0?true:false;
	}

	@Override
	public CartViewVO getCart(int cartid) {
		return mapper.getCart(cartid);
	}

	@Override
	public boolean insertReview(ReviewVO vo) {
		return mapper.insertReview(vo)>0?true:false;
	}

	@Override
	public List<ReviewVO> getReview(int pno) {
		return mapper.getReview(pno);
	}
	
	@Override
	public List<ReviewVO> get3Review(int pno) {
		return mapper.get3Review(pno);
	} 


}
