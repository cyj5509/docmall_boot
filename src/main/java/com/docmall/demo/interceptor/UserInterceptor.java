package com.docmall.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.docmall.demo.domain.MemberVO;

import lombok.extern.slf4j.Slf4j;

// 인터셉터 기능을 적용하기 위한 준비
// 1. 인터셉터 클래스를 생성 후 HandlerInterceptorAdapter 추상 클래스를 상속한다.
// 2. HandlerInterceptorAdapter 추상 클래스의 주요 3가지 메서드를 재정의한다.
// 3. 인터셉터 클래스를 사용하기 위해 servlet-context.xml에서 설정을 해야 한다.

//[참고] https://velog.io/@dnflekf2748/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9D%B8%ED%84%B0%EC%85%89%ED%84%B0Interceptor

@Component
@Slf4j
public class UserInterceptor implements HandlerInterceptor {

	// postHandle, afterCompletion 메서드 제외
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		boolean result = false;
		
		// 현재 클라이언트의 세션을 통한 인증 상태에 대해 확인 작업을 할 수 있다.
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		
		if (user == null) {
			// 인증 정보가 없는 경우로 컨트롤러 미진행
			result = false; // 세션(loginStatus) 정보가 부존재(로그인 X)
			if (isAjaxRequest(request)) {
				response.sendError(400); // 클라이언트 AJAX의 error 콜백 함수에서 사용
			} else {
				getTargetUrl(request); // 이전 페이지에 대한 정보를 가지고 있음
				response.sendRedirect("/member/login"); // response.sendRedirect(location);
			}
		} else {
			// 인증 정보가 있는 경우로 컨트롤러 진행
			result = true; // 세션(loginStatus) 정보가 존재(로그인 O)
		}
		
		return result; // return super.preHandle(request, response, handler);
	}

	// 인증되지 않은 상태에서 사용자가 요청한 URL을 저장하고, 로그인 후 URL로 리디렉션 작업
	private void getTargetUrl(HttpServletRequest request) {

		// 요청주소: http://localhost:8080/member/modify?userid=doccomsa
		String uri = request.getRequestURI(); // uri는 /member/modify
		String query = request.getQueryString(); // query는 userid=doccomsa
		
		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		String targetUrl = uri + query;
		
		if (request.getMethod().equals("GET")) {
			request.getSession().setAttribute("targetUrl", targetUrl);
		}
	}
	
	// 사용자 요청이 AJAX 요청인지 확인하기 위한 목적
	private boolean isAjaxRequest(HttpServletRequest request) {
		
		boolean isAjax = false;
		String header = request.getHeader("AJAX");
		if (header != null && header.equals("true")) {
			isAjax = true;
		}
		return isAjax;
	}
	
}
