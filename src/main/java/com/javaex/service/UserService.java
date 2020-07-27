package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BlogDao;
import com.javaex.dao.CategoryDao;
import com.javaex.dao.UserDao;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.UsersVo;

@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private BlogDao blogDao;
	
	@Autowired
	private CategoryDao categoryDao; 
	
	
	public boolean idcheck(UsersVo vo) {
		System.out.println("서비스/아이디체크");
		int userStr = userDao.idcheck(vo);
		boolean result = false;
		
		if(userStr == 0)result = true;
		
		return result;
	}
	
	public int join(UsersVo userVo) {
		int user = userDao.userInsert(userVo);
		
		BlogVo blogVo = new BlogVo();
		blogVo.setId(userVo.getId());
		blogVo.setBlogTitle(userVo.getUserName()+"의 블로그입니다.");	
		blogVo.setLogoFile("default");

		int blog = blogDao.blogInsert(blogVo);
		
		CategoryVo categoryVo = new CategoryVo();
		categoryVo.setId(blogVo.getId());
		categoryVo.setCateName("미분류");
		categoryVo.setDescription("기본으로 만들어지는 카테고리 입니다.");
		
		int category = categoryDao.categoryInsert(categoryVo);
		
		if(user == 1 && blog == 1 && category == 1) return 1;
		else return 0;
		
	}
	
	public UsersVo login(UsersVo userVo) {
		return userDao.login(userVo);
	}
	
	public String getUserName(String id) {
		return userDao.getUserName(id);
	}
	
	public List<UsersVo> search(String keyword, String radio){
		
		if("optTitle".equals(radio)) {
			return userDao.titleSearch(keyword);
		}else {
			return userDao.nameSearch(keyword);
		}
	}
}
