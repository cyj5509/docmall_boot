package com.docmall.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity // @Configuration
public class SecurityConfig {

	@Bean // Spring MVC에서는 security 폴더의 spring-security.xml 파일에서 Bean 생성
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	// 스프링 시큐리티 설정(인터셉터와 유사함)
	// 아래 설정을 하지 않으면 시큐리티에서 제공하는 로그인 페이지가 작동한다.
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
			.csrf().disable();
		/*
		시큐리지 관련 설정을 여기에서 한다.
		 */
		return http.build();
	}
}
