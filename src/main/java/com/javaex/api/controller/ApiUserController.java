package com.javaex.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.CategoryService;
import com.javaex.service.UserService;
import com.javaex.vo.CategoryVo;

@RequestMapping("/api")
@Controller
public class ApiUserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CategoryService categoryService;
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public boolean idcheck(@RequestParam("userId") String id) {
		System.out.println("아작스/아이디 체크");

		return userService.idcheck(id);
		
	}
	
	@ResponseBody
	@RequestMapping("/cateInsert")
	public CategoryVo cateInsert(@RequestBody CategoryVo categoryVo) {
		System.out.println("카테고리 추가 api컨트롤러");
		return categoryService.cateInsert(categoryVo);
	}
	
	@ResponseBody
	@RequestMapping("/cateDelete")
	public int cateDelete(@RequestBody CategoryVo categoryVo) {
		System.out.println("카테고리 삭제 api컨트롤러");
		return categoryService.cateDelete(categoryVo);
	}
}
