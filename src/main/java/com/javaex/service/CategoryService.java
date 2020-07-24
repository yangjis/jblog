package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CategoryDao;
import com.javaex.vo.CategoryVo;

@Service
public class CategoryService {
	
	@Autowired
	private CategoryDao categoryDao;
	
	public List<CategoryVo> list(String id){
		return categoryDao.list(id);
	}
	
	public int maxCategory(String id) {
		return categoryDao.maxCategory(id);
	}
	
	public CategoryVo cateInsert(CategoryVo categoryVo) {
		categoryDao.cateInsert(categoryVo);
		int cateNo = categoryDao.maxCategory(categoryVo.getId()); 
		
		categoryVo.setCateNo(cateNo);
		return categoryDao.getCategory(categoryVo); 
	}
	
	public int cateDelete(CategoryVo categoryVo) {
		return categoryDao.cateDelete(categoryVo);
	}
	
}
