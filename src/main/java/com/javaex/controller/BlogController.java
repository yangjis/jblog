package com.javaex.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.PostService;
import com.javaex.service.UserService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;

@RequestMapping("/{id}")
@Controller
public class BlogController {
	
	@Autowired
	private BlogService blogService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("")
	public String BlogMain(@PathVariable String id, Model model, @ModelAttribute("getPost") PostVo postVo) {
		System.out.println("블로그 메인");
		
		if(userService.idcheck(id) == true) {
			return "/error/403";
		}
		
		model.addAttribute("blogVo", blogService.blogInformation(id));
		model.addAttribute("cateList", categoryService.list(id));
		model.addAttribute("postVo", postService.getPost(postVo, id));
		model.addAttribute("userName", userService.getUserName(id));
		model.addAttribute("postList", postService.postList(id, postVo));
		return "/blog/blog-main";
	}


}
