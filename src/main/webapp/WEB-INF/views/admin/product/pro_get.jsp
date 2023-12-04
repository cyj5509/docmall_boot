<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- JSTL Core 라이브러리 -->
    <!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
    <html>

    <head>
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <title>AdminLTE 2 | Starter</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
      <%@ include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
    </head>
    <!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->

    <body class="hold-transition skin-blue sidebar-mini">
      <div class="wrapper">
        <!-- Main Header -->
        <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

          <!-- Left side column. contains the logo and sidebar -->
          <%@ include file="/WEB-INF/views/admin/include/nav.jsp" %>

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
              <!-- Content Header (Page header) -->
              <section class="content-header">
                <h1>
                  Page Header
                  <small>Optional description</small>
                </h1>
                <ol class="breadcrumb">
                  <li>
                    <a href="#"><i class="fa fa-dashboard"></i> Level</a>
                  </li>
                  <li class="active">Here</li>
                </ol>
              </section>

              <!-- Main content -->
              <section class="content container-fluid">
                <div class="row">
                  <!-- 합이 12까지 사용 가능. 반드시 고정될 필요는 없음 -->
                  <!-- <div class="col-해상도-숫자"></div>  -->
                  <div class="col-md-12">
                    <div class="box box-primary">
                      <div class="box-header with-border">
                        <h3 class="box-title mt-5">Product View</h3>
                        <form id="actionForm" action="" method="get"> <!-- JS에서 자동 입력 -->
                          <input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
                          <input type="hidden" name="amount" id="amount" value="${cri.amount}" />
                          <input type="hidden" name="type" id="type" value="${cri.type}" />
                          <input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
                        </form>
                      </div>

                      <!-- form 태그는 글쓰기나 수정 폼에서 사용 -->
                      <form role="form" method="post" action="/admin/product/pro_get" enctype="multipart/form-data">
                        <!-- 절대 경로: /board/register와 동일 -->
                        <div class="box-body">
                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">카테고리</label>
                            <div class="col-sm-3">
                              <input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
                              <input type="hidden" name="amount" id="amount" value="${cri.amount}" />
                              <input type="hidden" name="type" id="type" value="${cri.type}" />
                              <input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
                              <select class="form-control" id="firstCategory">
                                <option>1차 카테고리 선택</option>
                                <!-- 1차 카테고리 표시. GlobalControllerAdvice -->
                                <c:forEach items="${firstCategoryList}" var="categoryVO">
                                  <option value="${categoryVO.cg_code}"
                                    ${categoryVO.cg_code==first_category.cg_parent_code ? 'selected' : '' }>
                                    ${categoryVO.cg_name}</option>
                                </c:forEach>
                              </select>
                            </div>

                            <div class="col-sm-3">
                              <select class="form-control" id="secondCategory" name="cg_code">
                                <option>2차 카테고리 선택</option>
                                <c:forEach items="${second_categoryList}" var="categoryVO">
                                  <option value="${categoryVO.cg_code}" ${categoryVO.cg_code==productVO.cg_code
                                    ? 'selected' : '' }>
                                    ${categoryVO.cg_name}</option>
                                </c:forEach>
                              </select>
                            </div>
                          </div>

                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">상품명</label>
                            <div class="col-sm-4">
                              <input type="hidden" name="pro_num" value="${productVO.pro_num }">
                              <input type="text" class="form-control" name="pro_name" id="pro_name"
                                value="${productVO.pro_name}" placeholder="상품명 입력..." />
                            </div>
                            <label for="title" class="col-sm-2 col-form-label">상품가격</label>
                            <div class="col-sm-4">
                              <input type="text" class="form-control" name="pro_price" id="pro_price"
                                value="${productVO.pro_price}" placeholder="상품가격 입력..." />
                            </div>
                          </div>

                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">할인율</label>
                            <div class="col-sm-4">
                              <input type="text" class="form-control" name="pro_discount" id="pro_discount"
                                value="${productVO.pro_discount}" placeholder="할인율 입력..." />
                            </div>
                            <label for="title" class="col-sm-2 col-form-label">제조사</label>
                            <div class="col-sm-4">
                              <input type="text" class="form-control" name="pro_publisher" id="pro_publisher"
                                value="${productVO.pro_publisher}" placeholder="제조사 입력..." />
                            </div>
                          </div>

                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">상품 이미지</label>
                            <div class="col-sm-4">
                              <input type="file" class="form-control" name="uploadFile" id="uploadFile"
                                placeholder="작성자 입력..." />
                              <!-- 상품 이미지 변경 시 기존 이미지 삭제를 위해 사용됨 -->
                              <input type="hidden" name="pro_up_folder" value="${productVO.pro_up_folder }">
                              <input type="hidden" name="pro_img" value="${productVO.pro_img }">
                              <!-- name 속성은 실제로 사용하지 않는다, 즉, ProductVO의 pro_img와는 다른 용도이다. -->
                            </div>
                            <label for="title" class="col-sm-2 col-form-label">미리보기 이미지</label>
                            <div class="col-sm-4">
                              <img id="img_preview"
                                src="/admin/product/imageDisplay?dateFolderName=${productVO.pro_up_folder }&fileName=${productVO.pro_img }"
                                style="width: 200px; height: 200px" />
                            </div>
                          </div>

                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">상품 설명</label>
                            <div class="col-sm-10">
                              <textarea class="form-control" rows="3" name="pro_content"
                                id="pro_content">${productVO.pro_content}</textarea>
                            </div>
                          </div>

                          <div class="form-group row">
                            <label for="title" class="col-sm-2 col-form-label">수량</label>
                            <div class="col-sm-4">
                              <input type="text" class="form-control" name="pro_amount" id="pro_amount"
                                value="${productVO.pro_amount}" placeholder="수량 입력..." />
                            </div>
                            <label for="title" class="col-sm-2 col-form-label">판매 여부</label>
                            <div class="col-sm-4">
                              <select class="form-control" id="pro_buy" name="pro_buy">
                                <!-- value 값이 없으면 option 사이 값이 들어감 -->
                                <!-- 상품 테이블에서 PRO_BUY CHAR(1) NOT NULL, -- VARCHAR(2) -> CHAR(1) -->
                                <!-- 기존: value값은 각각 가능, 불가능이었음 -->
                                <option value="Y" ${productVO.pro_buy}=='Y' ? 'selected' : ''>판매 가능</option>
                                <option value="N" ${productVO.pro_buy}=='N' ? 'selected' : ''>판매 불가능</option>
                              </select>
                            </div>
                          </div>
                        </div>

                        <div class="box-footer">
                          <div class="form-group">
                            <ul class="uploadedList"></ul>
                          </div>
                          <div class="text-center">
                            <button type="submit" class="btn btn-primary">
                              상품 수정
                            </button>
                            <button type="reset" class="btn btn-primary">취소</button>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </section>

              <!--------------------------
        | Your Page Content Here |
        -------------------------->

              <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->

            <!-- Main Footer -->
            <%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>

              <!-- Control Sidebar -->
              <aside class="control-sidebar control-sidebar-dark">
                <!-- Create the tabs -->
                <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                  <li class="active">
                    <a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
                  </li>
                  <li>
                    <a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
                  </li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                  <!-- Home tab content -->
                  <div class="tab-pane active" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading">Recent Activity</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;">
                          <i class="menu-icon fa fa-birthday-cake bg-red"></i>

                          <div class="menu-info">
                            <h4 class="control-sidebar-subheading">
                              Langdon's Birthday
                            </h4>

                            <p>Will be 23 on April 24th</p>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                    <h3 class="control-sidebar-heading">Tasks Progress</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;">
                          <h4 class="control-sidebar-subheading">
                            Custom Template Design
                            <span class="pull-right-container">
                              <span class="label label-danger pull-right">70%</span>
                            </span>
                          </h4>

                          <div class="progress progress-xxs">
                            <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->
                  </div>
                  <!-- /.tab-pane -->
                  <!-- Stats tab content -->
                  <div class="tab-pane" id="control-sidebar-stats-tab">
                    Stats Tab Content
                  </div>
                  <!-- /.tab-pane -->
                  <!-- Settings tab content -->
                  <div class="tab-pane" id="control-sidebar-settings-tab">
                    <form method="post">
                      <h3 class="control-sidebar-heading">General Settings</h3>

                      <div class="form-group">
                        <label class="control-sidebar-subheading">
                          Report panel usage
                          <input type="checkbox" class="pull-right" checked />
                        </label>

                        <p>Some information about this general settings option</p>
                      </div>
                      <!-- /.form-group -->
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
              </aside>
              <!-- /.control-sidebar -->
              <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
              <div class="control-sidebar-bg"></div>
      </div>
      <!-- ./wrapper -->

      <!-- REQUIRED JS SCRIPTS -->
      <%@ include file="/WEB-INF/views/admin/include/plugin2.jsp" %>
        <script src="/bower_components/ckeditor/ckeditor.js" type="text/javascript"></script>

        <script>
          $(document).ready(function () {
            // ckeditor 환경설정. 자바스크립트 Ojbect문법
            var ckeditor_config = {
              resize_enabled: false,
              enterMode: CKEDITOR.ENTER_BR,
              shiftEnterMode: CKEDITOR.ENTER_P,
              toolbarCanCollapse: true,
              removePlugins: "elementspath",
              // 업로드 탭 기능 추가 속성. CKEditor에서 파일업로드해서 서버로 전송을 클릭하면, 이 주소가 동작된다.
              filebrowserUploadUrl: "/admin/product/imageUpload",
            };

            //해당 이름으로 된 textarea에 에디터를 적용
            CKEDITOR.replace("pro_content", ckeditor_config);

            console.log("ckeditor 버전: " + CKEDITOR.version);

            // 1차 카테고리 선택
            // document.getElementById("firstCategory")
            $("#firstCategory").change(function () {
              // $(this): option 태그 중 선택한 option 태그를 가리킴
              let cg_parent_code = $(this).val();

              // console.log("1차 카테고리 코드", cg_parent_code);

              // 1차 카테고리 선택에 의한 2차 카테고리 정보를 가져오는 url
              // .json 생략해도 기능에는 이상 없지만 추후 결과가 달라질 수 있음
              let url =
                "/admin/category/secondCategory/" + cg_parent_code + ".json";

              // $.getJSON(): 스프링에 요청 시 데이터를 JSON으로 받는 기능(Ajax 기능 제공)
              $.getJSON(url, function (secondCategoryList) {
                // function() {}: 콜백함수(스프링을 콜하고 백)

                // console.log("2차 카테고리 정보", secondCategoryList);
                // console.log("2차 카테고리 개수", secondCategoryList.length);

                // 2차 카테고리 select 태그 참조
                let secondCategory = $("#secondCategory");
                let optionStr = "";

                // find("css 선택자"): 태그명, id 속성명, class 속성명
                secondCategory.find("option").remove(); // 2차 카테고리의 option 제거
                secondCategory.append(
                  "<option value=''>2차 카테고리 선택</option>"
                );

                // <option value='10'>바지</option>
                for (let i = 0; i < secondCategoryList.length; i++) {
                  optionStr +=
                    "<option value='" +
                    secondCategoryList[i].cg_code +
                    "'>" +
                    secondCategoryList[i].cg_name +
                    "</option>";
                }

                // console.log(optionStr);
                secondCategory.append(optionStr); // 2차 카테고리 option 태그들이 추가
              });
            });
            // 파일 첨부 시 이미지 미리보기
            // 파일 첨부에 따른 이벤트 관련 정보를 e라는 매개변수를 통하여 참조가 됨
            $("#uploadFile").change(function (e) {
              let file = e.target.files[0]; // 선택 파일들 중 첫 번째 파일
              let reader = new FileReader(); // 첨부된 파일을 이용하여, File 객체를 생성하는 용도

              reader.readAsDataURL(file); // reader 객체에 파일 정보가 할당
              reader.onload = function (e) {
                // <img id="img_preview" style="width: 200px; height: 200px" />
                // e.targer.result: reader 객체의 이미지 파일 정보
                $("#img_preview").attr("src", e.target.result);
              };
            });
          });
        </script>
    </body>

    </html>