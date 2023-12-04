package com.docmall.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.demo.domain.OrderDetailInfoVO;
import com.docmall.demo.domain.OrderDetailProductVO;
import com.docmall.demo.domain.OrderVO;
import com.docmall.demo.dto.Criteria;

public interface AdOrderMapper {
	
	// 데이터의 개수에 따라 List 컬렉션 사용
	List<OrderVO> order_list(@Param("cri") Criteria cri, 
							@Param("start_date") String start_date, 
							@Param("end_date") String end_date);
	
	// order_list와 getTotalCount는 하나의 작업으로 볼 수 있어 파라미터를 일치시켜야 함
	int getTotalCount(@Param("cri") Criteria cri, 
					 @Param("start_date") String start_date, 
					 @Param("end_date") String end_date);
	
	// 주문상세 1
	List<OrderDetailInfoVO> orderDetailInfo1(Long ord_code);
	
	// 주문상세 2 ─ MyBatis의 resultMap 사용(예외)
	List<OrderDetailProductVO> orderDetailInfo2(Long ord_code); // 기존 클래스 이용: OrderDetailVO, ProductVO 필드가 있는 클래스
	
	// @Param: 하나 있을 때도 사용하나, 일반적으로 생략함
	void order_product_delete(@Param("ord_code") Long ord_code, @Param("pro_num") Integer pro_num);
}
