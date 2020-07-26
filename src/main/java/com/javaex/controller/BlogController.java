package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.PostService;
import com.javaex.service.UserService;
import com.javaex.util.Paging;
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
	public String BlogMain(@PathVariable String id, Model model, @ModelAttribute() PostVo postVo, @RequestParam("pg") int pg) {
		System.out.println("블로그 메인");
		
		if(userService.idcheck(id) == true) {
			return "/error/403";
		}
		
		model.addAttribute("blogVo", blogService.blogInformation(id));
		model.addAttribute("cateList", categoryService.cateList(id));
		model.addAttribute("postVo", postService.getPost(postVo, id));
		model.addAttribute("userName", userService.getUserName(id));
		model.addAttribute("postMap", postService.postList(id, postVo, pg));
		return "/blog/blog-main";
	}


}
