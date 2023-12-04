package com.docmall.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.docmall.demo.interceptor.UserInterceptor;

@Component
public class WebMvcConfiguration implements WebMvcConfigurer {

	@Autowired
	UserInterceptor userInterceptor;
	
	// 인터셉터 설정에서 제외되는 경로
	private static final String[] EXCLUDE_PATHS = {
			
	};

	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		registry.addInterceptor(userInterceptor)
				.excludePathPatterns(EXCLUDE_PATHS) // 인터셉터에 포함되지 않음
				// 인터셉터에 포함됨
				.addPathPatterns("/member/confirmPw", "/member/modify", "/member/mypage", "/member/delConfirmPw")		
				.addPathPatterns("/user/cart/*") 
				.addPathPatterns("/user/order/*");
		
	}
	
	
	
	
	
}
