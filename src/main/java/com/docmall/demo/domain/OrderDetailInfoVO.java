package com.docmall.demo.domain;

import lombok.Data;

// 관리자 기능 ─ 주문상세 정보를 저장하기 위한 목적
// 주문상세 테이블과 상품테이블을 조인한 결과를 담기 위한 클래스

// OT.ORD_CODE, OT.PRO_NUM, OT.DT_AMOUNT, P.PRO_NUM, P.PRO_NAME, P.PRO_PRICE, P.PRO_UP_FOLDER, P.PRO_IMG
@Data
public class OrderDetailInfoVO {
	
	private Long ord_code; // 주문번호: 시퀀스로 처리
	private Integer pro_num; // 상품코드
	private String pro_name;
	private int pro_price; // 상품가격(= dt_price)
	private int dt_amount; // 개별 상품 개수: 카트 쪽에서 받아옴
	
	private int ord_price; // 주문금액(pro_price * dt_amount). OrderVo의 ord_price와는 다름
	
	private String pro_up_folder; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	private String pro_img; // 클라이언트에서 직접 입력받지 않고 스프링에서 별도로 처리(매퍼 작업)
	
}
