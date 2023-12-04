package com.docmall.demo.domain;

import lombok.Data;

@Data
public class OrderDetailProductVO {

	// 기존 클래스를 필드로 사용 -> MyBatis에서는 resultMap으로 사용
	private OrderDetailVO orderDetailVO; // AdOrderMapper.xml에서 <collection>으로 표현
	private ProductVO productVO; //  AdOrderMapper.xml에서 <collection>으로 표현
}
