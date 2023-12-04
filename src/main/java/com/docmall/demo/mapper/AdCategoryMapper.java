package com.docmall.demo.mapper;

import java.util.List;

import com.docmall.demo.domain.CategoryVO;

/*
Mapper 인터페이스 대신 아래 형태로 사용함
interface AdCategoryDAO

@Repository // DB 연동 어노테이션
class AdCategoryDAOImpl
*/
// @Mapper 생략
public interface AdCategoryMapper {

	List<CategoryVO> getFirstCategoryList();
	
	List<CategoryVO> getSecondCategoryList(Integer cg_parent_code);
	
	CategoryVO get(Integer cg_code);
}
