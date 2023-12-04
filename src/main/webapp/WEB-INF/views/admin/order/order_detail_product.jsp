<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- JSTL Core태그 라이브러리 -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <table class="table table-sm">
                <caption style="display: table-caption; text-align: center; color: red; font-weight: bold;">
                    [주문상세 정보]</caption>
                <thead>
                    <tr>
                        <th scope="col">주문번호</th>
                        <th scope="col">상품코드</th>
                        <th scope="col">상품이미지</th>
                        <th scope="col">상품명</th>
                        <th scope="col">주문수량</th>
                        <th scope="col">주문금액</th>
                        <th scope="col">비고</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- ${orderProductList}: Model로 전달한 값, orderProductVO는 OrderDetailProductVO를 가리킴 -->
                    <c:forEach items="${orderProductList}" var="orderProductVO">
                        <tr>
                            <th scope="row">${orderProductVO.orderDetailVO.ord_code}</th>
                            <td>${orderProductVO.productVO.pro_num}</td>
                            <td><img
                                    src="/admin/order/imageDisplay?dateFolderName=${orderProductVO.productVO.pro_up_folder}&fileName=${orderProductVO.productVO.pro_img}">
                            </td>
                            <td>${orderProductVO.productVO.pro_name}</td>
                            <td>${orderProductVO.orderDetailVO.dt_amount}</td>
                            <td>${orderProductVO.orderDetailVO.dt_amount * orderProductVO.productVO.pro_price}</td>
                            <!-- 두 개의 기본키 성격을 가지는 데이터를 복합키로 설정한 경우 두 개의 데이터를 모두 사용해야 한다. -->
                            <!-- ord_code만 사용 시 상품 일부 삭제가 아닌 전체 삭제, pro_num만 사용 시 타인의 주문까지 삭제 -->
                            <td><button type="button" name="btn_order_delete" class="btn btn-danger"
                                        data-ord_code="${orderProductVO.orderDetailVO.ord_code}"
                                        data-pro_num="${orderProductVO.productVO.pro_num}">delete</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>