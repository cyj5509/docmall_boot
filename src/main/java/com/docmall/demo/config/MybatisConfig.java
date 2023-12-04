package com.docmall.demo.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import lombok.extern.slf4j.Slf4j;

//@Configuration
//@Slf4j
public class MybatisConfig {

    // @Bean =>객체 생성
	/*
    @Bean
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {        
		 // 서버구동시 이 부분 출력
         log.info("datasource configuration");
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(dataSource);
		
		Resource[] arrResource = new PathMatchingResourcePatternResolver().getResources("classpath:/mapper/*Mapper.xml");
		sqlSessionFactoryBean.setMapperLocations(arrResource);
		return sqlSessionFactoryBean.getObject();
	}
    */
}


