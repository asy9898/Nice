package com.spring.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageVO {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	private Criteria cri;
	
	public PageVO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		
		//������ ������ ��� ceil = �ø�(�ݿø�x) 1.1 = 2  == pageNum == 9��� 0.9�� �ø� 1�̵ǰ� 1*10���� 10�������� �ִ�������
		// pageNum == 11 �̶�� 1.1�� �ø� = 2 * 10 �̹Ƿ� �ִ��������� 20�� ��.
		endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		//���� ������ ���
		startPage = this.endPage-9;
		
		//������ �������� 10���� �ȵ� �� �� �ֱ� ������ ������ ������ ������ ���ϱ�
		//total = count * bno���������� �� �Խñ� ���� ���ѵ�, �Խñ� ���� 80�����, 80 / 10(�������� �Խñ� ������ ��)  = 8
		//realEnd = 8�̵ǰ� ���� endpage(�ּ� 10)>realEnd ���(realEnd�� �� �۴ٸ�) endpage = realEnd�� �ǵ�����.
		int realEnd = (int)(Math.ceil((total/1.0)/cri.getAmount()));
		if(realEnd < this.endPage) {
			endPage = realEnd;
		}
		this.prev = startPage > 1; //startPage�� 1���� ũ�ٸ� true����
		this.next = endPage < realEnd; //endPage�� realEnd���� ũ�ٸ� true����
	}
	
}
