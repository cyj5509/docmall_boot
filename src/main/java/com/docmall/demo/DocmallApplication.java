package com.docmall.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(basePackages = {"com.docmall.demo.mapper"})
@SpringBootApplication
public class DocmallApplication {

	public static void main(String[] args) {
		SpringApplication.run(DocmallApplication.class, args);
	}

}
