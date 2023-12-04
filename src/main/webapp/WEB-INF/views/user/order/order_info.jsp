<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

				<!doctype html>
				<html lang="en">

				<head>
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
					<meta name="description" content="">
					<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
					<meta name="generator" content="Hugo 0.101.0">
					<title>Pricing example · Bootstrap v4.6</title>

					<%@include file="/WEB-INF/views/comm/plugIn2.jsp" %>

						<style>
							.bd-placeholder-img {
								font-size: 1.125rem;
								text-anchor: middle;
								-webkit-user-select: none;
								-moz-user-select: none;
								-ms-user-select: none;
								user-select: none;
							}

							@media (min-width : 768px) {
								.bd-placeholder-img-lg {
									font-size: 3.5rem;
								}
							}
						</style>
				</head>

				<body>

					<%@include file="/WEB-INF/views/comm/header.jsp" %>

						<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
							<p>주문정보</p>
						</div>

						<div class="container">
							<table class="table table-striped">
								<thead style="text-align: center;">
									<tr>
										<th scope="col">상품</th>
										<th scope="col">상품명</th>
										<th scope="col">판매가</th>
										<th scope="col">수량</th>
										<th scope="col">합계</th>
									</tr>
								</thead>
								<tbody style="text-align: center;">
									<c:forEach items="${order_info}" var="cartDTO" varStatus="status">
										<tr>
											<td>
												<img width="50%" height="50"
													src="/user/product/imageDisplay?dateFolderName=${cartDTO.pro_up_folder}&fileName=${cartDTO.pro_img}"
													alt="">
											</td>
											<td>${cartDTO.pro_name}</td>
											<td><span id="unitPrice">${cartDTO.pro_price}</span></td>
											<td>${cartDTO.cart_amount}</td>
											<td>
												<span class="unitTotalPrice" id="unitTotalPrice">
													${(cartDTO.pro_price * cartDTO.cart_amount)}</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="8" style="text-align: right;">
											상품 외 <span id="cart_price_count">${fn:length(order_info) - 1}건</span>
											주문금액: <span id="cart_total_price">${order_price}</span>
										</td>
									</tr>
								</tfoot>
							</table>

							<div class="box box-primary">
								<div class="box-body">
									<form role="form" id="" method="post" action="">
										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">주문하시는 분</legend>

											<div class="form-group row">
												<label for="mbsp_id" class="col-2">주문자</label>
												<div class="col-10">
													<!-- value 값에 'sessionScope.' 는 생략 가능 -->
													<input type="text" class="form-control" id="b_mbsp_id" value="${loginStatus.mbsp_id}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="mbsp_name" class="col-2">이름</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_mbsp_name" value="${loginStatus.mbsp_name}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_postcode" class="col-2">우편번호</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_mbsp_zipcode"
														value="${loginStatus.mbsp_zipcode}" readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_address" class="col-2">기본주소</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_mbsp_addr" value="${loginStatus.mbsp_addr}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_detailAddress" class="col-2">상세주소</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_mbsp_deaddr" value="${loginStatus.mbsp_deaddr}"
														readonly>
												</div>
											</div>
											<div class="form-group row">
												<label for="mbsp_phone" class="col-2">전화번호</label>
												<div class="col-10">
													<input type="text" class="form-control" id="b_mbsp_phone" value="${loginStatus.mbsp_phone}"
														readonly>
												</div>
											</div>
										</fieldset>

										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">받으시는 분</legend>

											<div class="form-group row">
												<label for="mbsp_id" class="col-2">수령인(이름)</label>
												<div class="col-8">
													<input type="text" class="form-control" name="mbsp_name" id="mbsp_name"
														placeholder="이름 입력...">
												</div>
												<div class="col-2">
													<input type="checkbox" class="form-controel" id="same"> 주문자와 동일
												</div>
											</div>


											<div class="form-group row">
												<label for="sample2_postcode" class="col-2">우편번호</label>
												<div class="col-8">
													<input type="text" class="form-control" name="mbsp_zipcode" id="sample2_postcode"
														placeholder="우편번호 입력...">
												</div>
												<div class="col-2">
													<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-outline-info">우편번호
														찾기</button>
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_address" class="col-2">기본주소</label>
												<div class="col-10">
													<input type="text" class="form-control" name="mbsp_addr" id="sample2_address"
														placeholder="기본주소 입력...">
												</div>
											</div>
											<div class="form-group row">
												<label for="sample2_detailAddress" class="col-2">상세주소</label>
												<div class="col-10">
													<input type="text" class="form-control" name="mbsp_deaddr" id="sample2_detailAddress"
														placeholder="상세주소 입력...">
													<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
												</div>
											</div>
											<div class="form-group row">
												<label for="mbsp_phone" class="col-2">전화번호</label>
												<div class="col-10">
													<input type="text" class="form-control" name="mbsp_phone" id="mbsp_phone"
														placeholder="전화번호 입력...">
												</div>
											</div>
										</fieldset>

										<hr>
										<fieldset class="form-group border p-3">
											<legend class="w-auto px-2">결제방법 선택</legend>
											<div class="form-group row">
												<label for="mbsp_phone" class="col-2">결제방법</label>
												<div class="col-10">
													<input type="radio" name="paymethod" id="paymethod1" value="nobank">무통장 입금
													<input type="radio" name="paymethod" id="paymethod2" value="kakaopay"><img
														src="/images/payment.png" class="img-fluid" />
												</div>
											</div>
											<div class="form-group row" id="nobank_info" style="display: none;">
												<label for="mbsp_phone" class="col-2">무통장 입금정보</label>
												<div class="col-10">
													은행명
													<select name="pay_nobank" id="pay_nobank">
														<option value="123-123-1234">KEB하나은행</option>
														<option value="456-456-4567">국민은행</option>
														<option value="100-100-1000">신한은행</option>
														<option valie="200-200-2000">SC제일은행</option>
													</select><br>
													계좌번호<input type="text" name="pay_bankaccount" id="pay_bankaccount"><br>
													예금주<input type="text" name="pay_nobank_user" id="pay_nobank_user"><br>
													메모<textarea cols="50" rows="3" name="pay_memo" id="pay_memo"></textarea>
												</div>
											</div>
										</fieldset>

										<div class="form-group row text-center">
											<div class="col-12">
												<button type="button" class="btn btn-primary" id="btn_order">주문 및 결제하기</button>
											</div>
										</div>
									</form>
								</div>
							</div>
							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<%@include file="/WEB-INF/views/comm/plugIn.jsp" %>
				<%@include file="/WEB-INF/views/comm/postCode.jsp" %>


							

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/category_menu.js"></script>

							<script>
								$(document).ready(function () {

									// 주문자와 동일
									$("#same").on("click", function () {
										if ($("#same").is(":checked")) {
											// console.log("체크");

											$("#mbsp_name").val($("#b_mbsp_name").val());
											$("#sample2_postcode").val($("#b_mbsp_zipcode").val());
											$("#sample2_address").val($("#b_mbsp_addr").val());
											$("#sample2_detailAddress").val($("#b_mbsp_deaddr").val());
											$("#mbsp_phone").val($("#b_mbsp_phone").val());
										} else {
											$("#mbsp_name").val("");
											$("#sample2_postcode").val("");
											$("#sample2_address").val("");
											$("#sample2_detailAddress").val("");
											$("#mbsp_phone").val("");
										}
									});

									// 주문하기
									$("#btn_order").on("click", function () {

										// 1) 주문 테이블 , 주문 상세 테이블, 결제 테이블 저장에 필요한 정보 구성
										// 2) 카카오페이 결제에 필요한 정보구성
										// 스프링에서 처리할 수 있는 부분

										console.log("paymethod", $("input[name='paymethod']:checked").val());
										console.log("ord_name", $("#mbsp_name").val());
										console.log("ord_zipcode", $("input[name='mbsp_zipcode']").val());
										console.log("ord_addr_basic", $("input[name='mbsp_addr']").val());
										console.log("ord_addr_detail", $("input[name='mbsp_deaddr']").val());
										console.log("ord_tel", $("#mbsp_phone").val());
										// 입력 양식이 아닌 태그들은 text() 사용
										console.log("ord_price", $("#cart_total_price").text());
										console.log("total_price", $("#cart_total_price").text());

										let paymethod = $("input[name='paymethod']:checked").val();

										if (paymethod == 'kakaopay') {
											// 1)에 대한 작업
											$.ajax({
												url: '/user/order/orderPay',
												type: 'get',
												data: {
													paymethod: $("input[name='paymethod']:checked").val(), // 결제방식
													ord_name: $("#mbsp_name").val(),
													ord_zipcode: $("input[name='mbsp_zipcode']").val(),
													ord_addr_basic: $("input[name='mbsp_addr']").val(),
													ord_addr_detail: $("input[name='mbsp_deaddr']").val(),
													ord_tel: $("#mbsp_phone").val(),
													// int totalprice, int ord_price는 참조타입이 아님(null 값 없음)
													// 참조타입은 스프링에서 자동 처리
													// 실수값 처리에 대한 문제(할인율 포함)로 정상 출력되지 않음
													ord_price: $("#cart_total_price").text(),
													totalprice: $("#cart_total_price").text(),
												},
												dataType: 'json',
												success: function (response) {
													console.log("응답: " + response);

													alert(response.next_redirect_pc_url);
													location.href = response.next_redirect_pc_url;
												}
											});

										} else if (paymethod == 'nobank') {
											$.ajax({
												url: '/user/order/nobank',
												type: 'get',
												data: {
													paymethod: $("input[name='paymethod']:checked").val(), // 결제방식
													ord_name: $("#mbsp_name").val(),
													ord_zipcode: $("input[name='mbsp_zipcode']").val(),
													ord_addr_basic: $("input[name='mbsp_addr']").val(),
													ord_addr_detail: $("input[name='mbsp_deaddr']").val(),
													ord_tel: $("#mbsp_phone").val(),
													// int totalprice, int ord_price는 참조타입이 아님(null 값 없음)
													// 참조타입은 스프링에서 자동 처리
													// 실수값 처리에 대한 문제(할인율 포함)로 정상 출력되지 않음
													ord_price: $("#cart_total_price").text(),
													totalprice: $("#cart_total_price").text(),
													
													pay_nobank_user: $("#pay_nobank_user").val(),
													pay_nobank: $("#pay_nobank option:selected").text(), // val()이라 하면 계좌번호, pay_nobank = $(this).text();
													pay_memo: $("#pay_memo").val(),
													pay_bankaccount: $("#pay_bankaccount").val(),
												},
												dataType: 'text',
												success: function (result) {
													console.log("응답: " + result);

													if (result == 'success') {
														alert("무통장입금으로 주문이 완료되었습니다.")
														location.href = '/user/order/orderComplete';
													}
												}
											});
										}
									})

									
									// 무통장 선택 시 무통장 입력정보 표시하기
									$("input[name='paymethod']").on("click", function () {

										let paymethod = $("input[name='paymethod']:checked").val();

										if (paymethod == "nobank") {
											$("#nobank_info").show();
										} else if (paymethod == "kakaopay") {
											$("#nobank_info").hide();
										}
									})

									// 입금은행 선택 시
									$("#pay_nobank").on("change", function () {
										$("#pay_bankaccount").val($(this).val());
									
									})

								}); // ready event end
							</script>
				</body>

				</html>