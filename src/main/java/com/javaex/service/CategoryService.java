package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CategoryDao;
import com.javaex.dao.PostDao;
import com.javaex.vo.CategoryVo;

@Service
public class CategoryService {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private PostDao postDao;
	
	public List<CategoryVo> cateList(String id){
		return categoryDao.cateList(id);
	}
	
	public int maxCategory(String id) {
		return categoryDao.maxCategoryNo(id);
	}
	
	public CategoryVo cateInsert(CategoryVo categoryVo) {
		categoryDao.cateInsert(categoryVo);
		int cateNo = categoryDao.maxCategoryNo(categoryVo.getId()); 
		
		categoryVo.setCateNo(cateNo);
		return categoryDao.getCategory(categoryVo); 
	}
	
	public int cateDelete(CategoryVo categoryVo) {
		
		if(postDao.allPost(categoryVo.getCateNo()) != 0) {
			return 0;
		}else {
			return categoryDao.cateDelete(categoryVo);
		}
		
	}
	
}
