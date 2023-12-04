<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL 문법 -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

      <header class="main-header">

        <!-- Logo -->
        <a href="index2.html" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>A</b>LT</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>Admin</b>LTE</span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            
            <ul class="nav navbar-nav">
              <li class="dropdown messages-menu">
                <a href="/">[DocMall]</a>
              </li>
            </ul>

            <ul class="nav navbar-nav">
              <li class="dropdown messages-menu">
                <a href="#">최근 접속 시간: [
                  <fmt:formatDate value="${sessionScope.adminStatus.admin_visit_date}" pattern="yyyy-MM-dd HH:mm:ss" />]
                </a>
              </li>
            </ul>
            <c:if test="${sessionScope.adminStatus != null}">
              <ul class="nav navbar-nav">
                <li class="dropdown messages-menu">
                  <a href="/admin/logout">로그아웃</a>
                </li>
              </ul>
            </c:if>
          </div>
        </nav>
      </header>