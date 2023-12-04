package com.docmall.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.demo.domain.OrderDetailInfoVO;
import com.docmall.demo.domain.OrderDetailProductVO;
import com.docmall.demo.domain.OrderVO;
import com.docmall.demo.dto.Criteria;
import com.docmall.demo.dto.PageDTO;
import com.docmall.demo.service.AdOrderService;
import com.docmall.demo.util.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/order/*")
@Slf4j
public class AdOrderController {

	private final AdOrderService adOrderService;

	// 메인 및 썸네일 이미지 업로드 폴더 경로 주입 작업
	// servlet-context.xml의 beans 참조 -> <beans:bean id="uploadPath" class="java.lang.String">
	@Value("${file.dir}")
	private String uploadPath;

	// 주문 리스트: 목록과 페이징. 테이블의 전체 데이터를 가져옴
	// @ModelAttribute를 사용한 이유는 사용자가 썼던 날짜를 유지하기 위함
	@GetMapping("/order_list")
	public void order_list(Criteria cri, @ModelAttribute("start_date") String start_date, 
						  @ModelAttribute("end_date") String end_date, Model model) throws Exception { // Model model: JSP에서 어떤 정보를 보여주고자 할 때

		// 10 -> 2로 변경
		cri.setAmount(2); // Criteria에서 this(1, 2);

		List<OrderVO> order_list = adOrderService.order_list(cri, start_date, end_date);
		model.addAttribute("order_list", order_list);

		int totalCount = adOrderService.getTotalCount(cri, start_date, end_date);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
	}

	
	// 주문상세 방법1: 주문상세 정보가 클라이언트에서 JSON 형태로 변환되어 보내진다(pom.xml에 jackson-databind 라이브러리가 백그라운드 작동).
	// ReviewContorll에서 Copy & Paste
	// 전통적인 형태의 주소 list?pro_num=10&page=1 -> REST API 개발형태 주소 list/10/1
	// ResponseEntity<String>는 AJAX 요청 시 SELECT 외 나머지, AJAX 요청 시 SELECT면 해당하는 리턴 타입 필요
	@GetMapping("/order_detail_info1/{ord_code}") // RESTful 개발방법론의 주소
	public ResponseEntity<List<OrderDetailInfoVO>> order_detail_list1(@PathVariable("ord_code") Long ord_code) throws Exception {

		// 클래스명은 주문 상세 테이블과 상품 테이블을 조인한 결과만 담는 클래스

		ResponseEntity<List<OrderDetailInfoVO>> entity = null;
		
		List<OrderDetailInfoVO> orderDetailList = adOrderService.orderDetailInfo1(ord_code);
		
		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 브라우저에서 상품 이미지 출력 시 역슬래시 사용이 문제가 된다. 그래서 슬래시로 변환해서 클라이언트로 보냄
		orderDetailList.forEach(vo -> {
			vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		});
		
		entity = new ResponseEntity<List<OrderDetailInfoVO>>(orderDetailList, HttpStatus.OK);
	
		return entity;
	}
	
	// 주문상세 내역에서 개별 상품 삭제(Model 필요 없음, Criteria 추가 로직 없음)
	@GetMapping("/order_product_delete")
	public String order_product_delete(Criteria cri, Long ord_code, Integer pro_num) throws Exception {
		
		// 주문상세 개별 삭제
		adOrderService.order_product_delete(ord_code, pro_num);
		
		return "redirect:/admin/order/order_list" + cri.getListLink();
	}
	
	// 주문상세 방법2
	@GetMapping("/order_detail_info2/{ord_code}") // RESTful 개발방법론의 주소
	public String order_detail_list2(@PathVariable("ord_code") Long ord_code, Model model) throws Exception {
		
		List<OrderDetailProductVO> orderProductList = adOrderService.orderDetailInfo2(ord_code);
		
		// 날짜 폴더의 '\'를 '/'로 바꾸는 작업(이유: '\'로 되어 있는 정보가 스프링으로 보내는 요청 데이터에 사용되면 에러 발생)
		// 브라우저에서 상품 이미지 출력 시 역슬래시 사용이 문제가 된다. 그래서 슬래시로 변환해서 클라이언트로 보냄
		/*
		orderProductList.forEach(vo -> {
			vo.setPro_up_folder(vo.getPro_up_folder().replace("\\", "/"));
		});
		*/
		// 클래스 자체가 필드로 되어 있어 계층적으로 상위 단계를 표시해줘야 함
		orderProductList.forEach(vo -> {
			vo.getProductVO().setPro_up_folder(vo.getProductVO().getPro_up_folder().replace("\\", "/"));
		});
		
		model.addAttribute("orderProductList", orderProductList);
		
		return "/admin/order/order_detail_product";
	}
	
	// 상품 리스트에서 보여줄 이미지. <img src="매핑주소">
	@ResponseBody
	@GetMapping("/imageDisplay") // /admin/product/imageDisplay?dateFolderName=값1&fileName=값2
	public ResponseEntity<byte[]> imageDisplay(String dateFolderName, String fileName) throws Exception {

		return FileUtils.getFile(uploadPath + dateFolderName, fileName); // dateFolderName: 날짜 폴더명
	}

}
