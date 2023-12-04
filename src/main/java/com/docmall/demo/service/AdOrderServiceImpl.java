package com.docmall.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.docmall.demo.domain.OrderDetailInfoVO;
import com.docmall.demo.domain.OrderDetailProductVO;
import com.docmall.demo.domain.OrderVO;
import com.docmall.demo.dto.Criteria;
import com.docmall.demo.mapper.AdOrderMapper;

import lombok.RequiredArgsConstructor;

// 구현 클래스

@Service
@RequiredArgsConstructor
public class AdOrderServiceImpl implements AdOrderService {

	private final AdOrderMapper adOrderMapper;

	@Override
	public List<OrderVO> order_list(Criteria cri, String start_date, String end_date) {

		return adOrderMapper.order_list(cri, start_date, end_date);
	}

	@Override
	public int getTotalCount(Criteria cri, String start_date, String end_date) {

		return adOrderMapper.getTotalCount(cri, start_date, end_date);
	}

	@Override
	public List<OrderDetailInfoVO> orderDetailInfo1(Long ord_code) {

		return adOrderMapper.orderDetailInfo1(ord_code);
	}

	// MyBatis의 resultMap 사용(예외)
	@Override
	public List<OrderDetailProductVO> orderDetailInfo2(Long ord_code) {
		
		return adOrderMapper.orderDetailInfo2(ord_code);
	}
	
	@Override
	public void order_product_delete(Long ord_code, Integer pro_num) {
		
		adOrderMapper.order_product_delete(ord_code, pro_num);
	}

}
