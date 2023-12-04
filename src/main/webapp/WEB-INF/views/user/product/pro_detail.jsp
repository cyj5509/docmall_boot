<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core태그 라이브러리 -->
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
					<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
					<link rel="stylesheet" href="https://jqueryui.com/resources/demos/style.css">
					<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
					<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
					<!-- Handlebars(자바스크립트 템플릿 엔진): 서버에서 보내온 JSON 형태의 데이터를 사용하여 작업을 편하게 할 수 있는 특징 -->
					<script src="/js/handlebars.js"></script>
					<script id="reviewTemplate" type="text/x-handlebars-template">
						<table class="table table-sm">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">리뷰내용</th>
									<th scope="col">평점</th>
									<th scope="col">날짜</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								{{#each .}}
								<tr>
									<th scope="row" class="rew_num">{{rew_num}}</th>
									<td class="rew_content">{{rew_content}}</td>
									<td class="rew_score">{{displayStar rew_score}}</td> <!-- displayStar 함수 -->
									<td class="rew_regdate">{{convertDate rew_regdate}}</td> <!-- convertDate 함수 -->
									<td>{{authControlView mbsp_id rew_num rew_score}}</td>
								</tr>
								{{/each}}
							</tbody>
						</table>
					</script>

					<script>
						$(function () {
							$("#tabs_pro_detail").tabs();
						});
					</script>

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

						/* 평점 기본선택자 */
						p#star_rv_score a.rv_score {
							font-size: 22px;
							text-decoration: none;
							color: lightgray;
						}

						/* 평점에 마우스 오버했을 경우 사용되는 CSS 선택자 */
						p#star_rv_score a.rv_score.on {
							color: red;
						}
					</style>
			</head>

			<body>
				<%@include file="/WEB-INF/views/comm/header.jsp" %>
					<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>

						<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
							<p>2차 카테고리: ${cg_name}</p>
						</div>

						<div class="container">
							<div class="card-deck mb-3 text-center row">
								<div class="col-md-6"> <!-- 상품 이미지 -->
									<img class="btn_pro_img" data-pro_num="${productVO.pro_num}" width="100%" height="200"
										src="/user/cart/imageDisplay?dateFolderName=${productVO.pro_up_folder}&fileName=${productVO.pro_img}"
										alt="">
								</div>

								<div class="col-md-6">
									<div class="row text-left">
										<div class="col"> <!-- 상품명 -->
											상품명: ${productVO.pro_name}
										</div>
									</div>
									<div class="row text-left">
										<div class="col"> <!-- 상품가격 -->
											가격: <span id="unit_price">${productVO.pro_price}</span>
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											수량: <input type="number" id="btn_quantity" value="1" style="width: 80px">
										</div>
									</div>
									<div class="row text-left">
										<div class="col">
											총 상품금액: <span id="tot_price">${productVO.pro_price}</span>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_order"
												data-pro_num="${productVO.pro_num}">구매하기</button>
										</div>
										<div class="col-md-6">
											<button type="button" class="btn btn-link" name="btn_cart_add"
												data-pro_num="${productVO.pro_num}">장바구니</button>
										</div>
									</div>
								</div>
							</div> <!-- card-deck mb-3 text-center row 닫는 태그 -->

							<div class="row">
								<div class="col-md-12">
									<div id="tabs_pro_detail">
										<ul>
											<li><a href="#tabs-prodetail">상품 설명</a></li>
											<li><a href="#tabs-proreview">상품 후기</a></li>
										</ul>
										<div id="tabs-prodetail">
											<p>${productVO.pro_content}</p>
										</div>
										<div id="tabs-proreview">
											<p>상품후기 목록</p>
											<div class="row">
												<div class="col-md-12" id="review_list"> <!-- 정적 태그(이하 동적 태그) -->

												</div>
											</div>
											<div class="row">
												<div class="col-md-8 text-center" id="review_paging">

												</div>
												<div class="col-md-4 text-right">
													<button type="button" id="btn_review_write" class="btn btn-info">상품후기 작성</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row text-center">
								<div class="col-md-12">
									<!-- <form id="actionForm">의 용도 -->
									<!-- 1) 페이지 번호([이전] 1 2 3 4 5 ... [다음])를 클릭할 때 사용 -->
									<!-- 2) 목록에서 상품 이미지 또는 상품명을 클릭할 때 사용 -->
									<form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
										<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
										<input type="hidden" name="amount" id="amount" value="${pageMaker.cri.amount}" />
										<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
										<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
										<input type="hidden" name="cg_code" id="cg_code" value="${cg_code}" />
										<input type="hidden" name="cg_name" id="cg_name" value="${cg_name}" />
									</form>
								</div>
							</div>

							<%@include file="/WEB-INF/views/comm/footer.jsp" %>
						</div> <!-- container 닫는 태그 -->

						<!-- JSP 주석 -->
						<%-- <%@include file="/WEB-INF/views/comm/plugIn.jsp" %> --%>
							<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
								integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
								crossorigin="anonymous"></script>
							<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
								integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
								crossorigin="anonymous"></script>

							<!-- 카테고리 메뉴 자바스크립트 작업 소스-->
							<script src="/js/category_menu.js"></script>

							<script>
								$(document).ready(function () {

									let actionForm = $("#actionForm");  // 액션폼 참조

									// [이전] 1 2 3 4 5 ... [다음] 클릭 이벤트 설정. <a> 태그
									$(".movepage").on("click", function (e) {
										e.preventDefault(); // a 태그의 href 링크 기능을 제거. href 속성에 페이지 번호를 숨겨둠

										actionForm.attr("action", "/user/product/pro_list");
										// actionForm.find("input[name='pageNum']").val(선택한 페이지 번호);
										actionForm.find("input[name='pageNum']").val($(this).attr("href"));

										actionForm.submit(); // 페이지 이동 시 actionForm이 동작
									});

									// 장바구니 추가(CartVO)
									$("button[name='btn_cart_add']").on("click", function () {
										// console.log("장바구니");
										$.ajax({
											url: '/user/cart/cart_add', // url: '장바구니 추가 주소', 
											type: 'post',
											// $(this).data("pro_num"): 버튼을 눌렀을 때 동작하는 장바구니 상품코드
											data: { pro_num: $(this).data("pro_num"), cart_amount: $("#btn_quantity").val() }, // mbsp_id는 스프링에서 자체 처리
											dataType: 'text',
											success: function (result) {
												if (result == "success") {
													alert("장바구니에 추가됨");
													if (confirm("장바구니로 이동하시겠습니까?")) {
														location.href = "/user/cart/cart_list"
													}
												}
											}
										});
									});

									// 구매하기(주문)
									$("button[name='btn_order']").on("click", function () {

										let url = "/user/order/order_ready?pro_num=" + $(this).data("pro_num") + "&cart_amount=" + $("#btn_quantity").val();
										location.href = url;
									});

									// 상품 이미지 또는 상품명 클릭 시 상세로 보내는 작업
									$(".btn_pro_img").on("click", function () {
										console.log("상품 상세 설명");

										// actionForm.attr("action", "상품 상세 주소");
										actionForm.attr("action", "/user/product/pro_detail");
										let pro_num = $(this).data("pro_num");

										actionForm.find("input[name='pro_num']").remove(); // 뒤로가기 시 
										// <input type='hidden' name='pro_num' value='상품코드'> 미리 만들어서 작성
										actionForm.append("<input type='hidden' name='pro_num' value='" + pro_num + "'>")
										actionForm.submit();
									});

									// 수량 변경 시
									$("#btn_quantity").on("change", function () {
										// parseInt(): 문자열을 정수로 변환(현재 작동에서는 정상 작동해서 불필요할 수 있음. 더하기 작업 등에 쓰임)
										let tot_price = parseInt($("#unit_price").text() * $("#btn_quantity").val());

										// 총 상품금액 표시
										$("#tot_price").text(tot_price);
									});

									// 상품후기 작성 폼
									$("#btn_review_write").on("click", function () {

										$("#btn_review_modify").hide(); // 추가: 상품후기 수정하기 버튼 숨김
										$("#btn_review_save").show(); // 추가: 상품후기 수정하기 버튼 보임
										// 상품후기 수정 버튼에 후기 번호를 data-rew_num 속성으로 적용
										// $("#btn_review_modify").data("rew_num", $(this).parent().parent().find(".rew_num").text());
										$('#review_modal').modal('show')
									});

									// 평점 클릭시(평점 태그 5개 ☆☆☆☆☆) 
									$("p#star_rv_score a.rv_score").on("click", function (e) {
										e.preventDefault();

										// $(this): 클릭한 a 태그
										$(this).parent().children().removeClass("on");
										$(this).addClass("on").prevAll("a").addClass("on");
									});

									// 상품평 목록 불러오는 작업(이벤트 사용하지 않고 직접 호출)
									let reviewPage = 1; // 목록에서 첫 번째 페이지를 의미
									// @GetMapping("/list/{pro_num}/{page}")
									let url = "/user/review/list/" + "${productVO.pro_num}" + "/" + reviewPage;

									getReviewInfo(url);

									function getReviewInfo(url) {
										$.getJSON(url, function (data) {

											// console.log("상품 후기", data.list[0].rew_content);
											// console.log("페이징 정보", data.pageMaker.total);

											// review_list
											printReviewList(data.list, $("#review_list"), $("#reviewTemplate"));
											// review_paging
											printPaging(data.pageMaker, $("#review_paging"));
										});
									}

									// 1) 상품후기 작업 함수
									let printReviewList = function (reviewData, target, template) {
										let templateObj = Handlebars.compile(template.html());
										let reviewHtml = templateObj(reviewData);

										// 상품후기 목록 위치를 참조하여 추가 작업
										target.children().remove(); // $("#review_list").children().remove();
										target.append(reviewHtml);
									}

									// 2) 페이징 기능 작업 함수
									let printPaging = function (pageMaker, target) {

										let pagingStr = '<nav id="navigation" aria-label="Page navigation example">';
										pagingStr += '<ul class="pagination">';

										// 이전 표시 여부 
										if (pageMaker.prev) {
											pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startPage - 1) + '">[prev]</a></li>'
										}
										// 페이지 번호 출력
										for (let i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
											let className = pageMaker.cri.pageNum == i ? 'active' : '';
											pagingStr += '<li class="page-item ' + className + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
										}
										// 다음 표시 여부
										if (pageMaker.next) {
											pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startPage + 1) + '">[next]</a></li>'
										}

										pagingStr += '</ul>';
										pagingStr += '</nav>';

										target.children().remove(); // $("#review_paging").children().remove();
										target.append(pagingStr);
									}

									// 사용자 정의 Helper(핸들바의 함수 정의)
									// 상품후기 등록일 millisecond -> 자바스크립트의 Date 객체로 변환
									Handlebars.registerHelper("convertDate", function (reviewTime) {

										const dateObj = new Date(reviewTime);
										let year = dateObj.getFullYear();
										let month = dateObj.getMonth() + 1;
										let date = dateObj.getDate();
										let hour = dateObj.getHours();
										let minute = dateObj.getMinutes();

										return year + "/" + month + "/" + date + " " + hour + ":" + minute;
									});

									// 평점(숫자)를 별 모양으로 출력하기
									Handlebars.registerHelper("displayStar", function (rating) {
										let starStr = "";

										switch (rating) {
											case 1:
												starStr = "★☆☆☆☆";
												break;
											case 2:
												starStr = "★★☆☆☆"
												break;
											case 3:
												starStr = "★★★☆☆"
												break;
											case 4:
												starStr = "★★★★☆"
												break;
											case 5:
												starStr = "★★★★★"
												break;
										}
										return starStr;
									});

									// 상품후기 수정/삭제버튼 표시
									// 사용자 정의 Helper(핸들바의 함수 정의)
									Handlebars.registerHelper("authControlView", function (mbsp_id, rew_num, rew_score) {
										let str = "";
										let login_id = '${sessionScope.loginStatus.mbsp_id}';

										// 로그인한 사용자와 상품후기 등록 사용자의 동일 여부 체크
										if (login_id == mbsp_id) {
											str += '<button type="button" name="btn_review_edit" class="btn btn-info" data-rew_score="' + rew_score + '">edit</button>';
											str += '<button type="button" name="btn_review_del" class="btn btn-danger" data-rew_num="' + rew_num + '">delete</button>';

											console.log(str);
											// 출력 내용이 태그일 때 사용
											return new Handlebars.SafeString(str);
										}
									});

									// 상품후기 수정버튼 클릭: 상품후기 수정 폼
									$("div#review_list").on("click", "button[name='btn_review_edit']", function () {
										/*
										console.log("번호", $(this).parent().parent().find(".rew_num").text());
										console.log("내용", $(this).parent().parent().find(".rew_content").text());
										console.log("평점", $(this).parent().parent().find(".rew_score").text());
										console.log("날짜", $(this).parent().parent().find(".rew_regdate").text());
										*/

										// 평점 작업(선택자 5개)
										let rew_score = $(this).data("rew_score"); // $(this)는 수정 버튼
										console.log("평점", rew_score);
										$("#star_rv_score a.rv_score").each(function (index, item) {
											if(index < rew_score) {
												$(item).addClass("on");
											} else {
												$(item).removeClass("on");
											}
										});

										// 상품후기 내용
										$("#rew_content").text($(this).parent().parent().find(".rew_content").text());
										// 상품후기 번호
										$("#rew_num").text($(this).parent().parent().find(".rew_num").text());
										// 상품후기 등록일
										$("#rew_regdate").text($(this).parent().parent().find(".rew_regdate").text());

										$("#btn_review_save").hide(); // 추가: 상품후기 저장 버튼 숨김
										$("#btn_review_modify").show(); // 추가: 상품후기 저장 버튼 보임
										// modal() 메서드는 부트스트랩 메서드
										$('#review_modal').modal('show'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
									});

									// 상품후기 수정하기
									$("#btn_review_modify").on("click", function() {
										let rew_num = $("#rew_num").text();
										let rew_content = $("#rew_content").val();
										// 평점 
										let rew_score = 0;
										$("p#star_rv_score a.rv_score").each(function (index, item) {
											if ($(this).attr("class") == "rv_score on") {
												rew_score += 1;
											}
										});
										let review_data = {rew_num: rew_num, rew_content: rew_content, rew_score: rew_score}
										$.ajax({
											url: '/user/review/modify',
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "PUT"
											},
											type: 'put',
											data: JSON.stringify(review_data), // 데이터 포맷을 Object에서 JSON으로 변환
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 수정되었습니다.")
													$('#review_modal').modal('hide'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
													// 상품평 목록 불러오는 작업
													getReviewInfo(url);
												}
											}
										});
									});
									
									// 상품후기 수정 후 작성 클릭 시 수정내용 중복됨 clear 작업

									// 상품후기 삭제버튼 클릭
									// 하단 코드는 동적으로 생성된 거라 실행되지 않음
									/*
									$("button[name='btn_review_del']").on("click", function() {
										console.log("상품후기 삭제")
									});
									*/
									$("div#review_list").on("click", "button[name='btn_review_del']", function () {
										console.log("상품후기 삭제")

										if (!confirm("상품후기를 삭제하겠습니까?")) return;
										let rew_num = $(this).data("rew_num");

										$.ajax({
											url: '/user/review/delete/' + rew_num,
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "DELETE"
											},
											type: 'delete',
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 삭제되었습니다.")

													url = "/user/review/list/" + "${productVO.pro_num}" + "/" + reviewPage;
													getReviewInfo(url);
												}
											}
										});
									});

									// 페이징 번호 클릭
									$("div#review_paging").on("click", "nav#navigation ul a", function (e) { // "nav ul a": 동적 태그 선택자
										e.preventDefault();
										console.log("페이지 번호");

										reviewPage = $(this).attr("href"); // 상품후기 선택 페이지 번호
										url = "/user/review/list/" + "${productVO.pro_num}" + "/" + reviewPage;

										getReviewInfo(url); // 스프링에서 상품후기, 페이지 번호 데이터 가져오는 함수
									});

									// 상품후기 저장
									$("#btn_review_save").on("click", function () {
										// 평점 값
										let rew_score = 0;
										let rew_content = $("#rew_content").val();

										$("p#star_rv_score a.rv_score").each(function (index, item) {
											if ($(this).attr("class") == "rv_score on") {
												rew_score += 1;
											}
										});

										// 평점 선택 안했을 경우 체크
										if (rew_score == 0) {
											alert("평점을 선택해 주세요.");
											return;
										}

										// 후기 작성 안했을 경우
										if (rew_content == "") {
											alert("상품평을 작성해 주세요.");
											return;
										}

										// AJAX를 사용하여 스프링으로 리뷰 데이터 전송 작업
										let review_data = { pro_num: $(this).data("pro_num"), rew_content: rew_content, rew_score: rew_score }

										$.ajax({
											url: '/user/review/new',
											headers: {
												"Content-Type": "application/json", "X-HTTP-Method-Override": "POST"
											},
											type: 'post',
											data: JSON.stringify(review_data), // 데이터 포맷을 Object에서 JSON으로 변환
											dataType: 'text',
											success: function (result) {
												if (result == 'success') {
													alert("상품평이 등록되었습니다.")
													$('#review_modal').modal('hide'); // 부트스트랩 4.6 버전의 자바스크립트 명령어
													// 상품평 목록 불러오는 작업
													getReviewInfo(url);
												}
											}
										});
									});

								}); // ready event end
							</script>

							<!-- 상품후기 modal -->
							<div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<!-- <h5 class="modal-title" id="exampleModalLabel">상품후기</h5> -->
											<b>상품후기</b><span id="rew_num">5</span><span id="rew_regdate"></span>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form>
												<div class="form-group">
													<label for="recipient-name" class="col-form-label">평점</label>
													<p id="star_rv_score">
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
														<a href="#" class="rv_score">☆</a>
													</p>
												</div>
												<div class="form-group">
													<label for="message-text" class="col-form-label">내용</label>
													<textarea class="form-control" id="rew_content"></textarea>
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
											<button type="button" id="btn_review_save" class="btn btn-primary"
												data-pro_num="${productVO.pro_num}">상품후기 저장</button>
												<!-- 추가 -->
											<button type="button" id="btn_review_modify" class="btn btn-primary">상품후기 수정</button>
										</div>
									</div>
								</div>
							</div>
			</body>

			</html>