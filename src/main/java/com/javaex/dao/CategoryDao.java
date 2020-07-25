package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CategoryVo;

@Repository
public class CategoryDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public int categoryInsert(CategoryVo categoryVo) {
		return sqlSession.insert("category.categoryInsert", categoryVo);
	}
	
	public List<CategoryVo> cateList(String id){
		return sqlSession.selectList("category.cateList", id);
	}
	
	public int maxCategoryNo(String id) {
		return sqlSession.selectOne("category.maxCategoryNo", id);
	}
	
	public int cateInsert(CategoryVo categoryVo) {
		return sqlSession.insert("category.cateInsert", categoryVo);
	}
	
	public CategoryVo getCategory(CategoryVo categoryVo) {
		return sqlSession.selectOne("category.getCategory", categoryVo);
	}
	
	public int cateDelete(CategoryVo categoryVo) {
		return sqlSession.delete("category.cateDelete", categoryVo);
	}
}
